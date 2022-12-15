unit uCostCenter.Repository.SQL;

interface

uses
  uBase.Repository,
  uCostCenter.Repository.Interfaces,
  uCostCenter.SQLBuilder.Interfaces,
  uConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uCostCenter;

type
  TCostCenterRepositorySQL = class(TBaseRepository, ICostCenterRepository)
  private
    FCostCenterSQLBuilder: ICostCenterSQLBuilder;
    constructor Create(AConn: IConnection; ASQLBuilder: ICostCenterSQLBuilder);
    function DataSetToEntity(ADtsCostCenter: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
  public
    class function Make(AConn: IConnection; ASQLBuilder: ICostCenterSQLBuilder): ICostCenterRepository;
    function Show(AId: Int64): TCostCenter;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TCostCenterRepositorySQL }

class function TCostCenterRepositorySQL.Make(AConn: IConnection; ASQLBuilder: ICostCenterSQLBuilder): ICostCenterRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TCostCenterRepositorySQL.Create(AConn: IConnection; ASQLBuilder: ICostCenterSQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FCostCenterSQLBuilder := ASQLBuilder;
end;

function TCostCenterRepositorySQL.DataSetToEntity(ADtsCostCenter: TDataSet): TBaseEntity;
var
  lCostCenter: TCostCenter;
begin
  lCostCenter := TCostCenter.FromJSON(ADtsCostCenter.ToJSONObjectString);

  // CostCenter - Virtuais
  lCostCenter.created_by_acl_user.id   := ADtsCostCenter.FieldByName('created_by_acl_user_id').AsLargeInt;
  lCostCenter.created_by_acl_user.name := ADtsCostCenter.FieldByName('created_by_acl_user_name').AsString;
  lCostCenter.updated_by_acl_user.id   := ADtsCostCenter.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lCostCenter.updated_by_acl_user.name := ADtsCostCenter.FieldByName('updated_by_acl_user_name').AsString;

  Result := lCostCenter;
end;

function TCostCenterRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FCostCenterSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TCostCenterRepositorySQL.Show(AId: Int64): TCostCenter;
begin
  Result := ShowById(AId) as TCostCenter;
end;

end.


