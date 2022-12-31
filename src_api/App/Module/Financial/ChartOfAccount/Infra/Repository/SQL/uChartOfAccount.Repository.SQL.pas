unit uChartOfAccount.Repository.SQL;

interface

uses
  uBase.Repository,
  uChartOfAccount.Repository.Interfaces,
  uChartOfAccount.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uChartOfAccount;

type
  TChartOfAccountRepositorySQL = class(TBaseRepository, IChartOfAccountRepository)
  private
    FChartOfAccountSQLBuilder: IChartOfAccountSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: IChartOfAccountSQLBuilder);
    function DataSetToEntity(ADtsChartOfAccount: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    function FieldExists(AColumName, AColumnValue: String; AId, ATenantId: Int64): Boolean;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: IChartOfAccountSQLBuilder): IChartOfAccountRepository;
    function Show(AId, ATenantId: Int64): TChartOfAccount;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize,
  System.SysUtils,
  uApplication.Types;

{ TChartOfAccountRepositorySQL }

class function TChartOfAccountRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: IChartOfAccountSQLBuilder): IChartOfAccountRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TChartOfAccountRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: IChartOfAccountSQLBuilder);
begin
  inherited Create;
  FConn                     := AConn;
  FSQLBuilder               := ASQLBuilder;
  FChartOfAccountSQLBuilder := ASQLBuilder;
end;

function TChartOfAccountRepositorySQL.DataSetToEntity(ADtsChartOfAccount: TDataSet): TBaseEntity;
var
  lChartOfAccount: TChartOfAccount;
begin
  lChartOfAccount := TChartOfAccount.FromJSON(ADtsChartOfAccount.ToJSONObjectString);

  // ChartOfAccount - Virtuais
  lChartOfAccount.created_by_acl_user.id   := ADtsChartOfAccount.FieldByName('created_by_acl_user_id').AsLargeInt;
  lChartOfAccount.created_by_acl_user.name := ADtsChartOfAccount.FieldByName('created_by_acl_user_name').AsString;
  lChartOfAccount.updated_by_acl_user.id   := ADtsChartOfAccount.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lChartOfAccount.updated_by_acl_user.name := ADtsChartOfAccount.FieldByName('updated_by_acl_user_name').AsString;

  Result := lChartOfAccount;
end;

function TChartOfAccountRepositorySQL.FieldExists(AColumName, AColumnValue: String; AId, ATenantId: Int64): Boolean;
begin
  Result := not FConn.MakeQry.Open(
    FChartOfAccountSQLBuilder.RegisteredFields(AColumName, AColumnValue, AId, ATenantId)
  ).DataSet.IsEmpty;
end;

function TChartOfAccountRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FChartOfAccountSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TChartOfAccountRepositorySQL.Show(AId, ATenantId: Int64): TChartOfAccount;
begin
  Result := ShowById(AId, ATenantId) as TChartOfAccount;
end;

procedure TChartOfAccountRepositorySQL.Validate(AEntity: TBaseEntity);
var
  lChartOfAccount: TChartOfAccount;
begin
  lChartOfAccount := AEntity as TChartOfAccount;

  // Verificar se hierarchy_code já existe
  if not lChartOfAccount.hierarchy_code.Trim.IsEmpty then
  begin
    if FieldExists(
      'chart_of_account.hierarchy_code',
      lChartOfAccount.hierarchy_code,
      lChartOfAccount.id,
      lChartOfAccount.tenant_id
    ) then
      raise Exception.Create(Format(FIELD_WITH_VALUE_IS_IN_USE, ['Hierarquia', lChartOfAccount.hierarchy_code]));
  end;
end;

end.


