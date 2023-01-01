unit uTaxRule.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,

  uTaxRule.Service,
  uTaxRule.MTB,
  uApplication.Types;

type
  TTaxRuleCreateUpdateView = class(TBaseCreateUpdateView)
    dtsTaxRule: TDataSource;
    dtsTaxRuleStateList: TDataSource;
    Label22: TLabel;
    Label35: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label23: TLabel;
    Panel5: TPanel;
    edtId: TDBEdit;
    edtname: TDBEdit;
    edtoperation_type_id: TDBEdit;
    Panel10: TPanel;
    Panel12: TPanel;
    imgLocaOperationType: TImage;
    edtoperation_type_name: TDBEdit;
    chkis_final_customer: TDBCheckBox;
    Label1: TLabel;
    Panel1: TPanel;
    pnlContact: TPanel;
    dbgTaxRuleStateList: TJvDBGrid;
    Panel29: TPanel;
    imgPersonContactAppend: TImage;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnTaxRuleStateListDeleteClick(Sender: TObject);
    procedure EdtFieldExit(Sender: TObject); override;
    procedure imgTaxRuleStateAddClick(Sender: TObject);
    procedure imgLocaOperationTypeClick(Sender: TObject);
    procedure dbgTaxRuleStateListDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure imgPersonContactAppendClick(Sender: TObject);
    procedure dbgTaxRuleStateListCellClick(Column: TColumn);
    procedure btnTaxRuleStateListEditClick(Sender: TObject);
  private
    FService: ITaxRuleService;
    FMTB: ITaxRuleMTB;
    FHandleResult: ITaxRuleMTB;
    FState: TEntityState;
    FEditPK: Int64;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): ITaxRuleMTB;
  end;

const
  TITLE_NAME = 'Regra Fiscal';

implementation

{$R *.dfm}

uses
  uNotificationView,
  Quick.Threads,
  Vcl.Dialogs,
  uHandle.Exception,
  uEither,
  uAlert.View,
  uSession.DTM,
  uYesOrNo.View,
  uTaxRuleState.CreateUpdate.View,
  uHlp,
  uZLMemTable.Interfaces,
  uIndexResult,
  uOperationType.Index.View;

{ TTaxRuleCreateUpdateView }
procedure TTaxRuleCreateUpdateView.BeforeShow;
begin
  // Iniciar Loading
  LoadingForm                  := True;
  pnlBackground.Enabled        := False;
  pgc.Visible                  := False;
  dtsTaxRule.DataSet           := nil;
  dtsTaxRuleStateList.DataSet  := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore: Begin
          FMTB := TTaxRuleMTB.Make;
          FMTB.TaxRule.DataSet.Append;
        end;
        esUpdate, esView: Begin
          FMTB := FService.Show(FEditPK);
          FMTB.TaxRule.DataSet.Edit;
        end;
      end;
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
    begin
      // Encerrar Loading
      LoadingForm                     := false;
      pnlBackground.Enabled           := True;
      pgc.Visible                     := True;
      dtsTaxRule.DataSet              := FMTB.TaxRule.DataSet;
      dtsTaxRuleStateList.DataSet     := FMTB.TaxRuleStateList.DataSet;
      dbgTaxRuleStateList.DataSource  := dtsTaxRuleStateList;
      if edtname.CanFocus then
        edtname.SetFocus;
    end)
  .Run;
end;

procedure TTaxRuleCreateUpdateView.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := MrCancel;
end;

procedure TTaxRuleCreateUpdateView.btnTaxRuleStateListDeleteClick(Sender: TObject);
begin
  // Mensagem de Sim/Não
  if not (TYesOrNoView.Handle(DO_YOU_WANT_TO_DELETE_SELECTED_RECORD, EXCLUSION) = mrOK) then
    Exit;

  Try
    pnlBackground.Enabled := False;

    dtsTaxRuleStateList.DataSet.Delete;
    NotificationView.Execute(RECORD_DELETED, tneError);
  Finally
    pnlBackground.Enabled := True;
  End;
end;

procedure TTaxRuleCreateUpdateView.btnTaxRuleStateListEditClick(Sender: TObject);
begin
  Try
    pnlBackground.Enabled := False;

    // Incluir Novo Registro
    TTaxRuleStateCreateUpdateView.Handle(esUpdate, FMTB);
  Finally
    pnlBackground.Enabled := true;
  End;
end;

procedure TTaxRuleCreateUpdateView.dbgTaxRuleStateListCellClick(Column: TColumn);
var
  lKeepGoing: Boolean;
begin
  inherited;
  lKeepGoing := Assigned(dtsTaxRuleStateList.DataSet) and dtsTaxRuleStateList.DataSet.Active and (dtsTaxRuleStateList.DataSet.RecordCount > 0);
  if not lKeepGoing then
    Exit;

  // Editar
  if (AnsiLowerCase(Column.FieldName) = 'action_edit') then
    btnTaxRuleStateListEditClick(dbgTaxRuleStateList);

  // Deletar
  if (AnsiLowerCase(Column.FieldName) = 'action_delete') then
    btnTaxRuleStateListDeleteClick(dbgTaxRuleStateList);
end;

procedure TTaxRuleCreateUpdateView.dbgTaxRuleStateListDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
var
  lKeepGoing: Boolean;
