unit uSize.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,

  uSize.Service,
  uSize.MTB,
  uApplication.Types;

type
  TSizeCreateUpdateView = class(TBaseCreateUpdateView)
    dtsSize: TDataSource;
    Label35: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    edtId: TDBEdit;
    Panel1: TPanel;
    edtname: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FService: ISizeService;
    FMTB: ISizeMTB;
    FHandleResult: ISizeMTB;
    FState: TEntityState;
    FEditPK: Int64;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): ISizeMTB;
  end;

const
  TITLE_NAME = 'Tamanho';

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

{ TSizeCreateUpdateView }
procedure TSizeCreateUpdateView.BeforeShow;
begin
  // Iniciar Loading
  LoadingForm           := True;
  pnlBackground.Enabled := False;
  pgc.Visible           := False;
  dtsSize.DataSet      := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore: Begin
          FMTB := TSizeMTB.Make;
          FMTB.Size.DataSet.Append;
        end;
        esUpdate, esView: Begin
          FMTB := FService.Show(FEditPK);
          FMTB.Size.DataSet.Edit;
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
      dtsSize.DataSet      := FMTB.Size.DataSet;
      if edtName.CanFocus then
        edtName.SetFocus;
    end)
  .Run;
end;

procedure TSizeCreateUpdateView.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := MrCancel;
end;

procedure TSizeCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lSaved: Either<String, ISizeMTB>;
begin
  inherited;

  // Não prosseguir se estiver carregando
  btnFocus.SetFocus;
  if LoadingSave or LoadingForm then
    Exit;

  // Sempre salvar dataset para evitar erros
  if FMTB.Size.DataSet.State in [dsInsert, dsEdit] then
    FMTB.Size.DataSet.Post;

  // Iniciar Loading
  LoadingSave           := True;
  LoadingForm           := True;
  pgc.Visible           := False;
  pnlBackground.Enabled := False;
  dtsSize.DataSet      := nil;

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
          FMTB.Size.DataSet.Edit;
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
        dtsSize.DataSet      := FMTB.Size.DataSet;
      end;
    end)
  .Run;
end;

procedure TSizeCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TSizeService.Make;
end;

procedure TSizeCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TSizeCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;

  BeforeShow;
end;

class function TSizeCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): ISizeMTB;
var
  lView: TSizeCreateUpdateView;
begin
  Result       := nil;
  lView        := TSizeCreateUpdateView.Create(nil);
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

procedure TSizeCreateUpdateView.SetState(const Value: TEntityState);
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

