unit uTaxRuleState.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl, JvExStdCtrls, JvCombobox, JvDBCombobox,

  uApplication.Types,
  uTaxRule.MTB,
  uZLMemTable.Interfaces;

type
  TTaxRuleStateCreateUpdateView = class(TBaseCreateUpdateView)
    dtsTaxRuleState: TDataSource;
    Panel5: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    btnLocaCFOP: TImage;
    edtcfop_id: TDBEdit;
    edtcfop_code: TDBEdit;
    cbxtarget_state: TDBComboBox;
    pgc2: TPageControl;
    TabSheet3: TTabSheet;
    pnlICMSConteudo: TPanel;
    lblICMS_ALIQ_APLIC_CALC_CREDITO: TLabel;
    lblICMS_CRED_APROVEITADO_XPERC: TLabel;
    lblicms_pst: TLabel;
    lblicms_aliqcfiscal: TLabel;
    pnlICMSTopo: TPanel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    cbxicms_situation: TJvDBComboBox;
    cbxicms_origin: TJvDBComboBox;
    cbxicms_regime: TJvDBComboBox;
    edticms_applicable_credit_calc_rate: TDBEdit;
    edticms_perc_of_used_credit: TDBEdit;
    edticms_pst: TDBEdit;
    Panel72: TPanel;
    Panel73: TPanel;
    Panel74: TPanel;
    lblICMS_MODBC: TLabel;
    lblicms_perc_red_bc: TLabel;
    lblicms_aliq: TLabel;
    lblicms_perc_bc_oper_propria: TLabel;
    lblicms_bc_add: TLabel;
    lblicms_diferimento_perc: TLabel;
    cbxicms_calc_base_mode: TJvDBComboBox;
    edticms_perc_of_calc_base_reduction: TDBEdit;
    edticms_rate: TDBEdit;
    edticms_perc_of_own_operation_calc_base: TDBEdit;
    chkicms_is_calc_base_with_insurance: TDBCheckBox;
    chkicms_is_calc_base_with_freight: TDBCheckBox;
    chkicms_is_calc_base_with_other_expenses: TDBCheckBox;
    chkicms_is_calc_base_with_ipi: TDBCheckBox;
    edticms_deferral_perc: TDBEdit;
    Panel39: TPanel;
    Panel40: TPanel;
    Panel41: TPanel;
    lblicmsst_modbc: TLabel;
    lblicmsst_perc_red_bc: TLabel;
    lblicmsst_aliq: TLabel;
    lblicmsst_bc_add: TLabel;
    lblicmsst_aliq_inter: TLabel;
    cbxicmsst_calc_base_mode: TJvDBComboBox;
    edticmsst_perc_of_calc_base_reduction: TDBEdit;
    edticmsst_rate: TDBEdit;
    chkicmsst_is_calc_base_with_insurance: TDBCheckBox;
    chkicmsst_is_calc_base_with_freight: TDBCheckBox;
    chkicmsst_is_calc_base_with_other_expenses: TDBCheckBox;
    chkicmsst_is_calc_base_with_ipi: TDBCheckBox;
    edticmsst_interstate_rate: TDBEdit;
    cbxicms_coupon_rate: TJvDBComboBox;
    TabSheet4: TTabSheet;
    pnlIPI: TPanel;
    Label48: TLabel;
    lblipi_aliq_perc: TLabel;
    cbxipi_situation: TJvDBComboBox;
    edtipi_rate: TDBEdit;
    TabSheet5: TTabSheet;
    pnlPIS: TPanel;
    Label52: TLabel;
    lblpis_aliq_perc: TLabel;
    lblpisst_aliq_perc: TLabel;
    cbxpis_situation: TJvDBComboBox;
    Panel7: TPanel;
    Panel19: TPanel;
    edtpis_rate: TDBEdit;
    edtpisst_rate: TDBEdit;
    TabSheet6: TTabSheet;
    pnlCofins: TPanel;
    Label54: TLabel;
    lblcofins_aliq_perc: TLabel;
    lblcofinsst_aliq_perc: TLabel;
    cbxcofins_situation: TJvDBComboBox;
    Panel20: TPanel;
    Panel21: TPanel;
    edtcofins_rate: TDBEdit;
    edtcofinsst_rate: TDBEdit;
    TabSheet1: TTabSheet;
    Panel6: TPanel;
    memtaxpayer_note: TDBMemo;
    edtcfop_name: TDBEdit;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnLocaCFOPClick(Sender: TObject);
    procedure edtFieldExit(Sender: TObject); override;
  private
    FState: TEntityState;
    FMTB: ITaxRuleMTB;
    FMTBBackup: IZLMemTable;
    FMTBBackupRecNumber: Integer;
    procedure BeforeShow;
  public
    class function Handle(AState: TEntityState; AMTB: ITaxRuleMTB): Integer;
  end;

const
  TITLE_NAME = 'Regra Fiscal > UF';

implementation

uses
  Vcl.Dialogs,
  uHandle.Exception,
  uAlert.View,
  uMemTable.Factory,
  uHlp,
  uCFOP.Index.View;

{$R *.dfm}

{ TTaxRuleStateCreateUpdateView }

