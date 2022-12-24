unit uTenant.Repository.SQL;

interface

uses
  uBase.Repository,
  uTenant.Repository.Interfaces,
  uTenant.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uTenant;

type
  TTenantRepositorySQL = class(TBaseRepository, ITenantRepository)
  private
    FTenantSQLBuilder: ITenantSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: ITenantSQLBuilder);
    function DataSetToEntity(ADtsTenant: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    function LegalEntityNumberExists(ALegalEntityNumber: String; AId: Int64): Boolean;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: ITenantSQLBuilder): ITenantRepository;
    function Show(AId: Int64): TTenant;
    function Store(ATenant: TTenant; AManageTransaction: Boolean): Int64; overload;
    function Update(ATenant: TTenant; AId: Int64; AManageTransaction: Boolean): Boolean; overload;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize,
  uZLQry.Interfaces,
  System.SysUtils,
  uQtdStr,
  uHlp,
  uApplication.Types,
  uSQLBuilder.Factory,
  uLegalEntityNumber.VO;

{ TTenantRepositorySQL }

class function TTenantRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: ITenantSQLBuilder): ITenantRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TTenantRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: ITenantSQLBuilder);
begin
  inherited Create;
  FConn                    := AConn;
  FSQLBuilder              := ASQLBuilder;
  FTenantSQLBuilder        := ASQLBuilder;
end;

function TTenantRepositorySQL.DataSetToEntity(ADtsTenant: TDataSet): TBaseEntity;
var
  lTenant: TTenant;
begin
  lTenant := TTenant.FromJSON(ADtsTenant.ToJSONObjectString);

  // Tenant - Virtuais
  lTenant.legal_entity_number      := TLegalEntityNumberVO.Make(ADtsTenant.FieldByName('legal_entity_number').AsString);
  lTenant.city.id                  := ADtsTenant.FieldByName('city_id').AsLargeInt;
  lTenant.city.name                := ADtsTenant.FieldByName('city_name').AsString;
  lTenant.city.state               := ADtsTenant.FieldByName('city_state').AsString;
  lTenant.city.ibge_code           := ADtsTenant.FieldByName('city_ibge_code').AsString;
  lTenant.created_by_acl_user.id   := ADtsTenant.FieldByName('created_by_acl_user_id').AsLargeInt;
  lTenant.created_by_acl_user.name := ADtsTenant.FieldByName('created_by_acl_user_name').AsString;
  lTenant.updated_by_acl_user.id   := ADtsTenant.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lTenant.updated_by_acl_user.name := ADtsTenant.FieldByName('updated_by_acl_user_name').AsString;

  Result := lTenant;
end;

function TTenantRepositorySQL.LegalEntityNumberExists(ALegalEntityNumber: String; AId: Int64): Boolean;
begin
  Result := not FConn.MakeQry.Open(
    FTenantSQLBuilder.RegisteredLegalEntityNumbers(THlp.OnlyNumbers(ALegalEntityNumber), AId)
  ).DataSet.IsEmpty;
end;

function TTenantRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FTenantSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TTenantRepositorySQL.Show(AId: Int64): TTenant;
var
  lTenant: TTenant;
begin
  Result := nil;

  // Tenant
  lTenant := ShowById(AId) as TTenant;
  if not Assigned(lTenant) then
    Exit;

  Result := lTenant;
end;

function TTenantRepositorySQL.Store(ATenant: TTenant; AManageTransaction: Boolean): Int64;
var
  lPk: Int64;
  lQry: IZLQry;
begin
  // Validar antes de persistir
//  Validate(ATenant);

  // Instanciar Qry
  lQry := FConn.MakeQry;

  Try
    if AManageTransaction then
      FConn.StartTransaction;

    // Incluir Tenant
    lPk := inherited Store(ATenant);

    if AManageTransaction then
      FConn.CommitTransaction;
  except on E: Exception do
    Begin
      if AManageTransaction then
        FConn.RollBackTransaction;
      raise;
    end;
  end;

  Result := lPk;
end;

function TTenantRepositorySQL.Update(ATenant: TTenant; AId: Int64; AManageTransaction: Boolean): Boolean;
var
  lQry: IZLQry;
begin
  // Validar antes de persistir
//  Validate(ATenant);

  // Instanciar Qry
  lQry := FConn.MakeQry;

  Try
    if AManageTransaction then
      FConn.StartTransaction;

    // Atualizar Tenant
    inherited Update(ATenant, AId);

    if AManageTransaction then
      FConn.CommitTransaction;
  except on E: Exception do
    Begin
      if AManageTransaction then
        FConn.RollBackTransaction;
      raise;
    end;
  end;

  Result := True;
end;

procedure TTenantRepositorySQL.Validate(AEntity: TBaseEntity);
var
  lTenant: TTenant;
begin
  lTenant := AEntity as TTenant;

  // Verificar se CPF/CNPJ já existe
  if not lTenant.legal_entity_number.Value.Trim.IsEmpty then
  begin
    if LegalEntityNumberExists(lTenant.legal_entity_number.Value, lTenant.id) then
      raise Exception.Create(Format(FIELD_WITH_VALUE_IS_IN_USE, ['tenant.legal_entity_number', lTenant.legal_entity_number]));
  end;
end;

end.
