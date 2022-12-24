unit uAclRole.Repository.SQL;

interface

uses
  uBase.Repository,
  uAclRole.Repository.Interfaces,
  uAclRole.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uAclRole;

type
  TAclRoleRepositorySQL = class(TBaseRepository, IAclRoleRepository)
  private
    FAclRoleSQLBuilder: IAclRoleSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: IAclRoleSQLBuilder);
    function DataSetToEntity(ADtsAclRole: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: IAclRoleSQLBuilder): IAclRoleRepository;
    function Show(AId, ATenantId: Int64): TAclRole;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TAclRoleRepositorySQL }

constructor TAclRoleRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: IAclRoleSQLBuilder);
begin
  inherited Create;
  FConn              := AConn;
  FSQLBuilder        := ASQLBuilder;
  FAclRoleSQLBuilder := ASQLBuilder;
end;

function TAclRoleRepositorySQL.DataSetToEntity(ADtsAclRole: TDataSet): TBaseEntity;
var
  lAclRole: TAclRole;
begin
  lAclRole := TAclRole.FromJSON(ADtsAclRole.ToJSONObjectString);
  Result := lAclRole;
end;

class function TAclRoleRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: IAclRoleSQLBuilder): IAclRoleRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

function TAclRoleRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FAclRoleSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TAclRoleRepositorySQL.Show(AId, ATenantId: Int64): TAclRole;
begin
  Result := ShowById(AId, ATenantId) as TAclRole;
end;

procedure TAclRoleRepositorySQL.Validate(AEntity: TBaseEntity);
begin
//
end;

end.


