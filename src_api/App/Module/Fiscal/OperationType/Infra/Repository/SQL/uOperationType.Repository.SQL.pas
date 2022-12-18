unit uOperationType.Repository.SQL;

interface

uses
  uBase.Repository,
  uOperationType.Repository.Interfaces,
  uOperationType.SQLBuilder.Interfaces,
  uConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uOperationType;

type
  TOperationTypeRepositorySQL = class(TBaseRepository, IOperationTypeRepository)
  private
    FOperationTypeSQLBuilder: IOperationTypeSQLBuilder;
    constructor Create(AConn: IConnection; ASQLBuilder: IOperationTypeSQLBuilder);
    function DataSetToEntity(ADtsOperationType: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IConnection; ASQLBuilder: IOperationTypeSQLBuilder): IOperationTypeRepository;
    function Show(AId: Int64): TOperationType;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TOperationTypeRepositorySQL }

class function TOperationTypeRepositorySQL.Make(AConn: IConnection; ASQLBuilder: IOperationTypeSQLBuilder): IOperationTypeRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TOperationTypeRepositorySQL.Create(AConn: IConnection; ASQLBuilder: IOperationTypeSQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FOperationTypeSQLBuilder := ASQLBuilder;
end;

function TOperationTypeRepositorySQL.DataSetToEntity(ADtsOperationType: TDataSet): TBaseEntity;
var
  lOperationType: TOperationType;
begin
  lOperationType := TOperationType.FromJSON(ADtsOperationType.ToJSONObjectString);

  // OperationType - Virtuais
  lOperationType.created_by_acl_user.id   := ADtsOperationType.FieldByName('created_by_acl_user_id').AsLargeInt;
  lOperationType.created_by_acl_user.name := ADtsOperationType.FieldByName('created_by_acl_user_name').AsString;
  lOperationType.updated_by_acl_user.id   := ADtsOperationType.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lOperationType.updated_by_acl_user.name := ADtsOperationType.FieldByName('updated_by_acl_user_name').AsString;

  Result := lOperationType;
end;

function TOperationTypeRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FOperationTypeSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TOperationTypeRepositorySQL.Show(AId: Int64): TOperationType;
begin
  Result := ShowById(AId) as TOperationType;
end;

procedure TOperationTypeRepositorySQL.Validate(AEntity: TBaseEntity);
begin
//
end;

end.


