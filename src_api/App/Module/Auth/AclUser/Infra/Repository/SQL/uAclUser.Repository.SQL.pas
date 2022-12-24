unit uAclUser.Repository.SQL;

interface

uses
  uBase.Repository,
  uAclUser.Repository.Interfaces,
  uAclUser.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uAclUser;

type
  TAclUserRepositorySQL = class(TBaseRepository, IAclUserRepository)
  private
    FAclUserSQLBuilder: IAclUserSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: IAclUserSQLBuilder);
    function DataSetToEntity(ADtsAclUser: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: IAclUserSQLBuilder): IAclUserRepository;
    function Show(AId: Int64): TAclUser;
    function ShowByLoginAndPassword(ALogin, APassword: String): TAclUser;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TAclUserRepositorySQL }

constructor TAclUserRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: IAclUserSQLBuilder);
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
  lAclUser.acl_role.id        := ADtsAclUser.FieldByName('acl_role_id').AsLargeInt;
  lAclUser.acl_role.name      := ADtsAclUser.FieldByName('acl_role_name').AsString;
  lAclUser.acl_role.tenant_id := ADtsAclUser.FieldByName('acl_role_tenant_id').AsLargeInt;

  Result := lAclUser;
end;

class function TAclUserRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: IAclUserSQLBuilder): IAclUserRepository;
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

function TAclUserRepositorySQL.ShowByLoginAndPassword(ALogin, APassword: String): TAclUser;
begin
  Result := nil;
  With FConn.MakeQry.Open(FAclUserSQLBuilder.ShowByLoginAndPassword(ALogin, APassword)) do
  begin
    if DataSet.IsEmpty then Exit;
    Result := DataSetToEntity(DataSet) as TAclUser;
  end;
end;

procedure TAclUserRepositorySQL.Validate(AEntity: TBaseEntity);
begin
//
end;

end.


