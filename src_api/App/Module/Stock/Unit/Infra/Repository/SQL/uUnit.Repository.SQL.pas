unit uUnit.Repository.SQL;

interface

uses
  uBase.Repository,
  uUnit.Repository.Interfaces,
  uUnit.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uUnit;

type
  TUnitRepositorySQL = class(TBaseRepository, IUnitRepository)
  private
    FUnitSQLBuilder: IUnitSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: IUnitSQLBuilder);
    function DataSetToEntity(ADtsUnit: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: IUnitSQLBuilder): IUnitRepository;
    function Show(AId: Int64): TUnit;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TUnitRepositorySQL }

class function TUnitRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: IUnitSQLBuilder): IUnitRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TUnitRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: IUnitSQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FUnitSQLBuilder := ASQLBuilder;
end;

function TUnitRepositorySQL.DataSetToEntity(ADtsUnit: TDataSet): TBaseEntity;
var
  lUnit: TUnit;
begin
  lUnit := TUnit.FromJSON(ADtsUnit.ToJSONObjectString);

  // Unit - Virtuais
  lUnit.created_by_acl_user.id   := ADtsUnit.FieldByName('created_by_acl_user_id').AsLargeInt;
  lUnit.created_by_acl_user.name := ADtsUnit.FieldByName('created_by_acl_user_name').AsString;
  lUnit.updated_by_acl_user.id   := ADtsUnit.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lUnit.updated_by_acl_user.name := ADtsUnit.FieldByName('updated_by_acl_user_name').AsString;

  Result := lUnit;
end;

function TUnitRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FUnitSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TUnitRepositorySQL.Show(AId: Int64): TUnit;
begin
  Result := ShowById(AId) as TUnit;
end;

procedure TUnitRepositorySQL.Validate(AEntity: TBaseEntity);
begin
//
end;

end.


