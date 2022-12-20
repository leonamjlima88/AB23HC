unit uAclRole.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uAclRole,
  criteria.query.language,
  uAclRole.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TAclRoleSQLBuilder = class(TInterfacedObject, IAclRoleSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // AclRole
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
  cqlbr.interfaces,
  cqlbr.select.mysql,
  cqlbr.serialize.mysql,
  System.Classes,
  System.SysUtils,
  uConnection.Types,
  uApplication.Types;

{ TAclRoleSQLBuilder }
constructor TAclRoleSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TAclRoleSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
var
  lCQL: ICQL;
begin
  lCQL := TCQL.New(FDBName)
    .Delete
    .From('acl_role')
    .Where('acl_role.id = ' + AId.ToString);

  if (ATenantId > 0) then
    lCQL.&And('acl_role.tenant_id = ' + ATenantId.ToString);

  Result := lCQL.AsString;
end;

function TAclRoleSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lAclRole: TAclRole;
begin
  lAclRole := AEntity as TAclRole;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('acl_role')
    .&Set('name',      lAclRole.name)
    .&Set('tenant_id', lAclRole.tenant_id)
  .AsString;
end;

function TAclRoleSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TAclRoleSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('acl_role.*')
    .From('acl_role')
  .AsString;
end;

function TAclRoleSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'acl_role.id', ddMySql);
  end;
end;

function TAclRoleSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE acl_role.id = ' + AId.ToString;
  if (ATenantId > 0) then
    Result := Result + ' AND acl_role.tenant_id = ' + ATenantId.ToString;
end;

function TAclRoleSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lAclRole: TAclRole;
begin
  lAclRole := AEntity as TAclRole;
  Result := TCQL.New(FDBName)
    .Update('acl_role')
    .&Set('name', lAclRole.name)
    .Where('acl_role.id = ' + AId.ToString)
    .&And('acl_role.tenant_id = ' + lAclRole.tenant_id.ToString)
  .AsString;
end;

end.
