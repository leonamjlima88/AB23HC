unit uUnit.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uUnit,
  criteria.query.language,
  uUnit.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TUnitSQLBuilder = class(TInterfacedObject, IUnitSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // Unit
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

{ TUnitSQLBuilder }
constructor TUnitSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TUnitSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('unit')
    .Where('unit.id = ' + AId.ToString)
  .AsString;
end;

function TUnitSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lUnit: TUnit;
begin
  lUnit := AEntity as TUnit;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('unit')
    .&Set('name',                   lUnit.name)
    .&Set('created_at',             lUnit.created_at)
    .&Set('created_by_acl_user_id', lUnit.created_by_acl_user_id)
  .AsString;
end;

function TUnitSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TUnitSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('unit.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('unit')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = unit.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = unit.updated_by_acl_user_id')
  .AsString;
end;

function TUnitSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'unit.id', ddMySql);
  end;
end;

function TUnitSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE unit.id = ' + AId.ToString;
end;

function TUnitSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lUnit: TUnit;
begin
  lUnit := AEntity as TUnit;
  Result := TCQL.New(FDBName)
    .Update('unit')
    .&Set('name',                   lUnit.name)
    .&Set('updated_at',             lUnit.updated_at)
    .&Set('updated_by_acl_user_id', lUnit.updated_by_acl_user_id)
    .Where('unit.id = ' + AId.ToString)
  .AsString;
end;

end.
