unit uSize.Repository.SQL;

interface

uses
  uBase.Repository,
  uSize.Repository.Interfaces,
  uSize.SQLBuilder.Interfaces,
  uConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uSize;

type
  TSizeRepositorySQL = class(TBaseRepository, ISizeRepository)
  private
    FSizeSQLBuilder: ISizeSQLBuilder;
    constructor Create(AConn: IConnection; ASQLBuilder: ISizeSQLBuilder);
    function DataSetToEntity(ADtsSize: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IConnection; ASQLBuilder: ISizeSQLBuilder): ISizeRepository;
    function Show(AId, ATenantId: Int64): TSize;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TSizeRepositorySQL }

class function TSizeRepositorySQL.Make(AConn: IConnection; ASQLBuilder: ISizeSQLBuilder): ISizeRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TSizeRepositorySQL.Create(AConn: IConnection; ASQLBuilder: ISizeSQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FSizeSQLBuilder := ASQLBuilder;
end;

function TSizeRepositorySQL.DataSetToEntity(ADtsSize: TDataSet): TBaseEntity;
var
  lSize: TSize;
begin
  lSize := TSize.FromJSON(ADtsSize.ToJSONObjectString);

  // Size - Virtuais
  lSize.created_by_acl_user.id   := ADtsSize.FieldByName('created_by_acl_user_id').AsLargeInt;
  lSize.created_by_acl_user.name := ADtsSize.FieldByName('created_by_acl_user_name').AsString;
  lSize.updated_by_acl_user.id   := ADtsSize.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lSize.updated_by_acl_user.name := ADtsSize.FieldByName('updated_by_acl_user_name').AsString;

  Result := lSize;
end;

function TSizeRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FSizeSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TSizeRepositorySQL.Show(AId, ATenantId: Int64): TSize;
begin
  Result := ShowById(AId, ATenantId) as TSize;
end;

procedure TSizeRepositorySQL.Validate(AEntity: TBaseEntity);
begin
//
end;

end.


