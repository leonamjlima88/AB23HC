unit uProduct.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uProduct,
  criteria.query.language,
  uProduct.SQLBuilder.Interfaces,
  cqlbr.interfaces,
  uBase.Entity;

type
  TProductSQLBuilder = class(TInterfacedObject, IProductSQLBuilder)
  private
    procedure LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const AProduct: TProduct);
  public
    FDBName: TDBName;
    constructor Create;

    // Product
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectAll: String;
    function SelectById(AId: Int64; ATenantId: Int64 = 0): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function RegisteredFields(AColumName, AColumnValue: String; AId, ATenantId: Int64): String;
    function SelectBySkuOrEanCode(ASkuOrEanCode: String; ATenantId: Int64): String;
  end;

implementation

uses
  cqlbr.select.mysql,
  cqlbr.serialize.mysql,
  System.Classes,
  System.SysUtils,
  uZLConnection.Types,
  uApplication.Types, uHlp;

{ TProductSQLBuilder }
constructor TProductSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TProductSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
var
  lCQL: ICQL;
begin
  lCQL := TCQL.New(FDBName)
    .Delete
    .From('product')
    .Where('product.id = ' + AId.ToString);

  if (ATenantId > 0) then
    lCQL.&And('product.tenant_id = ' + ATenantId.ToString);

  Result := lCQL.AsString;
end;

function TProductSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lProduct: TProduct;
  lCQL: ICQL;
begin
  lProduct := AEntity as TProduct;
  lCQL := TCQL.New(FDBName)
    .Insert
    .Into('product')
    .&Set('created_at',             lProduct.created_at)
    .&Set('created_by_acl_user_id', lProduct.created_by_acl_user_id)
    .&Set('tenant_id',              lProduct.tenant_id);

  // Carregar campos default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lProduct);

  // Retornar String SQL
  Result := lCQL.AsString;
end;

function TProductSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

procedure TProductSQLBuilder.LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const AProduct: TProduct);
const
  LDECIMAL_PLACES = 4;
begin
  ACQL
    .&Set('name',                   AProduct.name)
    .&Set('simplified_name',        AProduct.simplified_name)
    .&Set('type',                   Ord(AProduct.&type))
    .&Set('sku_code',               AProduct.sku_code)
    .&Set('ean_code',               AProduct.ean_code)
    .&Set('manufacturing_code',     AProduct.manufacturing_code)
    .&Set('identification_code',    AProduct.identification_code)
    .&Set('cost',                   AProduct.cost, LDECIMAL_PLACES)
    .&Set('marketup',               AProduct.marketup, LDECIMAL_PLACES)
    .&Set('price',                  AProduct.price, LDECIMAL_PLACES)
    .&Set('current_quantity',       AProduct.current_quantity, LDECIMAL_PLACES)
    .&Set('minimum_quantity',       AProduct.minimum_quantity, LDECIMAL_PLACES)
    .&Set('maximum_quantity',       AProduct.maximum_quantity, LDECIMAL_PLACES)
    .&Set('gross_weight',           AProduct.gross_weight, LDECIMAL_PLACES)
    .&Set('net_weight',             AProduct.net_weight, LDECIMAL_PLACES)
    .&Set('packing_weight',         AProduct.packing_weight, LDECIMAL_PLACES)
    .&Set('is_to_move_the_stock',   AProduct.is_to_move_the_stock)
    .&Set('is_product_for_scales',  AProduct.is_product_for_scales)
    .&Set('internal_note',          AProduct.internal_note)
    .&Set('complement_note',        AProduct.complement_note)
    .&Set('is_discontinued',        AProduct.is_discontinued)
    .&Set('genre',                  Ord(AProduct.genre))
    .&Set('unit_id',                THlp.If0RetNull(AProduct.unit_id))
    .&Set('ncm_id',                 THlp.If0RetNull(AProduct.ncm_id))
    .&Set('category_id',            THlp.If0RetNull(AProduct.category_id))
    .&Set('brand_id',               THlp.If0RetNull(AProduct.brand_id))
    .&Set('size_id',                THlp.If0RetNull(AProduct.size_id))
    .&Set('storage_location_id',    THlp.If0RetNull(AProduct.storage_location_id));
end;

function TProductSQLBuilder.RegisteredFields(AColumName, AColumnValue: String; AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column(AColumName)
    .From('product')
    .Where(AColumName).Equal(AColumnValue)
    .&And('product.id').NotEqual(AId)
    .&And('product.tenant_id').Equal(ATenantId)
  .AsString;
end;

function TProductSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('product.*')
    .Column('unit.name').&As('unit_name')
    .Column('ncm.name').&As('ncm_name')
    .Column('ncm.ncm').&As('ncm_ncm')
    .Column('category.name').&As('category_name')
    .Column('brand.name').&As('brand_name')
    .Column('size.name').&As('size_name')
    .Column('storage_location.name').&As('storage_location_name')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('product')
    .InnerJoin('unit')
          .&On('unit.id = product.unit_id')
    .InnerJoin('ncm')
          .&On('ncm.id = product.ncm_id')
    .LeftJoin('category')
         .&On('category.id = product.category_id')
    .LeftJoin('brand')
         .&On('brand.id = product.brand_id')
    .LeftJoin('size')
         .&On('size.id = product.size_id')
    .LeftJoin('storage_location')
         .&On('storage_location.id = product.storage_location_id')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = product.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = product.updated_by_acl_user_id')
  .AsString;
end;

function TProductSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'product.id', ddMySql);
  end;
end;

function TProductSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE product.id = ' + AId.ToString;
  if (ATenantId > 0) then
    Result := Result + ' AND product.tenant_id = ' + ATenantId.ToString;
end;

function TProductSQLBuilder.SelectBySkuOrEanCode(ASkuOrEanCode: String; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE (product.sku_code = ' + ASkuOrEanCode.Trim + ' OR product.ean_code = ' + ASkuOrEanCode.Trim + ')';
  if (ATenantId > 0) then
    Result := Result + ' AND product.tenant_id = ' + ATenantId.ToString;
end;

function TProductSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lProduct: TProduct;
  lCQL: ICQL;
begin
  lProduct := AEntity as TProduct;
  lCQL := TCQL.New(FDBName)
    .Update('product')
    .&Set('updated_at',             lProduct.updated_at)
    .&Set('updated_by_acl_user_id', lProduct.updated_by_acl_user_id);

  // Carregar campos default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lProduct);

  // Retornar String SQL
  Result := lCQL
    .Where('product.id = '       + AId.ToString)
    .&And('product.tenant_id = ' + lProduct.tenant_id.ToString)
  .AsString;
end;

end.
