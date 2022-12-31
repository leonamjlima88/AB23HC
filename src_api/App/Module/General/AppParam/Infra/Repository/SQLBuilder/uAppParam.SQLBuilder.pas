unit uAppParam.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uAppParam,
  criteria.query.language,
  uAppParam.SQLBuilder.Interfaces,
  cqlbr.interfaces,
  uBase.Entity;

type
  TAppParamSQLBuilder = class(TInterfacedObject, IAppParamSQLBuilder)
  private
    procedure LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const AAppParam: TAppParam);
  public
    FDBName: TDBName;
    constructor Create;

    // AppParam
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectAll: String;
    function SelectById(AId: Int64; ATenantId: Int64 = 0): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function DeleteByGroup(AGroupName: String; ATenantId: Int64): String;
  end;

implementation

uses
  cqlbr.select.mysql,
  cqlbr.serialize.mysql,
  System.Classes,
  System.SysUtils,
  uZLConnection.Types,
  uApplication.Types,
  uHlp;

{ TAppParamSQLBuilder }
constructor TAppParamSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TAppParamSQLBuilder.DeleteByGroup(AGroupName: String; ATenantId: Int64): String;
var
  lSQL: String;
begin
  lSQL := TCQL.New(FDBName)
    .Delete
    .From('app_param')
    .Where('(app_param.group_name = %s and app_param.tenant_id = %d)')
  .AsString;

  Result := Format(lSQL, [
    QuotedStr(AGroupName),
    ATenantId
  ]);
end;

function TAppParamSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
var
  lCQL: ICQL;
begin
  lCQL := TCQL.New(FDBName)
    .Delete
    .From('app_param')
    .Where('app_param.id = ' + AId.ToString);

  if (ATenantId > 0) then
    lCQL.&And('app_param.tenant_id = ' + ATenantId.ToString);

  Result := lCQL.AsString;
end;

function TAppParamSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lAppParam: TAppParam;
  lCQL: ICQL;
begin
  lAppParam := AEntity as TAppParam;
  lCQL := TCQL.New(FDBName)
    .Insert
    .Into('app_param')
    .&Set('tenant_id', lAppParam.tenant_id);

  // Carregar Campos Default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lAppParam);

  // Retornar String SQL
  Result := lCQL.AsString;
end;

function TAppParamSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

procedure TAppParamSQLBuilder.LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const AAppParam: TAppParam);
begin
  ACQL
    .&Set('group_name',  AAppParam.group_name)
    .&Set('title',       AAppParam.title)
    .&Set('value',       AAppParam.value)
    .&Set('acl_role_id', THlp.If0RetNull(AAppParam.acl_role_id));
end;

function TAppParamSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('app_param.*')
    .From('app_param')
  .AsString;
end;

function TAppParamSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'app_param.id', ddMySql);
  end;
end;

function TAppParamSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE app_param.id = ' + AId.ToString;
  if (ATenantId > 0) then
    Result := Result + ' AND app_param.tenant_id = ' + ATenantId.ToString;
end;

function TAppParamSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lAppParam: TAppParam;
  lCQL: ICQL;
begin
  lAppParam := AEntity as TAppParam;
  lCQL := TCQL.New(FDBName)
    .Update('app_param');

  // Carregar Campos Default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lAppParam);

  // Retornar String SQL
  Result := lCQL
    .Where('app_param.id = '       + AId.ToString)
    .&And('app_param.tenant_id = ' + lAppParam.tenant_id.ToString)
  .AsString;
end;

end.
