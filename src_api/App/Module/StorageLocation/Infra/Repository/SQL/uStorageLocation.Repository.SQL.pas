unit uStorageLocation.Repository.SQL;

interface

uses
  uBase.Repository,
  uStorageLocation.Repository.Interfaces,
  uStorageLocation.SQLBuilder.Interfaces,
  uConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uStorageLocation;

type
  TStorageLocationRepositorySQL = class(TBaseRepository, IStorageLocationRepository)
  private
    FStorageLocationSQLBuilder: IStorageLocationSQLBuilder;
    constructor Create(AConn: IConnection; ASQLBuilder: IStorageLocationSQLBuilder);
    function DataSetToEntity(ADtsStorageLocation: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
  public
    class function Make(AConn: IConnection; ASQLBuilder: IStorageLocationSQLBuilder): IStorageLocationRepository;
    function Show(AId: Int64): TStorageLocation;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TStorageLocationRepositorySQL }

class function TStorageLocationRepositorySQL.Make(AConn: IConnection; ASQLBuilder: IStorageLocationSQLBuilder): IStorageLocationRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TStorageLocationRepositorySQL.Create(AConn: IConnection; ASQLBuilder: IStorageLocationSQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FStorageLocationSQLBuilder := ASQLBuilder;
end;

function TStorageLocationRepositorySQL.DataSetToEntity(ADtsStorageLocation: TDataSet): TBaseEntity;
var
  lStorageLocation: TStorageLocation;
begin
  lStorageLocation := TStorageLocation.FromJSON(ADtsStorageLocation.ToJSONObjectString);

  // StorageLocation - Virtuais
  lStorageLocation.created_by_acl_user.id   := ADtsStorageLocation.FieldByName('created_by_acl_user_id').AsLargeInt;
  lStorageLocation.created_by_acl_user.name := ADtsStorageLocation.FieldByName('created_by_acl_user_name').AsString;
  lStorageLocation.updated_by_acl_user.id   := ADtsStorageLocation.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lStorageLocation.updated_by_acl_user.name := ADtsStorageLocation.FieldByName('updated_by_acl_user_name').AsString;

  Result := lStorageLocation;
end;

function TStorageLocationRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FStorageLocationSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TStorageLocationRepositorySQL.Show(AId: Int64): TStorageLocation;
begin
  Result := ShowById(AId) as TStorageLocation;
end;

end.


