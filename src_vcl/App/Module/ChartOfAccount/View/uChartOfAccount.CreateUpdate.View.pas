unit uChartOfAccount.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,

  uChartOfAccount.Service,
  uChartOfAccount.MTB,
  uApplication.Types;

type
  TChartOfAccountCreateUpdateView = class(TBaseCreateUpdateView)
    dtsChartOfAccount: TDataSource;
    Label35: TLabel;
    Label1: TLabel;
    edtId: TDBEdit;
    Panel1: TPanel;
    Label2: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtname: TDBEdit;
    edthierarchy_code: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    DBMemo1: TDBMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FService: IChartOfAccountService;
    FMTB: IChartOfAccountMTB;
    FHandleResult: IChartOfAccountMTB;
    FState: TEntityState;
    FEditPK: Int64;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): IChartOfAccountMTB;
  end;

const
  TITLE_NAME = 'Plano de Conta';

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
  uYesOrNo.View;

{ TChartOfAccountCreateUpdateView }
procedure TChartOfAccountCreateUpdateView.BeforeShow;
begin
  // Iniciar Loading
  LoadingForm               := True;
  pnlBackground.Enabled     := False;
  pgc.Visible               := False;
  dtsChartOfAccount.DataSet := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore: Begin
          FMTB := TChartOfAccountMTB.Make;
          FMTB.ChartOfAccount.DataSet.Append;
        end;
        esUpdate, esView: Begin
          FMTB := FService.Show(FEditPK);
          FMTB.ChartOfAccount.DataSet.Edit;
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
      LoadingForm               := false;
      pnlBackground.Enabled     := True;
      pgc.Visible               := True;
      dtsChartOfAccount.DataSet := FMTB.ChartOfAccount.DataSet;
      if edthierarchy_code.CanFocus then
        edthierarchy_code.SetFocus;
    end)
  .Run;
end;

procedure TChartOfAccountCreateUpdateView.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := MrCancel;
end;

procedure TChartOfAccountCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lSaved: Either<String, IChartOfAccountMTB>;
begin
  inherited;

  // Não prosseguir se estiver carregando
  btnFocus.SetFocus;
  if LoadingSave or LoadingForm then
    Exit;

  // Sempre salvar dataset para evitar erros
  if FMTB.ChartOfAccount.DataSet.State in [dsInsert, dsEdit] then
    FMTB.ChartOfAccount.DataSet.Post;

  // Iniciar Loading
  LoadingSave               := True;
  LoadingForm               := True;
  pgc.Visible               := False;
  pnlBackground.Enabled     := False;
  dtsChartOfAccount.DataSet := nil;

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
          FMTB.ChartOfAccount.DataSet.Edit;
          NotificationView.Execute(RECORD_SAVE_FAILED, tneError);
          Exit;
        end;

        // Retornar registro inserido/atualizado
        NotificationView.Execute(RECORD_SAVED, tneSuccess);
        FHandleResult := lSaved.Right;
        ModalResult   := MrOK;
      finally
        // Encerrar Loading
        LoadingSave               := False;
        LoadingForm               := False;
        pgc.Visible               := True;
        pnlBackground.Enabled     := True;
        dtsChartOfAccount.DataSet := FMTB.ChartOfAccount.DataSet;
      end;
    end)
  .Run;
end;

procedure TChartOfAccountCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TChartOfAccountService.Make;
end;

procedure TChartOfAccountCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
end;

procedure TChartOfAccountCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;

  BeforeShow;
end;

class function TChartOfAccountCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): IChartOfAccountMTB;
var
  lView: TChartOfAccountCreateUpdateView;
begin
  Result       := nil;
  lView        := TChartOfAccountCreateUpdateView.Create(nil);
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

procedure TChartOfAccountCreateUpdateView.SetState(const Value: TEntityState);
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