begin
  lKeepGoing := Assigned(dtsTaxRuleStateList.DataSet) and (dtsTaxRuleStateList.DataSet.Active) and (dtsTaxRuleStateList.DataSet.RecordCount > 0);
  if not lKeepGoing then
    Exit;

  // Exibir imagem de Editar
  if (AnsiLowerCase(Column.FieldName) = 'action_edit') then
  begin
    TDBGrid(Sender).Canvas.FillRect(Rect);
    SessionDTM.imgListGrid.Draw(TDBGrid(Sender).Canvas, Rect.Left +1,Rect.Top + 1, 0);
  end;

  // Exibir imagem de Deletar
  if (AnsiLowerCase(Column.FieldName) = 'action_delete') then
  begin
    TDBGrid(Sender).Canvas.FillRect(Rect);
    SessionDTM.imgListGrid.Draw(TDBGrid(Sender).Canvas, Rect.Left +1,Rect.Top + 1, 1);
  end;
end;

procedure TTaxRuleCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lSaved: Either<String, ITaxRuleMTB>;
begin
  inherited;

  // Não prosseguir se estiver carregando
  btnFocus.SetFocus;
  if LoadingSave or LoadingForm then
    Exit;

  // Sempre salvar dataset para evitar erros
  if FMTB.TaxRule.DataSet.State in [dsInsert, dsEdit] then
    FMTB.TaxRule.DataSet.Post;

  // Iniciar Loading
  LoadingSave                  := True;
  LoadingForm                  := True;
  pgc.Visible                  := False;
  pnlBackground.Enabled        := False;
  dtsTaxRule.DataSet           := nil;
  dtsTaxRuleStateList.DataSet  := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore:  lSaved := FService.Store(FMTB);
        esUpdate: lSaved := FService.Update(FMTB, FEditPK);
      end;
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
    begin
      Try
        // Abortar se falhar na validação
        if not lSaved.Match then
        begin
          TAlertView.Handle(lSaved.Left);
          FMTB.TaxRule.DataSet.Edit;
          NotificationView.Execute(RECORD_SAVE_FAILED, tneError);
          Exit;
        end;

        // Retornar registro inserido/atualizado
        NotificationView.Execute(RECORD_SAVED, tneSuccess);
        FHandleResult := lSaved.Right;
        ModalResult   := MrOK;
      finally
        // Encerrar Loading
        LoadingSave                  := False;
        LoadingForm                  := False;
        pgc.Visible                  := True;
        pnlBackground.Enabled        := True;
        dtsTaxRule.DataSet           := FMTB.TaxRule.DataSet;
        dtsTaxRuleStateList.DataSet  := FMTB.TaxRuleStateList.DataSet;
      end;
    end)
  .Run;
end;

procedure TTaxRuleCreateUpdateView.EdtFieldExit(Sender: TObject);
begin
  inherited;

  // Tipo de Operação
  if (Sender = edtoperation_type_id) then
  begin
    FMTB.TaxRuleSetOperationType(THlp.StrInt(edtoperation_type_id.Text));
    Exit;
  end;
end;

procedure TTaxRuleCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TTaxRuleService.Make;
end;

procedure TTaxRuleCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  // Esc - Sair
  if (Key = VK_ESCAPE) then
  begin
    btnCancelClick(btnCancel);
    Exit;
  end;

  // F6 - Salvar
  if ((Key = VK_F6) and pnlSave.Visible) then
  begin
    btnSaveClick(btnSave);
    Exit;
  end;

  // F1 - Localizar Tipo de Operacao
  if (Key = VK_F1) and (edtoperation_type_id.Focused or edtoperation_type_name.Focused) then
  begin
    imgLocaOperationTypeClick(imgLocaOperationType);
    Exit;
  end;
end;

procedure TTaxRuleCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;

  BeforeShow;
end;

class function TTaxRuleCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): ITaxRuleMTB;
var
  lView: TTaxRuleCreateUpdateView;
begin
  Result       := nil;
  lView        := TTaxRuleCreateUpdateView.Create(nil);
  lView.EditPK := AEditPK;
  lView.State  := AState;
  Try
    if (lView.ShowModal = mrOK) then
      Result := lView.FHandleResult;
  Finally
    if Assigned(lView) then
      FreeAndNil(lView);
  End;
end;

procedure TTaxRuleCreateUpdateView.imgLocaOperationTypeClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TOperationTypeIndexView.HandleLocate;
  if (lPk > 0) then
  Begin
    dtsTaxRule.DataSet.FieldByName('operation_type_id').AsLargeInt := lPk;
    EdtFieldExit(edtoperation_type_id);
  end;
end;

procedure TTaxRuleCreateUpdateView.imgPersonContactAppendClick(Sender: TObject);
begin
  inherited;

  Try
    pnlBackground.Enabled := False;

    // Incluir Novo Registro
    TTaxRuleStateCreateUpdateView.Handle(esStore, FMTB);
  Finally
    pnlBackground.Enabled := true;
  End;
end;

procedure TTaxRuleCreateUpdateView.imgTaxRuleStateAddClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TTaxRuleCreateUpdateView.SetState(const Value: TEntityState);
begin
  FState := Value;

  case FState of
    esStore:  lblTitle.Caption := TITLE_NAME + ' (Incluindo...)';
    esUpdate: lblTitle.Caption := TITLE_NAME + ' (Editando...)';
    esView: Begin
      lblTitle.Caption        := TITLE_NAME + ' (Visualizando...)';
      pnlTitle.Color          := clGray;
      pnlSave.Visible         := False;
      pnlCancel.Margins.Right := 0;
    end;
  end;
end;

end.

