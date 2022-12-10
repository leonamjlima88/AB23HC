unit uAclUser.Repository.SQL;

interface

uses
  uBase.Repository,
  uAclUser.Repository.Interfaces,
  uAclUser.SQLBuilder.Interfaces,
  uConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uAclUser;

type
  TAclUserRepositorySQL = class(TBaseRepository, IAclUserRepository)
  private
    FAclUserSQLBuilder: IAclUserSQLBuilder;
    constructor Create(AConn: IConnection; ASQLBuilder: IAclUserSQLBuilder);
    function DataSetToEntity(ADtsAclUser: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
  public
    class function Make(AConn: IConnection; ASQLBuilder: IAclUserSQLBuilder): IAclUserRepository;
    function Show(AId: Int64): TAclUser;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TAclUserRepositorySQL }

constructor TAclUserRepositorySQL.Create(AConn: IConnection; ASQLBuilder: IAclUserSQLBuilder);
begin
  inherited Create;
  FConn              := AConn;
  FSQLBuilder        := ASQLBuilder;
  FAclUserSQLBuilder := ASQLBuilder;
end;

function TAclUserRepositorySQL.DataSetToEntity(ADtsAclUser: TDataSet): TBaseEntity;
var
  lAclUser: TAclUser;
begin
  lAclUser := TAclUser.FromJSON(ADtsAclUser.ToJSONObjectString);

  // AclUser - Virtuais
  lAclUser.acl_role.id   := ADtsAclUser.FieldByName('acl_role_id').AsLargeInt;
  lAclUser.acl_role.name := ADtsAclUser.FieldByName('acl_role_name').AsString;

  Result := lAclUser;
end;

class function TAclUserRepositorySQL.Make(AConn: IConnection; ASQLBuilder: IAclUserSQLBuilder): IAclUserRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

function TAclUserRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FAclUserSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TAclUserRepositorySQL.Show(AId: Int64): TAclUser;
begin
  Result := ShowById(AId) as TAclUser;
end;

end.


