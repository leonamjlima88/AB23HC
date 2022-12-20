unit uCostCenter.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uCostCenter,
  criteria.query.language,
  uCostCenter.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TCostCenterSQLBuilder = class(TInterfacedObject, ICostCenterSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // CostCenter
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

{ TCostCenterSQLBuilder }
constructor TCostCenterSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TCostCenterSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
var
  lCQL: ICQL;
begin
  lCQL := TCQL.New(FDBName)
    .Delete
    .From('cost_center')
    .Where('cost_center.id = ' + AId.ToString);

  if (ATenantId > 0) then
    lCQL.&And('cost_center.tenant_id = ' + ATenantId.ToString);

  Result := lCQL.AsString;
end;

function TCostCenterSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lCostCenter: TCostCenter;
begin
  lCostCenter := AEntity as TCostCenter;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('cost_center')
    .&Set('name',                   lCostCenter.name)
    .&Set('created_at',             lCostCenter.created_at)
    .&Set('created_by_acl_user_id', lCostCenter.created_by_acl_user_id)
    .&Set('tenant_id',              lCostCenter.tenant_id)
  .AsString;
end;

function TCostCenterSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TCostCenterSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('cost_center.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('cost_center')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = cost_center.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = cost_center.updated_by_acl_user_id')
  .AsString;
end;

function TCostCenterSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'cost_center.id', ddMySql);
  end;
end;

function TCostCenterSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE cost_center.id = ' + AId.ToString;
  if (ATenantId > 0) then
    Result := Result + ' AND cost_center.tenant_id = ' + ATenantId.ToString;
end;

function TCostCenterSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lCostCenter: TCostCenter;
begin
  lCostCenter := AEntity as TCostCenter;
  Result := TCQL.New(FDBName)
    .Update('cost_center')
    .&Set('name',                   lCostCenter.name)
    .&Set('updated_at',             lCostCenter.updated_at)
    .&Set('updated_by_acl_user_id', lCostCenter.updated_by_acl_user_id)
    .Where('cost_center.id = '       + AId.ToString)
    .&And('cost_center.tenant_id = ' + lCostCenter.tenant_id.ToString)
  .AsString;
end;

end.
