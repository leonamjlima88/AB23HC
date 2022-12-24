unit uCategory.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uCategory,
  criteria.query.language,
  uCategory.SQLBuilder.Interfaces,
  cqlbr.interfaces,
  uBase.Entity;

type
  TCategorySQLBuilder = class(TInterfacedObject, ICategorySQLBuilder)
  private
    procedure LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ACategory: TCategory);
  public
    FDBName: TDBName;
    constructor Create;

    // Category
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
  cqlbr.select.mysql,
  cqlbr.serialize.mysql,
  System.Classes,
  System.SysUtils,
  uZLConnection.Types,
  uApplication.Types;

{ TCategorySQLBuilder }
constructor TCategorySQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TCategorySQLBuilder.DeleteById(AId, ATenantId: Int64): String;
var
  lCQL: ICQL;
begin
  lCQL := TCQL.New(FDBName)
    .Delete
    .From('category')
    .Where('category.id = ' + AId.ToString);

  if (ATenantId > 0) then
    lCQL.&And('category.tenant_id = ' + ATenantId.ToString);

  Result := lCQL.AsString;
end;

function TCategorySQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lCategory: TCategory;
  lCQL: ICQL;
begin
  lCategory := AEntity as TCategory;
  lCQL := TCQL.New(FDBName)
    .Insert
    .Into('category')
    .&Set('tenant_id',              lCategory.tenant_id)
    .&Set('created_at',             lCategory.created_at)
    .&Set('created_by_acl_user_id', lCategory.created_by_acl_user_id);

  // Carregar Campos Default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lCategory);

  // Retornar String SQL
  Result := lCQL.AsString;
end;

function TCategorySQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

procedure TCategorySQLBuilder.LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ACategory: TCategory);
begin
  ACQL
    .&Set('name', ACategory.name);
end;

function TCategorySQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('category.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('category')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = category.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = category.updated_by_acl_user_id')
  .AsString;
end;

function TCategorySQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'category.id', ddMySql);
  end;
end;

function TCategorySQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE category.id = ' + AId.ToString;
  if (ATenantId > 0) then
    Result := Result + ' AND category.tenant_id = ' + ATenantId.ToString;
end;

function TCategorySQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lCategory: TCategory;
  lCQL: ICQL;
begin
  lCategory := AEntity as TCategory;
  lCQL := TCQL.New(FDBName)
    .Update('category')
    .&Set('updated_at',             lCategory.updated_at)
    .&Set('updated_by_acl_user_id', lCategory.updated_by_acl_user_id);

  // Carregar Campos Default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lCategory);

  // Retornar String SQL
  Result := lCQL
    .Where('category.id = ' + AId.ToString)
    .&And('category.tenant_id = ' + lCategory.tenant_id.ToString)
  .AsString;
end;

end.