procedure TTaxRuleStateCreateUpdateView.BeforeShow;
begin
  // Efetua uma cópia para restaurar se necessário
  dtsTaxRuleState.DataSet := FMTB.TaxRuleStateList.DataSet;
  FMTBBackup.FromDataSet(dtsTaxRuleState.DataSet);
  FMTBBackupRecNumber := dtsTaxRuleState.DataSet.RecNo;

  // Iniciar Loading
  Try
    LoadingForm              := True;
    pnlBackground.Enabled    := False;
    pgc.Visible              := False;
    dtsTaxRuleState.DataSet := nil;

    case FState of
      esStore: Begin
        lblTitle.Caption := TITLE_NAME + ' (Incluindo...)';
        FMTB.TaxRuleStateList.DataSet.Append;
      end;
      esUpdate, esView: Begin
        lblTitle.Caption := TITLE_NAME + ' (Editando...)';
        FMTB.TaxRuleStateList.DataSet.Edit;
      end;
    end;
  finally
    // Encerrar Loading
    LoadingForm              := false;
    pnlBackground.Enabled    := True;
    pgc.Visible              := True;
    dtsTaxRuleState.DataSet  := FMTB.TaxRuleStateList.DataSet;
    if cbxtarget_state.CanFocus then cbxtarget_state.SetFocus;
  end;
end;

procedure TTaxRuleStateCreateUpdateView.btnCancelClick(Sender: TObject);
var
  lI: Integer;
begin
  inherited;

  // Cancelar Operação
  case FState of
    esStore: Begin
      case dtsTaxRuleState.DataSet.State of
        dsInsert: dtsTaxRuleState.DataSet.Cancel;
        dsBrowse: dtsTaxRuleState.DataSet.Delete;
        dsEdit: Begin
          dtsTaxRuleState.DataSet.Cancel;
          dtsTaxRuleState.DataSet.Delete;
        end;
      end;
    end;
    esUpdate: Begin
      // Restaurar dados anteriores (Evita erros)
      FMTBBackup.DataSet.First;
      for lI := 2 to FMTBBackupRecNumber do
        FMTBBackup.DataSet.Next;
      dtsTaxRuleState.DataSet.Edit;
      for lI := 0 to Pred(dtsTaxRuleState.DataSet.Fields.Count) do
        dtsTaxRuleState.DataSet.Fields[lI].Value := FMTBBackup.DataSet.FieldByName(dtsTaxRuleState.DataSet.Fields[lI].FieldName).Value;
      dtsTaxRuleState.DataSet.Post;
    end;
  end;

  ModalResult := MrCancel;
end;

procedure TTaxRuleStateCreateUpdateView.btnLocaCFOPClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TCFOPIndexView.HandleLocate;
  if (lPk > 0) then
  Begin
    dtsTaxRuleState.DataSet.FieldByName('cfop_id').AsLargeInt := lPk;
    EdtFieldExit(edtcfop_id);
  end;
end;

procedure TTaxRuleStateCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lErrors: String;
begin
  btnFocus.SetFocus;
  Try
    // Ativar Loading
    LoadingSave := True;

    // Sempre salvar dataset para evitar erros
    if FMTB.TaxRuleStateList.DataSet.State in [dsInsert, dsEdit] then
      FMTB.TaxRuleStateList.DataSet.Post;

    // Validar dados
    lErrors := FMTB.ValidateCurrentTaxRuleState;
    if not lErrors.Trim.IsEmpty then
    begin
      TAlertView.Handle(lErrors);
      FMTB.TaxRuleStateList.DataSet.Edit;
      Abort;
    end;

    ModalResult := mrOk;
  Finally
    LoadingSave := False;
  End;
end;

procedure TTaxRuleStateCreateUpdateView.edtFieldExit(Sender: TObject);
begin
  inherited;

  // CFOP
  if (Sender = edtcfop_id) then
  begin
    FMTB.TaxRuleStateSetCFOP(THlp.StrInt(edtcfop_id.Text));
    Exit;
  end;
end;

procedure TTaxRuleStateCreateUpdateView.FormCreate(Sender: TObject);
var
  lState: String;
begin
  inherited;
  FMTBBackup := TMemTableFactory.Make;
  pgc2.ActivePageIndex := 0;

  // Carregar UFs
  cbxtarget_state.Items.Clear;
  for lState in THlp.StateList do
    cbxtarget_state.Items.Add(lState);
  cbxtarget_state.Items.Add('UF DO EMITENTE');
  cbxtarget_state.Items.Add('OUTROS UFS');
end;

procedure TTaxRuleStateCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  // Esc - Sair
  if (Key = VK_ESCAPE) then
  begin
    btnCancelClick(btnCancel);
    Exit;
  end;

  // F6 - Salvar
  if (Key = VK_F6) then
  begin
    btnSaveClick(btnSave);
    Exit;
  end;

  // F1 - Localizar CFOP
  if (Key = VK_F1) and (edtcfop_id.Focused or edtcfop_code.Focused or edtcfop_name.Focused) then
  begin
    btnLocaCFOPClick(btnLocaCFOP);
    Exit;
  end;
end;

procedure TTaxRuleStateCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;
  BeforeShow;
end;

class function TTaxRuleStateCreateUpdateView.Handle(AState: TEntityState; AMTB: ITaxRuleMTB): Integer;
var
  lView: TTaxRuleStateCreateUpdateView;
begin
  lView := TTaxRuleStateCreateUpdateView.Create(nil);
  Try
    lView.FState := AState;
    lView.FMTB   := AMTB;

    Result := lView.ShowModal;
  Finally
    lView.Free;
  End;
end;

end.

