unit uSalePayment.SQLBuilder;

interface

uses
  uSalePayment.SQLBuilder.Interfaces,
  cqlbr.interfaces,
  uBase.Entity;

type
  TSalePaymentSQLBuilder = class(TInterfacedObject, ISalePaymentSQLBuilder)
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
  uSalePayment,
  uApplication.Types,
  uZLConnection.Types,
  uHlp;

{ TSalePaymentSQLBuilder }
constructor TSalePaymentSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TSalePaymentSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('sale_payment')
    .Where('sale_payment.id = ' + AId.ToString)
  .AsString;
end;

function TSalePaymentSQLBuilder.DeleteBySaleId(ASaleId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('sale_payment')
    .Where('sale_payment.sale_id = ' + ASaleId.ToString)
  .AsString;
end;

function TSalePaymentSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lSalePayment: TSalePayment;
begin
  lSalePayment := AEntity as TSalePayment;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('sale_payment')
    .&Set('sale_id',         lSalePayment.sale_id)
    .&Set('bank_account_id', THlp.If0RetNull(lSalePayment.bank_account_id))
    .&Set('document_id',     THlp.If0RetNull(lSalePayment.document_id))
    .&Set('expiration_date', lSalePayment.expiration_date)
    .&Set('amount',          lSalePayment.amount)
    .&Set('note',            lSalePayment.note)
  .AsString;
end;

function TSalePaymentSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TSalePaymentSQLBuilder.ReportById(ASaleId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('sale_payment.*')
    .From('sale_payment')
    .Where('sale_payment.sale_id = ' + ASaleId.ToString)
    .OrderBy('sale_payment.id')
  .AsString;
end;

function TSalePaymentSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('sale_payment.*')
    .Column('bank_account.name').&As('bank_account_name')
    .Column('document.name').&As('document_name')
    .From('sale_payment')
    .InnerJoin('bank_account')
          .&On('bank_account.id = sale_payment.bank_account_id')
    .InnerJoin('document')
          .&On('document.id = sale_payment.document_id')
  .AsString;
end;

function TSalePaymentSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE sale_payment.id = ' + AId.ToString;
end;

function TSalePaymentSQLBuilder.SelectBySaleId(ASaleId: Int64): String;
begin
  Result :=SelectAll + ' WHERE sale_payment.sale_id = ' + ASaleId.ToString;
end;

function TSalePaymentSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lSalePayment: TSalePayment;
begin
  lSalePayment := AEntity as TSalePayment;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('sale_payment')
    .&Set('sale_id', lSalePayment.sale_id)
    .&Set('bank_account_id', THlp.If0RetNull(lSalePayment.bank_account_id))
    .&Set('document_id',     THlp.If0RetNull(lSalePayment.document_id))
    .&Set('expiration_date', lSalePayment.expiration_date)
    .&Set('amount',          lSalePayment.amount)
    .&Set('note',            lSalePayment.note)
    .Where('sale_payment.id = ' + AId.ToString)
  .AsString;
end;

end.
