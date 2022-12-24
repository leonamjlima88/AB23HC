unit uCity.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uCity,
  criteria.query.language,
  uCity.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TCitySQLBuilder = class(TInterfacedObject, ICitySQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // City
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
  uZLConnection.Types,
  uApplication.Types;

{ TCitySQLBuilder }
constructor TCitySQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TCitySQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('city')
    .Where('city.id = ' + AId.ToString)
  .AsString;
end;

function TCitySQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lCity: TCity;
begin
  lCity := AEntity as TCity;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('city')
    .&Set('name',                   lCity.name)
    .&Set('state',                  lCity.state)
    .&Set('country',                lCity.country)
    .&Set('ibge_code',              lCity.ibge_code)
    .&Set('country_ibge_code',      lCity.country_ibge_code)
    .&Set('identification',         lCity.identification)
    .&Set('created_at',             lCity.created_at)
    .&Set('created_by_acl_user_id', lCity.created_by_acl_user_id)
  .AsString;
end;

function TCitySQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TCitySQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('city.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('city')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = city.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = city.updated_by_acl_user_id')
  .AsString;
end;

function TCitySQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'city.id', ddMySql);
  end;
end;

function TCitySQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE city.id = ' + AId.ToString;
end;

function TCitySQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lCity: TCity;
begin
  lCity := AEntity as TCity;
  Result := TCQL.New(FDBName)
    .Update('city')
    .&Set('name',                   lCity.name)
    .&Set('state',                  lCity.state)
    .&Set('country',                lCity.country)
    .&Set('ibge_code',              lCity.ibge_code)
    .&Set('country_ibge_code',      lCity.country_ibge_code)
    .&Set('identification',         lCity.identification)
    .&Set('updated_at',             lCity.updated_at)
    .&Set('updated_by_acl_user_id', lCity.updated_by_acl_user_id)
    .Where('city.id = ' + AId.ToString)
  .AsString;
end;

end.
