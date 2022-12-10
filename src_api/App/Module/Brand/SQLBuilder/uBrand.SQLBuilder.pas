unit uBrand.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uBrand,
  criteria.query.language,
  uBrand.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TBrandSQLBuilder = class(TInterfacedObject, IBrandSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // Brand
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

{ TBrandSQLBuilder }
constructor TBrandSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TBrandSQLBuilder.DeleteById(AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('brand')
    .Where('brand.id = ' + AId.ToString)
  .AsString;
end;

function TBrandSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lBrand: TBrand;
begin
  lBrand := AEntity as TBrand;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('brand')
    .&Set('name', lBrand.name)
    .&Set('created_at', lBrand.created_at)
    .&Set('created_by_acl_user_id', lBrand.created_by_acl_user_id)
  .AsString;
end;

function TBrandSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TBrandSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('brand.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('brand')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = brand.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = brand.updated_by_acl_user_id')
  .AsString;
end;

function TBrandSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'brand.id', ddMySql);
  end;
end;

function TBrandSQLBuilder.SelectById(AId: Int64): String;
begin
  Result := SelectAll + ' WHERE brand.id = ' + AId.ToString;
end;

function TBrandSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lBrand: TBrand;
begin
  lBrand := AEntity as TBrand;
  Result := TCQL.New(FDBName)
    .Update('brand')
    .&Set('name', lBrand.name)
    .&Set('updated_at', lBrand.updated_at)
    .&Set('updated_by_acl_user_id', lBrand.updated_by_acl_user_id)
    .Where('brand.id = ' + AId.ToString)
  .AsString;
end;

end.