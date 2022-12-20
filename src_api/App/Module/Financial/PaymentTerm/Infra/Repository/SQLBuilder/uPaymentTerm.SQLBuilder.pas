unit uPaymentTerm.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uPaymentTerm,
  criteria.query.language,
  uPaymentTerm.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TPaymentTermSQLBuilder = class(TInterfacedObject, IPaymentTermSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // PaymentTerm
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64): String;
    function SelectAll: String;
    function SelectById(AId: Int64; ATenantId: Int64): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
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

{ TPaymentTermSQLBuilder }
constructor TPaymentTermSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TPaymentTermSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('payment_term')
    .Where('payment_term.id = ' + AId.ToString)
  .AsString;
end;

function TPaymentTermSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lPaymentTerm: TPaymentTerm;
begin
  lPaymentTerm := AEntity as TPaymentTerm;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('payment_term')
    .&Set('name',                          lPaymentTerm.name)
    .&Set('number_of_installments',        lPaymentTerm.number_of_installments)
    .&Set('first_installment_in',          lPaymentTerm.first_installment_in)
    .&Set('interval_between_installments', lPaymentTerm.interval_between_installments)
    .&Set('bank_account_id',               lPaymentTerm.bank_account_id)
    .&Set('document_id',                   lPaymentTerm.document_id)
    .&Set('created_at',                    lPaymentTerm.created_at)
    .&Set('created_by_acl_user_id',        lPaymentTerm.created_by_acl_user_id)
  .AsString;
end;

function TPaymentTermSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TPaymentTermSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('payment_term.*')
    .Column('bank_account.name').&As('bank_account_name')
    .Column('document.name').&As('document_name')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('payment_term')
    .InnerJoin('bank_account')
          .&On('bank_account.id = payment_term.bank_account_id')
    .InnerJoin('document')
          .&On('document.id = payment_term.document_id')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = payment_term.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = payment_term.updated_by_acl_user_id')
  .AsString;
end;

function TPaymentTermSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'payment_term.id', ddMySql);
  end;
end;

function TPaymentTermSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE payment_term.id = ' + AId.ToString;
end;

function TPaymentTermSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lPaymentTerm: TPaymentTerm;
begin
  lPaymentTerm := AEntity as TPaymentTerm;
  Result := TCQL.New(FDBName)
    .Update('payment_term')
    .&Set('name',                          lPaymentTerm.name)
    .&Set('number_of_installments',        lPaymentTerm.number_of_installments)
    .&Set('first_installment_in',          lPaymentTerm.first_installment_in)
    .&Set('interval_between_installments', lPaymentTerm.interval_between_installments)
    .&Set('bank_account_id',               lPaymentTerm.bank_account_id)
    .&Set('document_id',                   lPaymentTerm.document_id)
    .&Set('updated_at',                    lPaymentTerm.updated_at)
    .&Set('updated_by_acl_user_id',        lPaymentTerm.updated_by_acl_user_id)
    .Where('payment_term.id = ' + AId.ToString)
  .AsString;
end;

end.
