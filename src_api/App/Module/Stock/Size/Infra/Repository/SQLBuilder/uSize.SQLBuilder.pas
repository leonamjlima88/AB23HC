unit uSize.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uSize,
  criteria.query.language,
  uSize.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TSizeSQLBuilder = class(TInterfacedObject, ISizeSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // Size
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

{ TSizeSQLBuilder }
constructor TSizeSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TSizeSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('size')
    .Where('size.id = ' + AId.ToString)
  .AsString;
end;

function TSizeSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lSize: TSize;
begin
  lSize := AEntity as TSize;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('size')
    .&Set('name',                   lSize.name)
    .&Set('created_at',             lSize.created_at)
    .&Set('created_by_acl_user_id', lSize.created_by_acl_user_id)
  .AsString;
end;

function TSizeSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TSizeSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('size.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('size')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = size.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = size.updated_by_acl_user_id')
  .AsString;
end;

function TSizeSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'size.id', ddMySql);
  end;
end;

function TSizeSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE size.id = ' + AId.ToString;
end;

function TSizeSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lSize: TSize;
begin
  lSize := AEntity as TSize;
  Result := TCQL.New(FDBName)
    .Update('size')
    .&Set('name',                   lSize.name)
    .&Set('updated_at',             lSize.updated_at)
    .&Set('updated_by_acl_user_id', lSize.updated_by_acl_user_id)
    .Where('size.id = ' + AId.ToString)
  .AsString;
end;

end.
