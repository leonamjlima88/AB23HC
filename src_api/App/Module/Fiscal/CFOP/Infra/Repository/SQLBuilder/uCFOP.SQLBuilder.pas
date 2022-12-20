unit uCFOP.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uCFOP,
  criteria.query.language,
  uCFOP.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TCFOPSQLBuilder = class(TInterfacedObject, ICFOPSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // CFOP
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectAll: String;
    function SelectById(AId: Int64; ATenantId: Int64 = 0): String;
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

{ TCFOPSQLBuilder }
constructor TCFOPSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TCFOPSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('cfop')
    .Where('cfop.id = ' + AId.ToString)
  .AsString;
end;

function TCFOPSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lCFOP: TCFOP;
begin
  lCFOP := AEntity as TCFOP;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('cfop')
    .&Set('name',                   lCFOP.name)
    .&Set('code',                   lCFOP.code)
    .&Set('operation_type',         lCFOP.operation_type)
    .&Set('created_at',             lCFOP.created_at)
    .&Set('created_by_acl_user_id', lCFOP.created_by_acl_user_id)
  .AsString;
end;

function TCFOPSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TCFOPSQLBuilder.RegisteredFields(AColumName, AColumnValue: String; AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column(AColumName)
    .From('cfop')
    .Where(AColumName).Equal(AColumnValue)
    .&And('cfop.id').NotEqual(AId)
  .AsString;
end;

function TCFOPSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('cfop.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('cfop')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = cfop.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = cfop.updated_by_acl_user_id')
  .AsString;
end;

function TCFOPSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'cfop.id', ddMySql);
  end;
end;

function TCFOPSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE cfop.id = ' + AId.ToString;
end;

function TCFOPSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lCFOP: TCFOP;
begin
  lCFOP := AEntity as TCFOP;
  Result := TCQL.New(FDBName)
    .Update('cfop')
    .&Set('name',                   lCFOP.name)
    .&Set('code',                   lCFOP.code)
    .&Set('operation_type',         lCFOP.operation_type)
    .&Set('updated_at',             lCFOP.updated_at)
    .&Set('updated_by_acl_user_id', lCFOP.updated_by_acl_user_id)
    .Where('cfop.id = ' + AId.ToString)
  .AsString;
end;

end.
