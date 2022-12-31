unit uBankAccount.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,

  uBankAccount.Service,
  uBankAccount.MTB,
  uApplication.Types;

type
  TBankAccountCreateUpdateView = class(TBaseCreateUpdateView)
    dtsBankAccount: TDataSource;
    Label35: TLabel;
    Label1: TLabel;
    edtId: TDBEdit;
    Panel1: TPanel;
    Label3: TLabel;
    Label5: TLabel;
    Label23: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    edtname: TDBEdit;
    edtbank_id: TDBEdit;
    Panel10: TPanel;
    Panel12: TPanel;
    imgLocaBank: TImage;
    edtbank_name: TDBEdit;
    DBMemo1: TDBMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgLocaBankClick(Sender: TObject);
    procedure edtFieldExit(Sender: TObject); override;
  private
    FService: IBankAccountService;
    FMTB: IBankAccountMTB;
    FHandleResult: IBankAccountMTB;
    FState: TEntityState;
    FEditPK: Int64;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): IBankAccountMTB;
  end;

const
  TITLE_NAME = 'Conta Bancária';

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
  uBank.Index.View;

{ TBankAccountCreateUpdateView }
procedure TBankAccountCreateUpdateView.BeforeShow;
begin
  // Iniciar Loading
  LoadingForm           := True;
  pnlBackground.Enabled := False;
  pgc.Visible           := False;
  dtsBankAccount.DataSet      := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore: Begin
          FMTB := TBankAccountMTB.Make;
          FMTB.BankAccount.DataSet.Append;
        end;
        esUpdate, esView: Begin
          FMTB := FService.Show(FEditPK);
          FMTB.BankAccount.DataSet.Edit;
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
      dtsBankAccount.DataSet      := FMTB.BankAccount.DataSet;
      if edtName.CanFocus then
        edtName.SetFocus;
    end)
  .Run;
end;

procedure TBankAccountCreateUpdateView.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := MrCancel;
end;

procedure TBankAccountCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lSaved: Either<String, IBankAccountMTB>;
begin
  inherited;

  // Não prosseguir se estiver carregando
  btnFocus.SetFocus;
  if LoadingSave or LoadingForm then
    Exit;

  // Sempre salvar dataset para evitar erros
  if FMTB.BankAccount.DataSet.State in [dsInsert, dsEdit] then
    FMTB.BankAccount.DataSet.Post;

  // Iniciar Loading
  LoadingSave           := True;
  LoadingForm           := True;
  pgc.Visible           := False;
  pnlBackground.Enabled := False;
  dtsBankAccount.DataSet      := nil;

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
          FMTB.BankAccount.DataSet.Edit;
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
        dtsBankAccount.DataSet      := FMTB.BankAccount.DataSet;
      end;
    end)
  .Run;
end;

procedure TBankAccountCreateUpdateView.edtFieldExit(Sender: TObject);
begin
  inherited;

  // Banco
  if (Sender = edtbank_id) then
  begin
    FMTB.BankAccountSetBank(THlp.StrInt(edtbank_id.Text));
    Exit;
  end;
end;

procedure TBankAccountCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TBankAccountService.Make;
end;

procedure TBankAccountCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

  // F1 - Localizar Banco
  if (Key = VK_F1) and (edtbank_id.Focused or edtbank_name.Focused) then
  begin
    imgLocaBankClick(imgLocaBank);
    Exit;
  end;
end;

procedure TBankAccountCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;

  BeforeShow;
end;

class function TBankAccountCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): IBankAccountMTB;
var
  lView: TBankAccountCreateUpdateView;
begin
  Result       := nil;
  lView        := TBankAccountCreateUpdateView.Create(nil);
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

procedure TBankAccountCreateUpdateView.imgLocaBankClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TBankIndexView.HandleLocate;
  if (lPk > 0) then
  Begin
    dtsBankAccount.DataSet.FieldByName('bank_id').AsLargeInt := lPk;
    EdtFieldExit(edtbank_id);
  end;
end;

procedure TBankAccountCreateUpdateView.SetState(const Value: TEntityState);
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

