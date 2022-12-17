unit uProduct.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uProduct,
  criteria.query.language,
  uProduct.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TProductSQLBuilder = class(TInterfacedObject, IProductSQLBuilder)
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
  cqlbr.interfaces,
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
    .&Set('name',                   lProduct.name)
    .&Set('simplified_name',        lProduct.simplified_name)
    .&Set('type',                   Ord(lProduct.&type))
    .&Set('sku_code',               lProduct.sku_code)
    .&Set('ean_code',               lProduct.ean_code)
    .&Set('manufacturing_code',     lProduct.manufacturing_code)
    .&Set('identification_code',    lProduct.identification_code)
    .&Set('cost',                   Extended(lProduct.cost))
    .&Set('marketup',               Extended(lProduct.marketup))
    .&Set('price',                  Extended(lProduct.price))
    .&Set('current_quantity',       Extended(lProduct.current_quantity))
    .&Set('minimum_quantity',       Extended(lProduct.minimum_quantity))
    .&Set('maximum_quantity',       Extended(lProduct.maximum_quantity))
    .&Set('gross_weight',           Extended(lProduct.gross_weight))
    .&Set('net_weight',             Extended(lProduct.net_weight))
    .&Set('packing_weight',         Extended(lProduct.packing_weight))
    .&Set('is_to_move_the_stock',   lProduct.is_to_move_the_stock)
    .&Set('is_product_for_scales',  lProduct.is_product_for_scales)
    .&Set('internal_note',          lProduct.internal_note)
    .&Set('complement_note',        lProduct.complement_note)
    .&Set('is_discontinued',        lProduct.is_discontinued)
    .&Set('genre',                  Ord(lProduct.genre))
    .&Set('created_at',             lProduct.created_at)
    .&Set('created_by_acl_user_id', lProduct.created_by_acl_user_id);

  // Tratar chaves estrangeiras
  if (lProduct.unit_id > 0)             then lCQL.&Set('unit_id',             lProduct.unit_id);
  if (lProduct.category_id > 0)         then lCQL.&Set('category_id',         lProduct.category_id);
  if (lProduct.brand_id > 0)            then lCQL.&Set('brand_id',            lProduct.brand_id);
  if (lProduct.size_id > 0)             then lCQL.&Set('size_id',             lProduct.size_id);
  if (lProduct.storage_location_id > 0) then lCQL.&Set('storage_location_id', lProduct.storage_location_id);

  Result := lCQL.AsString;
end;

function TProductSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
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
    .&Set('name',                   lProduct.name)
    .&Set('simplified_name',        lProduct.simplified_name)
    .&Set('type',                   Ord(lProduct.&type))
    .&Set('sku_code',               lProduct.sku_code)
    .&Set('ean_code',               lProduct.ean_code)
    .&Set('manufacturing_code',     lProduct.manufacturing_code)
    .&Set('identification_code',    lProduct.identification_code)
    .&Set('cost',                   Extended(lProduct.cost))
    .&Set('marketup',               Extended(lProduct.marketup))
    .&Set('price',                  Extended(lProduct.price))
    .&Set('current_quantity',       Extended(lProduct.current_quantity))
    .&Set('minimum_quantity',       Extended(lProduct.minimum_quantity))
    .&Set('maximum_quantity',       Extended(lProduct.maximum_quantity))
    .&Set('gross_weight',           Extended(lProduct.gross_weight))
    .&Set('net_weight',             Extended(lProduct.net_weight))
    .&Set('packing_weight',         Extended(lProduct.packing_weight))
    .&Set('is_to_move_the_stock',   lProduct.is_to_move_the_stock)
    .&Set('is_product_for_scales',  lProduct.is_product_for_scales)
    .&Set('internal_note',          lProduct.internal_note)
    .&Set('complement_note',        lProduct.complement_note)
    .&Set('is_discontinued',        lProduct.is_discontinued)
    .&Set('genre',                  Ord(lProduct.genre))
    .&Set('updated_at',             lProduct.updated_at)
    .&Set('updated_by_acl_user_id', lProduct.updated_by_acl_user_id);

  // Tratar chaves estrangeiras
  if (lProduct.unit_id > 0)             then lCQL.&Set('unit_id',             lProduct.unit_id);
  if (lProduct.category_id > 0)         then lCQL.&Set('category_id',         lProduct.category_id);
  if (lProduct.brand_id > 0)            then lCQL.&Set('brand_id',            lProduct.brand_id);
  if (lProduct.size_id > 0)             then lCQL.&Set('size_id',             lProduct.size_id);
  if (lProduct.storage_location_id > 0) then lCQL.&Set('storage_location_id', lProduct.storage_location_id);

  Result := lCQL.Where('product.id = ' + AId.ToString).AsString;
end;

end.
