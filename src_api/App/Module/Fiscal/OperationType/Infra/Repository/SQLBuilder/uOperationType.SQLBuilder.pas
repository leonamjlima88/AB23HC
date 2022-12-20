unit uOperationType.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uOperationType,
  criteria.query.language,
  uOperationType.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TOperationTypeSQLBuilder = class(TInterfacedObject, IOperationTypeSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    // OperationType
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

{ TOperationTypeSQLBuilder }
constructor TOperationTypeSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TOperationTypeSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
var
  lCQL: ICQL;
begin
  lCQL := TCQL.New(FDBName)
    .Delete
    .From('operation_type')
    .Where('operation_type.id = ' + AId.ToString);

  if (ATenantId > 0) then
    lCQL.&And('operation_type.tenant_id = ' + ATenantId.ToString);

  Result := lCQL.AsString;
end;


function TOperationTypeSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lOperationType: TOperationType;
begin
  lOperationType := AEntity as TOperationType;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('operation_type')
    .&Set('name',                         lOperationType.name)
    .&Set('document_type',                lOperationType.document_type)
    .&Set('issue_purpose',                lOperationType.issue_purpose)
    .&Set('operation_nature_description', lOperationType.operation_nature_description)
    .&Set('created_at',                   lOperationType.created_at)
    .&Set('created_by_acl_user_id',       lOperationType.created_by_acl_user_id)
    .&Set('tenant_id',                    lOperationType.tenant_id)
  .AsString;
end;

function TOperationTypeSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TOperationTypeSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('operation_type.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('operation_type')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = operation_type.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = operation_type.updated_by_acl_user_id')
  .AsString;
end;

function TOperationTypeSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'operation_type.id', ddMySql);
  end;
end;

function TOperationTypeSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE operation_type.id = ' + AId.ToString;
  if (ATenantId > 0) then
    Result := Result + ' AND operation_type.tenant_id = ' + ATenantId.ToString;
end;

function TOperationTypeSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lOperationType: TOperationType;
begin
  lOperationType := AEntity as TOperationType;
  Result := TCQL.New(FDBName)
    .Update('operation_type')
    .&Set('name',                         lOperationType.name)
    .&Set('document_type',                lOperationType.document_type)
    .&Set('issue_purpose',                lOperationType.issue_purpose)
    .&Set('operation_nature_description', lOperationType.operation_nature_description)
    .&Set('updated_at',                   lOperationType.updated_at)
    .&Set('updated_by_acl_user_id',       lOperationType.updated_by_acl_user_id)
    .Where('operation_type.id = '       + AId.ToString)
    .&And('operation_type.tenant_id = ' + lOperationType.tenant_id.ToString)
  .AsString;
end;

end.
