unit uTaxRule.Repository.SQL;

interface

uses
  uBase.Repository,
  uTaxRule.Repository.Interfaces,
  uTaxRule.SQLBuilder.Interfaces,
  uConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uTaxRule,
  uTaxRuleState.SQLBuilder.Interfaces;

type
  TTaxRuleRepositorySQL = class(TBaseRepository, ITaxRuleRepository)
  private
    FTaxRuleSQLBuilder: ITaxRuleSQLBuilder;
    FTaxRuleStateSQLBuilder: ITaxRuleStateSQLBuilder;
    constructor Create(AConn: IConnection; ASQLBuilder: ITaxRuleSQLBuilder);
    function DataSetToEntity(ADtsTaxRule: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    function LoadTaxRuleStatesToShow(ATaxRule: TTaxRule): ITaxRuleRepository;
    function EinExists(AEin: String; AId: Int64): Boolean;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IConnection; ASQLBuilder: ITaxRuleSQLBuilder): ITaxRuleRepository;
    function Show(AId: Int64): TTaxRule;
    function Store(ATaxRule: TTaxRule; AManageTransaction: Boolean): Int64; overload;
    function Update(ATaxRule: TTaxRule; AId: Int64; AManageTransaction: Boolean): Boolean; overload;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize,
  uTaxRuleState,
  uQry.Interfaces,
  System.SysUtils,
  uQtdStr,
  uHlp,
  uApplication.Types,
  uSQLBuilder.Factory;

{ TTaxRuleRepositorySQL }

class function TTaxRuleRepositorySQL.Make(AConn: IConnection; ASQLBuilder: ITaxRuleSQLBuilder): ITaxRuleRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TTaxRuleRepositorySQL.Create(AConn: IConnection; ASQLBuilder: ITaxRuleSQLBuilder);
begin
  inherited Create;
  FConn                   := AConn;
  FSQLBuilder             := ASQLBuilder;
  FTaxRuleSQLBuilder      := ASQLBuilder;
  FTaxRuleStateSQLBuilder := TSQLBuilderFactory.Make(FConn.DriverDB).TaxRuleState;
end;

function TTaxRuleRepositorySQL.DataSetToEntity(ADtsTaxRule: TDataSet): TBaseEntity;
var
  lTaxRule: TTaxRule;
begin
  lTaxRule := TTaxRule.FromJSON(ADtsTaxRule.ToJSONObjectString);

  // TaxRule - Virtuais
  lTaxRule.created_by_acl_user.id   := ADtsTaxRule.FieldByName('created_by_acl_user_id').AsLargeInt;
  lTaxRule.created_by_acl_user.name := ADtsTaxRule.FieldByName('created_by_acl_user_name').AsString;
  lTaxRule.updated_by_acl_user.id   := ADtsTaxRule.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lTaxRule.updated_by_acl_user.name := ADtsTaxRule.FieldByName('updated_by_acl_user_name').AsString;

  Result := lTaxRule;
end;

function TTaxRuleRepositorySQL.EinExists(AEin: String; AId: Int64): Boolean;
begin
  Result := not FConn.MakeQry.Open(
    FTaxRuleSQLBuilder.RegisteredEins(THlp.OnlyNumbers(AEin), AId)
  ).DataSet.IsEmpty;
end;

function TTaxRuleRepositorySQL.LoadTaxRuleStatesToShow(ATaxRule: TTaxRule): ITaxRuleRepository;
var
  lTaxRuleState: TTaxRuleState;
begin
  Result := Self;
  With FConn.MakeQry.Open(FTaxRuleStateSQLBuilder.SelectByTaxRuleId(ATaxRule.id)) do
  begin
    DataSet.First;
    while not DataSet.Eof do
    begin
      lTaxRuleState := TTaxRuleState.FromJSON(DataSet.ToJSONObjectString);

      // TaxRuleState - Virtuais
      lTaxRuleState.cfop.id   := DataSet.FieldByName('cfop_id').AsLargeInt;
      lTaxRuleState.cfop.name := DataSet.FieldByName('cfop_name').AsString;
      lTaxRuleState.cfop.code := DataSet.FieldByName('cfop_code').AsString;

      ATaxRule.tax_rule_state_list.Add(lTaxRuleState);
      DataSet.Next;
    end;
  end;
end;

function TTaxRuleRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FTaxRuleSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TTaxRuleRepositorySQL.Show(AId: Int64): TTaxRule;
var
  lTaxRule: TTaxRule;
begin
  Result := nil;

  // TaxRule
  lTaxRule := ShowById(AId) as TTaxRule;
  if not Assigned(lTaxRule) then
    Exit;

  // TaxRuleStates
  LoadTaxRuleStatesToShow(lTaxRule);

  Result := lTaxRule;
end;

function TTaxRuleRepositorySQL.Store(ATaxRule: TTaxRule; AManageTransaction: Boolean): Int64;
var
  lPk: Int64;
  lTaxRuleState: TTaxRuleState;
  lQry: IQry;
begin
  // Validar antes de persistir
  Validate(ATaxRule);

  // Instanciar Qry
  lQry := FConn.MakeQry;

  Try
    if AManageTransaction then
      FConn.StartTransaction;

    // Incluir TaxRule
    lPk := inherited Store(ATaxRule);

    // Incluir TaxRuleStates
    for lTaxRuleState in ATaxRule.tax_rule_state_list do
    begin
      lTaxRuleState.tax_rule_id := lPk;
      lQry.ExecSQL(FTaxRuleStateSQLBuilder.InsertInto(lTaxRuleState))
    end;

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

function TTaxRuleRepositorySQL.Update(ATaxRule: TTaxRule; AId: Int64; AManageTransaction: Boolean): Boolean;
var
  lTaxRuleState: TTaxRuleState;
  lQry: IQry;
begin
  // Validar antes de persistir
  Validate(ATaxRule);

  // Instanciar Qry
  lQry := FConn.MakeQry;

  Try
    if AManageTransaction then
      FConn.StartTransaction;

    // Atualizar TaxRule
    inherited Update(ATaxRule, AId);

    // Atualizar TaxRuleStates
    lQry.ExecSQL(FTaxRuleStateSQLBuilder.DeleteByTaxRuleId(AId));
    for lTaxRuleState in ATaxRule.tax_rule_state_list do
    begin
      lTaxRuleState.tax_rule_id := AId;
      lQry.ExecSQL(FTaxRuleStateSQLBuilder.InsertInto(lTaxRuleState))
    end;

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

procedure TTaxRuleRepositorySQL.Validate(AEntity: TBaseEntity);
begin
//
end;

end.
