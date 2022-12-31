unit uPaymentTerm.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,

  uPaymentTerm.Service,
  uPaymentTerm.MTB,
  uApplication.Types;

type
  TPaymentTermCreateUpdateView = class(TBaseCreateUpdateView)
    dtsPaymentTerm: TDataSource;
    Label35: TLabel;
    Label1: TLabel;
    edtId: TDBEdit;
    Panel1: TPanel;
    Label2: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label36: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edtname: TDBEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    edtbank_account_name: TDBEdit;
    Panel39: TPanel;
    Panel40: TPanel;
    imgLocaBankAccount: TImage;
    edtbank_account_id: TDBEdit;
    edtdocument_name: TDBEdit;
    Panel4: TPanel;
    Panel2: TPanel;
    imgLocaDocument: TImage;
    edtdocument_id: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgLocaBankAccountClick(Sender: TObject);
    procedure imgLocaDocumentClick(Sender: TObject);
    procedure edtFieldExit(Sender: TObject); override;
  private
    FService: IPaymentTermService;
    FMTB: IPaymentTermMTB;
    FHandleResult: IPaymentTermMTB;
    FState: TEntityState;
    FEditPK: Int64;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): IPaymentTermMTB;
  end;

const
  TITLE_NAME = 'Condição de pagamento';

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
  uHlp,
  uBankAccount.Index.View,
  uDocument.Index.View;

{ TPaymentTermCreateUpdateView }
procedure TPaymentTermCreateUpdateView.BeforeShow;
begin
  // Iniciar Loading
  LoadingForm            := True;
  pnlBackground.Enabled  := False;
  pgc.Visible            := False;
  dtsPaymentTerm.DataSet := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore: Begin
          FMTB := TPaymentTermMTB.Make;
          FMTB.PaymentTerm.DataSet.Append;
        end;
        esUpdate, esView: Begin
          FMTB := FService.Show(FEditPK);
          FMTB.PaymentTerm.DataSet.Edit;
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
      LoadingForm           := false;
      pnlBackground.Enabled := True;
      pgc.Visible           := True;
      dtsPaymentTerm.DataSet      := FMTB.PaymentTerm.DataSet;
      if edtName.CanFocus then
        edtName.SetFocus;
    end)
  .Run;
end;

procedure TPaymentTermCreateUpdateView.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := MrCancel;
end;

procedure TPaymentTermCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lSaved: Either<String, IPaymentTermMTB>;
begin
  inherited;

  // Não prosseguir se estiver carregando
  btnFocus.SetFocus;
  if LoadingSave or LoadingForm then
    Exit;

  // Sempre salvar dataset para evitar erros
  if FMTB.PaymentTerm.DataSet.State in [dsInsert, dsEdit] then
    FMTB.PaymentTerm.DataSet.Post;

  // Iniciar Loading
  LoadingSave           := True;
  LoadingForm           := True;
  pgc.Visible           := False;
  pnlBackground.Enabled := False;
  dtsPaymentTerm.DataSet      := nil;

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
          FMTB.PaymentTerm.DataSet.Edit;
          NotificationView.Execute(RECORD_SAVE_FAILED, tneError);
          Exit;
        end;

        // Retornar registro inserido/atualizado
        NotificationView.Execute(RECORD_SAVED, tneSuccess);
        FHandleResult := lSaved.Right;
        ModalResult   := MrOK;
      finally
        // Encerrar Loading
        LoadingSave           := False;
        LoadingForm           := False;
        pgc.Visible           := True;
        pnlBackground.Enabled := True;
        dtsPaymentTerm.DataSet      := FMTB.PaymentTerm.DataSet;
      end;
    end)
  .Run;
end;

procedure TPaymentTermCreateUpdateView.edtFieldExit(Sender: TObject);
begin
  inherited;

  // BankAccount
  if (Sender = edtbank_account_id) then
  begin
    FMTB.PaymentTermSetBankAccount(THlp.StrInt(edtbank_account_id.Text));
    Exit;
  end;

  // Document
  if (Sender = edtdocument_id) then
  begin
    FMTB.PaymentTermSetDocument(THlp.StrInt(edtdocument_id.Text));
    Exit;
  end;
end;

procedure TPaymentTermCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TPaymentTermService.Make;
end;

procedure TPaymentTermCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

  // F1 - Localizar Conta Bancária
  if (Key = VK_F1) and (edtbank_account_id.Focused or edtbank_account_name.Focused) then
  begin
    imgLocaBankAccountClick(imgLocaBankAccount);
    Exit;
  end;

  // F1 - Localizar Documento
  if (Key = VK_F1) and (edtdocument_id.Focused or edtdocument_name.Focused) then
  begin
    imgLocaDocumentClick(imgLocaDocument);
    Exit;
  end;
end;

procedure TPaymentTermCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;

  BeforeShow;
end;

class function TPaymentTermCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): IPaymentTermMTB;
var
  lView: TPaymentTermCreateUpdateView;
begin
  Result       := nil;
  lView        := TPaymentTermCreateUpdateView.Create(nil);
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

procedure TPaymentTermCreateUpdateView.imgLocaBankAccountClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TBankAccountIndexView.HandleLocate;
  if (lPk > 0) then
  Begin
    dtsPaymentTerm.DataSet.FieldByName('bank_account_id').AsLargeInt := lPk;
    EdtFieldExit(edtbank_account_id);
  end;
end;

procedure TPaymentTermCreateUpdateView.imgLocaDocumentClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TDocumentIndexView.HandleLocate;
  if (lPk > 0) then
  Begin
    dtsPaymentTerm.DataSet.FieldByName('document_id').AsLargeInt := lPk;
    EdtFieldExit(edtdocument_id);
  end;
end;

procedure TPaymentTermCreateUpdateView.SetState(const Value: TEntityState);
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

