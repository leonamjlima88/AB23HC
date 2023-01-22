unit uSaleItem.SQLBuilder;

interface

uses
  uSaleItem.SQLBuilder.Interfaces,
  cqlbr.interfaces,
  uBase.Entity;

type
  TSaleItemSQLBuilder = class(TInterfacedObject, ISaleItemSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    function ScriptCreateTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectAll: String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function DeleteBySaleId(ASaleId: Int64): String;
    function SelectBySaleId(ASaleId: Int64): String;
    function ReportById(ASaleId: Int64): String;
  end;

implementation

uses
  criteria.query.language,
  System.SysUtils,
  uSaleItem,
  uApplication.Types,
  uZLConnection.Types;

{ TSaleItemSQLBuilder }
constructor TSaleItemSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TSaleItemSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('sale_item')
    .Where('sale_item.id = ' + AId.ToString)
  .AsString;
end;

function TSaleItemSQLBuilder.DeleteBySaleId(ASaleId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('sale_item')
    .Where('sale_item.sale_id = ' + ASaleId.ToString)
  .AsString;
end;

function TSaleItemSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lSaleItem: TSaleItem;
begin
  lSaleItem := AEntity as TSaleItem;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('sale_item')
    .&Set('sale_id', lSaleItem.sale_id)
    .&Set('product_id',           lSaleItem.product_id)
    .&Set('note',                 lSaleItem.note)
    .&Set('quantity',             lSaleItem.quantity)
    .&Set('price',                lSaleItem.price)
    .&Set('unit_discount',        lSaleItem.unit_discount)

  .AsString;
end;

function TSaleItemSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TSaleItemSQLBuilder.ReportById(ASaleId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('sale_item.*')
    .Column('product.sku_code').&As('product_sku_code')
    .Column('product.name').&As('product_name')
    .Column('unit.name').&As('product_unit_name')
    .Column('(sale_item.quantity*sale_item.price)-(sale_item.quantity*sale_item.unit_discount)').&As('total')
    .From('sale_item')
    .InnerJoin('product')
          .&On('product.id = sale_item.product_id')
    .InnerJoin('unit')
          .&On('unit.id = product.unit_id')
    .Where('sale_item.sale_id = ' + ASaleId.ToString)
    .OrderBy('sale_item.id')
  .AsString;
end;

function TSaleItemSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('sale_item.*')
    .Column('product.name').&As('product_name')
    .Column('unit.id').&As('product_unit_id')
    .Column('unit.name').&As('product_unit_name')
    .From('sale_item')
    .InnerJoin('product')
          .&On('product.id = sale_item.product_id')
    .InnerJoin('unit')
          .&On('unit.id = product.unit_id')
  .AsString;
end;

function TSaleItemSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE sale_item.id = ' + AId.ToString;
end;

function TSaleItemSQLBuilder.SelectBySaleId(ASaleId: Int64): String;
begin
  Result :=SelectAll + ' WHERE sale_item.sale_id = ' + ASaleId.ToString;
end;

function TSaleItemSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lSaleItem: TSaleItem;
begin
  lSaleItem := AEntity as TSaleItem;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('sale_item')
    .&Set('sale_id', lSaleItem.sale_id)
    .&Set('product_id',           lSaleItem.product_id)
    .&Set('note',                 lSaleItem.note)
    .&Set('quantity',             lSaleItem.quantity)
    .&Set('price',                lSaleItem.price)
    .&Set('unit_discount',        lSaleItem.unit_discount)
    .Where('sale_item.id = ' + AId.ToString)
  .AsString;
end;

end.
