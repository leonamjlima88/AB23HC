unit uBrand.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl,

  uBrand.Service,
  uBrand.DataSet,
  uApplication.Types;

type
  TBrandCreateUpdateView = class(TBaseCreateUpdateView)
    Label22: TLabel;
    Panel5: TPanel;
    Label35: TLabel;
    edtId: TDBEdit;
    Label3: TLabel;
    Label5: TLabel;
    edtname: TDBEdit;
    dtsBrand: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FService: IBrandService;
    FDataSet: IBrandDataSet;
    FHandleResult: IBrandDataSet;
    FState: TEntityState;
    FEditPK: Int64;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): IBrandDataSet;
  end;

const
  TITLE_NAME = 'Marca';

implementation

{$R *.dfm}

uses
  uNotificationView,
  Quick.Threads,
  Vcl.Dialogs,
  uHandle.Exception,
  uEither,
  uAlert.View;

{ TBrandCreateUpdateView }
procedure TBrandCreateUpdateView.BeforeShow;
begin
  // Iniciar Loading
  LoadingForm           := True;
  pnlBackground.Enabled := False;
  pgc.Visible           := False;
  dtsBrand.DataSet      := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore: Begin
          FDataSet := TBrandDataSet.Make;
          FDataSet.Brand.DataSet.Append;
        end;
        esUpdate, esView: Begin
          FDataSet := FService.Show(FEditPK);
          FDataSet.Brand.DataSet.Edit;
        end;
      end;
    end)
  .OnException_Sync(
    procedure(ATask : ITask; AException : Exception)
    begin
      MessageDlg(
        OOPS_MESSAGE + #13 +
        THandleException.TranslateToLayMessage(AException.Message) + #13 + #13 +
        'Mensagem T�cnica: ' + AException.Message,
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
      dtsBrand.DataSet      := FDataSet.Brand.DataSet;
      edtname.SetFocus;
    end)
  .Run;
end;

procedure TBrandCreateUpdateView.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := MrCancel;
end;

procedure TBrandCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lSaved: Either<String, IBrandDataSet>;
begin
  inherited;

  // N�o prosseguir se estiver carregando
  btnFocus.SetFocus;
  if LoadingSave or LoadingForm then
    Exit;

  // Sempre salvar dataset para evitar erros
  if FDataSet.Brand.DataSet.State in [dsInsert, dsEdit] then
    FDataSet.Brand.DataSet.Post;

  // Iniciar Loading
  LoadingSave           := True;
  LoadingForm           := True;
  pgc.Visible           := False;
  pnlBackground.Enabled := False;
  dtsBrand.DataSet      := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore:  lSaved := FService.Store(FDataSet);
        esUpdate: lSaved := FService.Update(FDataSet, FEditPK);
      end;
    end)
  .OnException_Sync(
    procedure(ATask : ITask; AException : Exception)
    begin
      MessageDlg(
        OOPS_MESSAGE + #13 +
        THandleException.TranslateToLayMessage(AException.Message) + #13 + #13 +
        'Mensagem T�cnica: ' + AException.Message,
        mtWarning, [mbOK], 0
      );
    end)
  .OnTerminated_Sync(
    procedure(ATask: ITask)
    begin
      Try
        // Abortar se falhar na valida��o
        if not lSaved.Match then
        begin
          TAlertView.Handle(lSaved.Left);
          FDataSet.Brand.DataSet.Edit;
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
        dtsBrand.DataSet      := FDataSet.Brand.DataSet;
      end;
    end)
  .Run;
end;

procedure TBrandCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TBrandService.Make;
end;

procedure TBrandCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TBrandCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;

  BeforeShow;
end;

class function TBrandCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): IBrandDataSet;
var
  lView: TBrandCreateUpdateView;
begin
  Result       := nil;
  lView        := TBrandCreateUpdateView.Create(nil);
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

procedure TBrandCreateUpdateView.SetState(const Value: TEntityState);
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

