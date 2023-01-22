unit uBusinessProposalItem.SQLBuilder;

interface

uses
  uBusinessProposalItem.SQLBuilder.Interfaces,
  cqlbr.interfaces,
  uBase.Entity;

type
  TBusinessProposalItemSQLBuilder = class(TInterfacedObject, IBusinessProposalItemSQLBuilder)
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
    function DeleteByBusinessProposalId(ABusinessProposalId: Int64): String;
    function SelectByBusinessProposalId(ABusinessProposalId: Int64): String;
    function ReportById(ABusinessProposalId: Int64): String;
  end;

implementation

uses
  criteria.query.language,
  System.SysUtils,
  uBusinessProposalItem,
  uApplication.Types,
  uZLConnection.Types;

{ TBusinessProposalItemSQLBuilder }
constructor TBusinessProposalItemSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TBusinessProposalItemSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('business_proposal_item')
    .Where('business_proposal_item.id = ' + AId.ToString)
  .AsString;
end;

function TBusinessProposalItemSQLBuilder.DeleteByBusinessProposalId(ABusinessProposalId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('business_proposal_item')
    .Where('business_proposal_item.business_proposal_id = ' + ABusinessProposalId.ToString)
  .AsString;
end;

function TBusinessProposalItemSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lBusinessProposalItem: TBusinessProposalItem;
begin
  lBusinessProposalItem := AEntity as TBusinessProposalItem;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('business_proposal_item')
    .&Set('business_proposal_id', lBusinessProposalItem.business_proposal_id)
    .&Set('product_id',           lBusinessProposalItem.product_id)
    .&Set('note',                 lBusinessProposalItem.note)
    .&Set('quantity',             lBusinessProposalItem.quantity)
    .&Set('price',                lBusinessProposalItem.price)
    .&Set('unit_discount',        lBusinessProposalItem.unit_discount)

  .AsString;
end;

function TBusinessProposalItemSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TBusinessProposalItemSQLBuilder.ReportById(ABusinessProposalId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('business_proposal_item.*')
    .Column('product.sku_code').&As('product_sku_code')
    .Column('product.name').&As('product_name')
    .Column('unit.name').&As('product_unit_name')
    .Column('(business_proposal_item.quantity*business_proposal_item.price)-(business_proposal_item.quantity*business_proposal_item.unit_discount)').&As('total')
    .From('business_proposal_item')
    .InnerJoin('product')
          .&On('product.id = business_proposal_item.product_id')
    .InnerJoin('unit')
          .&On('unit.id = product.unit_id')
    .Where('business_proposal_item.business_proposal_id = ' + ABusinessProposalId.ToString)
    .OrderBy('business_proposal_item.id')
  .AsString;
end;

function TBusinessProposalItemSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('business_proposal_item.*')
    .Column('product.name').&As('product_name')
    .Column('unit.id').&As('product_unit_id')
    .Column('unit.name').&As('product_unit_name')
    .From('business_proposal_item')
    .InnerJoin('product')
          .&On('product.id = business_proposal_item.product_id')
    .InnerJoin('unit')
          .&On('unit.id = product.unit_id')
  .AsString;
end;

function TBusinessProposalItemSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE business_proposal_item.id = ' + AId.ToString;
end;

function TBusinessProposalItemSQLBuilder.SelectByBusinessProposalId(ABusinessProposalId: Int64): String;
begin
  Result :=SelectAll + ' WHERE business_proposal_item.business_proposal_id = ' + ABusinessProposalId.ToString;
end;

function TBusinessProposalItemSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lBusinessProposalItem: TBusinessProposalItem;
begin
  lBusinessProposalItem := AEntity as TBusinessProposalItem;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('business_proposal_item')
    .&Set('business_proposal_id', lBusinessProposalItem.business_proposal_id)
    .&Set('product_id',           lBusinessProposalItem.product_id)
    .&Set('note',                 lBusinessProposalItem.note)
    .&Set('quantity',             lBusinessProposalItem.quantity)
    .&Set('price',                lBusinessProposalItem.price)
    .&Set('unit_discount',        lBusinessProposalItem.unit_discount)
    .Where('business_proposal_item.id = ' + AId.ToString)
  .AsString;
end;

end.
