unit uAppParam.Repository.SQL;

interface

uses
  uBase.Repository,
  uAppParam.Repository.Interfaces,
  uAppParam.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uAppParam;

type
  TAppParamRepositorySQL = class(TBaseRepository, IAppParamRepository)
  private
    FAppParamSQLBuilder: IAppParamSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: IAppParamSQLBuilder);
    function DataSetToEntity(ADtsAppParam: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: IAppParamSQLBuilder): IAppParamRepository;
    function Show(AId, ATenantId: Int64): TAppParam;
    function DeleteManyByGroup(AGroupName: String; ATenantId: Int64): IAppParamRepository;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize,
  System.SysUtils;

{ TAppParamRepositorySQL }

class function TAppParamRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: IAppParamSQLBuilder): IAppParamRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TAppParamRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: IAppParamSQLBuilder);
begin
  inherited Create;
  FConn               := AConn;
  FSQLBuilder         := ASQLBuilder;
  FAppParamSQLBuilder := ASQLBuilder;
end;

function TAppParamRepositorySQL.DataSetToEntity(ADtsAppParam: TDataSet): TBaseEntity;
var
  lAppParam: TAppParam;
begin
  lAppParam := TAppParam.FromJSON(ADtsAppParam.ToJSONObjectString);

  Result := lAppParam;
end;

function TAppParamRepositorySQL.DeleteManyByGroup(AGroupName: String; ATenantId: Int64): IAppParamRepository;
begin
  Result := Self;
  FConn.MakeQry.ExecSQL(FAppParamSQLBuilder.DeleteByGroup(AGroupName, ATenantId));
end;

function TAppParamRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FAppParamSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TAppParamRepositorySQL.Show(AId, ATenantId: Int64): TAppParam;
begin
  Result := ShowById(AId, ATenantId) as TAppParam;
end;

procedure TAppParamRepositorySQL.Validate(AEntity: TBaseEntity);
begin
//
end;

end.


