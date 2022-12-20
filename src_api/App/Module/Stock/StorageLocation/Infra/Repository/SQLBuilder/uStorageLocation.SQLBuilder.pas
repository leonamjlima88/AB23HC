unit uStorageLocation.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uStorageLocation,
  criteria.query.language,
  uStorageLocation.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TStorageLocationSQLBuilder = class(TInterfacedObject, IStorageLocationSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // StorageLocation
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

{ TStorageLocationSQLBuilder }
constructor TStorageLocationSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TStorageLocationSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('storage_location')
    .Where('storage_location.id = ' + AId.ToString)
  .AsString;
end;

function TStorageLocationSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lStorageLocation: TStorageLocation;
begin
  lStorageLocation := AEntity as TStorageLocation;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('storage_location')
    .&Set('name',                   lStorageLocation.name)
    .&Set('created_at',             lStorageLocation.created_at)
    .&Set('created_by_acl_user_id', lStorageLocation.created_by_acl_user_id)
  .AsString;
end;

function TStorageLocationSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TStorageLocationSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('storage_location.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('storage_location')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = storage_location.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = storage_location.updated_by_acl_user_id')
  .AsString;
end;

function TStorageLocationSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'storage_location.id', ddMySql);
  end;
end;

function TStorageLocationSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE storage_location.id = ' + AId.ToString;
end;

function TStorageLocationSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lStorageLocation: TStorageLocation;
begin
  lStorageLocation := AEntity as TStorageLocation;
  Result := TCQL.New(FDBName)
    .Update('storage_location')
    .&Set('name',                   lStorageLocation.name)
    .&Set('updated_at',             lStorageLocation.updated_at)
    .&Set('updated_by_acl_user_id', lStorageLocation.updated_by_acl_user_id)
    .Where('storage_location.id = ' + AId.ToString)
  .AsString;
end;

end.
