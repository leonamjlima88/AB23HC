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
    function DeleteById(AId: Int64): String;
    function SelectAll: String;
    function SelectById(AId: Int64): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function RegisteredFields(AColumName, AColumnValue: String; AId: Int64): String;
  end;

implementation

uses
  cqlbr.select.mysql,
  cqlbr.serialize.mysql,
  System.Classes,
  System.SysUtils,
  uConnection.Types,
  uApplication.Types;

{ TProductSQLBuilder }
constructor TProductSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TProductSQLBuilder.DeleteById(AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('product')
    .Where('product.id = ' + AId.ToString)
  .AsString;
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
    .&Set('created_by_acl_user_id', lProduct.created_by_acl_user_id);

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
begin
  ACQL
    .&Set('name',                   AProduct.name)
    .&Set('simplified_name',        AProduct.simplified_name)
    .&Set('type',                   Ord(AProduct.&type))
    .&Set('sku_code',               AProduct.sku_code)
    .&Set('ean_code',               AProduct.ean_code)
    .&Set('manufacturing_code',     AProduct.manufacturing_code)
    .&Set('identification_code',    AProduct.identification_code)
    .&Set('cost',                   Extended(AProduct.cost))
    .&Set('marketup',               Extended(AProduct.marketup))
    .&Set('price',                  Extended(AProduct.price))
    .&Set('current_quantity',       Extended(AProduct.current_quantity))
    .&Set('minimum_quantity',       Extended(AProduct.minimum_quantity))
    .&Set('maximum_quantity',       Extended(AProduct.maximum_quantity))
    .&Set('gross_weight',           Extended(AProduct.gross_weight))
    .&Set('net_weight',             Extended(AProduct.net_weight))
    .&Set('packing_weight',         Extended(AProduct.packing_weight))
    .&Set('is_to_move_the_stock',   AProduct.is_to_move_the_stock)
    .&Set('is_product_for_scales',  AProduct.is_product_for_scales)
    .&Set('internal_note',          AProduct.internal_note)
    .&Set('complement_note',        AProduct.complement_note)
    .&Set('is_discontinued',        AProduct.is_discontinued)
    .&Set('genre',                  Ord(AProduct.genre));

  // Tratar chaves estrangeiras
  if (AProduct.unit_id > 0)             then ACQL.&Set('unit_id',             AProduct.unit_id);
  if (AProduct.category_id > 0)         then ACQL.&Set('category_id',         AProduct.category_id);
  if (AProduct.brand_id > 0)            then ACQL.&Set('brand_id',            AProduct.brand_id);
  if (AProduct.size_id > 0)             then ACQL.&Set('size_id',             AProduct.size_id);
  if (AProduct.storage_location_id > 0) then ACQL.&Set('storage_location_id', AProduct.storage_location_id);
end;

function TProductSQLBuilder.RegisteredFields(AColumName, AColumnValue: String; AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column(AColumName)
    .From('product')
    .Where(AColumName).Equal(AColumnValue)
    .&And('product.id').NotEqual(AId)
  .AsString;
end;

function TProductSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('product.*')
    .Column('unit.name').&As('unit_name')
    .Column('category.name').&As('category_name')
    .Column('brand.name').&As('brand_name')
    .Column('size.name').&As('size_name')
    .Column('storage_location.name').&As('storage_location_name')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('product')
    .InnerJoin('unit')
          .&On('unit.id = product.unit_id')
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

function TProductSQLBuilder.SelectById(AId: Int64): String;
begin
  Result := SelectAll + ' WHERE product.id = ' + AId.ToString;
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
  Result := lCQL.Where('product.id = ' + AId.ToString).AsString;
end;

end.
