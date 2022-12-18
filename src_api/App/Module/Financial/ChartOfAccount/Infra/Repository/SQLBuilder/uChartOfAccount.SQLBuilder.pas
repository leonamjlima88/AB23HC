unit uChartOfAccount.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uChartOfAccount,
  criteria.query.language,
  uChartOfAccount.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TChartOfAccountSQLBuilder = class(TInterfacedObject, IChartOfAccountSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // ChartOfAccount
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

{ TChartOfAccountSQLBuilder }
constructor TChartOfAccountSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TChartOfAccountSQLBuilder.DeleteById(AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('chart_of_account')
    .Where('chart_of_account.id = ' + AId.ToString)
  .AsString;
end;

function TChartOfAccountSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lChartOfAccount: TChartOfAccount;
begin
  lChartOfAccount := AEntity as TChartOfAccount;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('chart_of_account')
    .&Set('name',                   lChartOfAccount.name)
    .&Set('hierarchy_code',         lChartOfAccount.hierarchy_code)
    .&Set('is_analytical',          lChartOfAccount.is_analytical)
    .&Set('note',                   lChartOfAccount.note)
    .&Set('created_at',             lChartOfAccount.created_at)
    .&Set('created_by_acl_user_id', lChartOfAccount.created_by_acl_user_id)
  .AsString;
end;

function TChartOfAccountSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TChartOfAccountSQLBuilder.RegisteredFields(AColumName, AColumnValue: String; AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column(AColumName)
    .From('chart_of_account')
    .Where(AColumName).Equal(AColumnValue)
    .&And('chart_of_account.id').NotEqual(AId)
  .AsString;
end;

function TChartOfAccountSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('chart_of_account.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('chart_of_account')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = chart_of_account.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = chart_of_account.updated_by_acl_user_id')
  .AsString;
end;

function TChartOfAccountSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'chart_of_account.id', ddMySql);
  end;
end;

function TChartOfAccountSQLBuilder.SelectById(AId: Int64): String;
begin
  Result := SelectAll + ' WHERE chart_of_account.id = ' + AId.ToString;
end;

function TChartOfAccountSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lChartOfAccount: TChartOfAccount;
begin
  lChartOfAccount := AEntity as TChartOfAccount;
  Result := TCQL.New(FDBName)
    .Update('chart_of_account')
    .&Set('name',                   lChartOfAccount.name)
    .&Set('hierarchy_code',         lChartOfAccount.hierarchy_code)
    .&Set('is_analytical',          lChartOfAccount.is_analytical)
    .&Set('note',                   lChartOfAccount.note)
    .&Set('updated_at',             lChartOfAccount.updated_at)
    .&Set('updated_by_acl_user_id', lChartOfAccount.updated_by_acl_user_id)
    .Where('chart_of_account.id = ' + AId.ToString)
  .AsString;
end;

end.
