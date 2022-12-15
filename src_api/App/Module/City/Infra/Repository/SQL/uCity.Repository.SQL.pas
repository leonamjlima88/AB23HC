unit uCity.Repository.SQL;

interface

uses
  uBase.Repository,
  uCity.Repository.Interfaces,
  uCity.SQLBuilder.Interfaces,
  uConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uCity;

type
  TCityRepositorySQL = class(TBaseRepository, ICityRepository)
  private
    FCitySQLBuilder: ICitySQLBuilder;
    constructor Create(AConn: IConnection; ASQLBuilder: ICitySQLBuilder);
    function DataSetToEntity(ADtsCity: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
  public
    class function Make(AConn: IConnection; ASQLBuilder: ICitySQLBuilder): ICityRepository;
    function Show(AId: Int64): TCity;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TCityRepositorySQL }

class function TCityRepositorySQL.Make(AConn: IConnection; ASQLBuilder: ICitySQLBuilder): ICityRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TCityRepositorySQL.Create(AConn: IConnection; ASQLBuilder: ICitySQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FCitySQLBuilder := ASQLBuilder;
end;

function TCityRepositorySQL.DataSetToEntity(ADtsCity: TDataSet): TBaseEntity;
var
  lCity: TCity;
begin
  lCity := TCity.FromJSON(ADtsCity.ToJSONObjectString);

  // City - Virtuais
  lCity.created_by_acl_user.id   := ADtsCity.FieldByName('created_by_acl_user_id').AsLargeInt;
  lCity.created_by_acl_user.name := ADtsCity.FieldByName('created_by_acl_user_name').AsString;
  lCity.updated_by_acl_user.id   := ADtsCity.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lCity.updated_by_acl_user.name := ADtsCity.FieldByName('updated_by_acl_user_name').AsString;

  Result := lCity;
end;

function TCityRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FCitySQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TCityRepositorySQL.Show(AId: Int64): TCity;
begin
  Result := ShowById(AId) as TCity;
end;

end.


