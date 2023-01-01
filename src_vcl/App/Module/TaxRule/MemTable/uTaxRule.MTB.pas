unit uTaxRule.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  ITaxRuleMTB = Interface(IEntityMemTable)
    ['{FB231696-9D70-42E1-A259-2E83736B42EF}']
    // TaxRule
    function  TaxRule: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): ITaxRuleMTB;
    function  ToJsonString: String;
    function  CreateTaxRuleIndexMemTable: IZLMemTable;
    procedure TaxRuleSetOperationType(AOperationTypeId: Int64);

    // TaxRuleState
    function  TaxRuleStateList: IZLMemTable;
    function  ValidateCurrentTaxRuleState: String;
    procedure TaxRuleStateSetCFOP(ACFOPId: Int64);
  end;

  TTaxRuleMTB = class(TInterfacedObject, ITaxRuleMTB)
  private
    FTaxRule: IZLMemTable;
    FTaxRuleStateList: IZLMemTable;

    // TaxRule
    procedure TaxRuleAfterInsert(DataSet: TDataSet);

    // TaxRuleStateList
    procedure TaxRuleStateListAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: ITaxRuleMTB;

    // TaxRule
    function  TaxRule: IZLMemTable;
    function  CreateTaxRuleMemTable: IZLMemTable;
    function  CreateTaxRuleIndexMemTable: IZLMemTable;
    procedure TaxRuleSetOperationType(AOperationTypeId: Int64);

    // TaxRuleStateList
    function  TaxRuleStateList: IZLMemTable;
    function  CreateTaxRuleStateListMemTable: IZLMemTable;
    function  FromJsonString(AJsonString: String): ITaxRuleMTB;
    function  ToJsonString: String;
    procedure TaxRuleStateSetCFOP(ACFOPId: Int64);

    procedure Initialize;
    function  Validate: String;
    function  ValidateCurrentTaxRuleState: String;
  end;

implementation

{ TTaxRuleMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp,
  uOperationType.MTB,
  uOperationType.Service,
  Quick.Threads,
  Vcl.Dialogs,
  uApplication.Types,
  uHandle.Exception,
  uCFOP.MTB,
  uCFOP.Service;

function TTaxRuleMTB.TaxRule: IZLMemTable;
begin
  Result := FTaxRule;
end;

procedure TTaxRuleMTB.TaxRuleAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

function TTaxRuleMTB.TaxRuleStateList: IZLMemTable;
begin
  Result := FTaxRuleStateList;
end;

procedure TTaxRuleMTB.TaxRuleStateListAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

procedure TTaxRuleMTB.TaxRuleStateSetCFOP(ACFOPId: Int64);
var
  lMTB: ICFOPMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (ACFOPId <= 0) then Exit;
      lMTB := TCFOPService.Make.Show(ACFOPId);
    end)
  .OnException_Sync(
    procedure(ATask : ITask; AException : Exception)
    begin
      MessageDlg(
        OOPS_MESSAGE + #13 +
        THandleException.TranslateToLayMessage(AException.Message) + #13 + #13 +
        'Mensagem Técnica: ' + AException.Message,
        mtWarning, [mbOK], 0
      );
    end)
  .OnTerminated_Sync(
    procedure(ATask: ITask)
    var
      lKeepGoing: Boolean;
    begin
      Try
        lKeepGoing := FTaxRuleStateList.DataSet.Active and (FTaxRuleStateList.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          ACFOPId := 0;
          Exit;
        End;

        // Carregar resultado
        With FTaxRuleStateList do
        begin
          FieldByName('cfop_id').AsLargeInt := lMTB.CFOP.FieldByName('id').AsLargeInt;
          FieldByName('cfop_code').AsString := lMTB.CFOP.FieldByName('code').AsString;
          FieldByName('cfop_name').AsString := lMTB.CFOP.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (ACFOPId <= 0) and (FTaxRuleStateList.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FTaxRuleStateList do
          begin
            FieldByName('cfop_id').Clear;
            FieldByName('cfop_code').Clear;
            FieldByName('cfop_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

procedure TTaxRuleMTB.TaxRuleSetOperationType(AOperationTypeId: Int64);
var
  lMTB: IOperationTypeMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (AOperationTypeId <= 0) then Exit;
      lMTB := TOperationTypeService.Make.Show(AOperationTypeId);
    end)
  .OnException_Sync(
    procedure(ATask : ITask; AException : Exception)
    begin
      MessageDlg(
        OOPS_MESSAGE + #13 +
        THandleException.TranslateToLayMessage(AException.Message) + #13 + #13 +
        'Mensagem Técnica: ' + AException.Message,
        mtWarning, [mbOK], 0
      );
    end)
  .OnTerminated_Sync(
    procedure(ATask: ITask)
    var
      lKeepGoing: Boolean;
    begin
      Try
        lKeepGoing := FTaxRule.DataSet.Active and (FTaxRule.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          AOperationTypeId := 0;
          Exit;
        End;

        // Carregar resultado
        With FTaxRule do
        begin
          FieldByName('operation_type_id').AsLargeInt := lMTB.OperationType.FieldByName('id').AsLargeInt;
          FieldByName('operation_type_name').AsString := lMTB.OperationType.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (AOperationTypeId <= 0) and (FTaxRule.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FTaxRule do
          begin
            FieldByName('operation_type_id').Clear;
            FieldByName('operation_type_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

constructor TTaxRuleMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TTaxRuleMTB.CreateTaxRuleStateListMemTable: IZLMemTable;
begin
  // TaxRuleStateList
  Result := TMemTableFactory.Make
    .AddField('id',                                      ftLargeint)
    .AddField('tax_rule_id',                             ftLargeint)
    .AddField('target_state',                            ftString, 20)
    .AddField('cfop_id',                                 ftLargeint)
    .AddField('icms_regime',                             ftSmallint)
    .AddField('icms_situation',                          ftSmallint)
    .AddField('icms_origin',                             ftSmallint)
    .AddField('icms_applicable_credit_calc_rate',        ftFloat)
    .AddField('icms_perc_of_used_credit',                ftFloat)
    .AddField('icms_calc_base_mode',                     ftSmallint)
    .AddField('icms_perc_of_calc_base_reduction',        ftFloat)
    .AddField('icms_rate',                               ftFloat)
    .AddField('icms_perc_of_own_operation_calc_base',    ftFloat)
    .AddField('icms_deferral_perc',                      ftFloat)
    .AddField('icms_pst',                                ftFloat)
    .AddField('icms_coupon_rate',                        ftFloat)
    .AddField('icms_is_calc_base_with_insurance',        ftSmallint)
    .AddField('icms_is_calc_base_with_freight',          ftSmallint)
    .AddField('icms_is_calc_base_with_ipi',              ftSmallint)
    .AddField('icms_is_calc_base_with_other_expenses',   ftSmallint)
    .AddField('icmsst_calc_base_mode',                   ftSmallint)
    .AddField('icmsst_perc_of_calc_base_reduction',      ftFloat)
    .AddField('icmsst_rate',                             ftFloat)
    .AddField('icmsst_interstate_rate',                  ftFloat)
    .AddField('icmsst_is_calc_base_with_insurance',      ftSmallint)
    .AddField('icmsst_is_calc_base_with_freight',        ftSmallint)
    .AddField('icmsst_is_calc_base_with_ipi',            ftSmallint)
    .AddField('icmsst_is_calc_base_with_other_expenses', ftSmallint)
    .AddField('ipi_situation',                           ftSmallint)
    .AddField('ipi_rate',                                ftFloat)
    .AddField('pis_situation',                           ftSmallint)
    .AddField('pis_rate',                                ftFloat)
    .AddField('pisst_rate',                              ftFloat)
    .AddField('cofins_situation',                        ftSmallint)
    .AddField('cofins_rate',                             ftFloat)
    .AddField('cofinsst_rate',                           ftFloat)
    .AddField('taxpayer_note',                           ftString, 5000)
    .AddField('cfop_code',                               ftString, 10)
    .AddField('cfop_name',                               ftString, 255)
    .CreateDataSet
  .Active(True);

  // Formatar Dataset
  THlp.FormatDataSet(Result.DataSet);

  // Eventos
  With Result do
  begin
    DataSet.AfterInsert := TaxRuleStateListAfterInsert;
  end;
end;

function TTaxRuleMTB.CreateTaxRuleIndexMemTable: IZLMemTable;
begin
  Result := CreateTaxRuleMemTable;
end;

function TTaxRuleMTB.CreateTaxRuleMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 100)
    .AddField('operation_type_id',        ftLargeint)
    .AddField('is_final_customer',        ftSmallint)
    .AddField('created_at',               ftDateTime)
    .AddField('updated_at',               ftDateTime)
    .AddField('operation_type_name',      ftString, 100)
    .AddField('created_by_acl_user_id',   ftLargeint)
    .AddField('created_by_acl_user_name', ftString, 100)
    .AddField('updated_by_acl_user_id',   ftLargeint)
    .AddField('updated_by_acl_user_name', ftString, 100)
    .CreateDataSet
  .Active(True);

  // Formatar Dataset
  THlp.FormatDataSet(Result.DataSet);

  // Eventos
  With Result do
  begin
    DataSet.AfterInsert := TaxRuleAfterInsert;
  end;
end;

function TTaxRuleMTB.FromJsonString(AJsonString: String): ITaxRuleMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // TaxRule
  FTaxRule.DataSet.LoadFromJSON(lSObj.AsJSON);

  // TaxRuleStateList
  FTaxRuleStateList.DataSet.LoadFromJSON(lSObj.A['tax_rule_state_list'].AsJSON);
end;

procedure TTaxRuleMTB.Initialize;
begin
  FTaxRule          := CreateTaxRuleMemTable;
  FTaxRuleStateList := CreateTaxRuleStateListMemTable;
end;

class function TTaxRuleMTB.Make: ITaxRuleMTB;
begin
  Result := Self.Create;
end;

function TTaxRuleMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // TaxRule
  lSObj := SO(FTaxRule.DataSet.ToJSONObjectString);

  // TaxRuleStateList
  lSObj.A['tax_rule_state_list'] := SA(FTaxRuleStateList.DataSet.ToJSONArrayString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TTaxRuleMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
  lCurrentError: String;
  lI: Integer;
  lBookMark: TBookMark;
begin
  // TaxRule
  With FTaxRule do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;

    if (FieldByName('operation_type_id').AsInteger <= 0) then
      lErrors := lErrors + 'O campo [Tipo de operação] é obrigatório' + #13;
  end;

  // TaxRuleState
  With FTaxRuleStateList.DataSet do
  begin
    Try
      DisableControls;
      lBookMark := GetBookmark;
      lI := 0;
      First;
      while not Eof do
      begin
        Inc(lI);
        lCurrentError := '  ' + ValidateCurrentTaxRuleState;
        if not lCurrentError.Trim.IsEmpty then
          lErrors := lErrors + 'Em Regra Fiscal > UF > Posição: ' + THlp.strZero(lI.ToString,2) + ' > ' + #13 + lCurrentError + #13;

        Next;
        Application.ProcessMessages;
      end;
    finally
      GotoBookmark(lBookMark);
      EnableControls;
      FreeBookmark(lBookMark);
    end;
  end;

  Result := lErrors;
end;

function TTaxRuleMTB.ValidateCurrentTaxRuleState: String;
var
  lErrors: String;
begin
  With FTaxRuleStateList do
  begin
    if FieldByName('target_state').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [UF] é inválido' + #13;

    if (FieldByName('cfop_id').AsLargeInt <= 0) then
      lErrors := lErrors + 'O campo [CFOP] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
