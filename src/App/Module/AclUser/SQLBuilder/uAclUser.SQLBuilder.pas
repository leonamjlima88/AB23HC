unit uAclUser.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uAclUser,
  criteria.query.language,
  uAclUser.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TAclUserSQLBuilder = class(TInterfacedObject, IAclUserSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // AclUser
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64): String;
    function SelectAll: String;
    function SelectById(AId: Int64): String;
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

{ TAclUserSQLBuilder }
constructor TAclUserSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TAclUserSQLBuilder.DeleteById(AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('acl_user')
    .Where('acl_user.id = ' + AId.ToString)
  .AsString;
end;

function TAclUserSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lAclUser: TAclUser;
begin
  lAclUser := AEntity as TAclUser;
  Result := TCQL.New(dbnMySQL)
    .Insert
    .Into('acl_user')
    .&Set('name',            lAclUser.name)
    .&Set('login',           lAclUser.login)
    .&Set('login_password',  lAclUser.login_password)
    .&Set('acl_role_id',     lAclUser.acl_role_id)
    .&Set('is_superuser',    lAclUser.is_superuser)
    .&Set('last_token',      lAclUser.last_token)
    .&Set('last_expiration', lAclUser.last_expiration)
  .AsString;
end;

function TAclUserSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TAclUserSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(dbnMySQL)
    .Select
    .Column('acl_user.*')
    .Column('acl_role.name').&As('acl_role_name')
    .From('acl_user')
    .InnerJoin('acl_role')
          .&On('acl_role.id = acl_user.acl_role_id')
  .AsString;
end;

function TAclUserSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'acl_user.id', ddMySql);
  end;
end;

function TAclUserSQLBuilder.SelectById(AId: Int64): String;
begin
  Result := SelectAll + ' WHERE acl_user.id = ' + AId.ToString;
end;

function TAclUserSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lAclUser: TAclUser;
begin
  lAclUser := AEntity as TAclUser;
  Result := TCQL.New(dbnMySQL)
    .Update('acl_user')
    .&Set('name',             lAclUser.name)
    .&Set('login',            lAclUser.login)
    .&Set('login_password',   lAclUser.login_password)
    .&Set('acl_role_id',      lAclUser.acl_role_id)
    .&Set('is_superuser',     lAclUser.is_superuser)
    .&Set('last_token',       lAclUser.last_token)
    .&Set('last_expiration',  lAclUser.last_expiration)
    .Where('acl_user.id = ' + AId.ToString)
  .AsString;
end;

end.
