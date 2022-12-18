unit uBank.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uBank,
  criteria.query.language,
  uBank.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TBankSQLBuilder = class(TInterfacedObject, IBankSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // Bank
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

{ TBankSQLBuilder }
constructor TBankSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TBankSQLBuilder.DeleteById(AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('bank')
    .Where('bank.id = ' + AId.ToString)
  .AsString;
end;

function TBankSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lBank: TBank;
begin
  lBank := AEntity as TBank;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('bank')
    .&Set('name',                   lBank.name)
    .&Set('code',                   lBank.code)
    .&Set('created_at',             lBank.created_at)
    .&Set('created_by_acl_user_id', lBank.created_by_acl_user_id)
  .AsString;
end;

function TBankSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TBankSQLBuilder.RegisteredFields(AColumName, AColumnValue: String; AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column(AColumName)
    .From('bank')
    .Where(AColumName).Equal(AColumnValue)
    .&And('bank.id').NotEqual(AId)
  .AsString;
end;

function TBankSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('bank.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('bank')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = bank.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = bank.updated_by_acl_user_id')
  .AsString;
end;

function TBankSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'bank.id', ddMySql);
  end;
end;

function TBankSQLBuilder.SelectById(AId: Int64): String;
begin
  Result := SelectAll + ' WHERE bank.id = ' + AId.ToString;
end;

function TBankSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lBank: TBank;
begin
  lBank := AEntity as TBank;
  Result := TCQL.New(FDBName)
    .Update('bank')
    .&Set('name',                   lBank.name)
    .&Set('code',                   lBank.code)
    .&Set('updated_at',             lBank.updated_at)
    .&Set('updated_by_acl_user_id', lBank.updated_by_acl_user_id)
    .Where('bank.id = ' + AId.ToString)
  .AsString;
end;

end.
