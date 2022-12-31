unit uBankAccount.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uBankAccount,
  criteria.query.language,
  uBankAccount.SQLBuilder.Interfaces,
  cqlbr.interfaces,
  uBase.Entity;

type
  TBankAccountSQLBuilder = class(TInterfacedObject, IBankAccountSQLBuilder)
  private
    procedure LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ABankAccount: TBankAccount);
  public
    FDBName: TDBName;
    constructor Create;

    // BankAccount
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectAll: String;
    function SelectById(AId: Int64; ATenantId: Int64 = 0): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
  end;

implementation

uses
  cqlbr.select.mysql,
  cqlbr.serialize.mysql,
  System.Classes,
  System.SysUtils,
  uZLConnection.Types,
  uApplication.Types, uHlp;

{ TBankAccountSQLBuilder }
constructor TBankAccountSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TBankAccountSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
var
  lCQL: ICQL;
begin
  lCQL := TCQL.New(FDBName)
    .Delete
    .From('bank_account')
    .Where('bank_account.id = ' + AId.ToString);

  if (ATenantId > 0) then
    lCQL.&And('bank_account.tenant_id = ' + ATenantId.ToString);

  Result := lCQL.AsString;
end;

function TBankAccountSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lBankAccount: TBankAccount;
  lCQL: ICQL;
begin
  lBankAccount := AEntity as TBankAccount;
  lCQL := TCQL.New(FDBName)
    .Insert
    .Into('bank_account')
    .&Set('created_at',             lBankAccount.created_at)
    .&Set('created_by_acl_user_id', lBankAccount.created_by_acl_user_id)
    .&Set('tenant_id',              lBankAccount.tenant_id);

  // Carregar campos default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lBankAccount);

  // Retornar String SQL
  Result := lCQL.AsString;
end;

function TBankAccountSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

procedure TBankAccountSQLBuilder.LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ABankAccount: TBankAccount);
begin
  ACQL
    .&Set('name',    ABankAccount.name)
    .&Set('note',    ABankAccount.note)
    .&Set('bank_id', THlp.If0RetNull(ABankAccount.bank_id));
end;

function TBankAccountSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('bank_account.*')
    .Column('bank.name').&As('bank_name')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('bank_account')
    .InnerJoin('bank')
          .&On('bank.id = bank_account.bank_id')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = bank_account.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = bank_account.updated_by_acl_user_id')
  .AsString;
end;

function TBankAccountSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'bank_account.id', ddMySql);
  end;
end;

function TBankAccountSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE bank_account.id = ' + AId.ToString;
  if (ATenantId > 0) then
    Result := Result + ' AND bank_account.tenant_id = ' + ATenantId.ToString;
end;

function TBankAccountSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lBankAccount: TBankAccount;
  lCQL: ICQL;
begin
  lBankAccount := AEntity as TBankAccount;
  lCQL := TCQL.New(FDBName)
    .Update('bank_account')
    .&Set('updated_at',             lBankAccount.updated_at)
    .&Set('updated_by_acl_user_id', lBankAccount.updated_by_acl_user_id);

  // Carregar campos default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lBankAccount);

  // Retornar String SQL
  Result := lCQL
    .Where('bank_account.id = ' + AId.ToString)
    .&And('bank_account.tenant_id = ' + lBankAccount.tenant_id.ToString)
  .AsString;
end;

end.
