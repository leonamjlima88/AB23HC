unit uPerson.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,

  uApplication.Types,
  uPerson,
  uPerson.Service,
  uAlert.View,
  Skia,
  Skia.Vcl;

type
  TPersonCreateUpdateView = class(TBaseCreateUpdateView)
    Label22: TLabel;
    Panel5: TPanel;
    Label35: TLabel;
    edtId: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    edtname: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    edtalias_name: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FService: IPersonService;
    FEntity: TPerson;
    FEntityResult: TPerson;
    FState: TEntityState;
    FEditPK: Int64;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
    procedure MapFormToEntity;
    procedure MapEntityToForm;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): TPerson;
  end;

const
  TITLE_NAME = 'Pessoa';

implementation

{$R *.dfm}

uses
  uEither,
  Quick.Threads,
  Vcl.Dialogs,
  uHandle.Exception,
  uUserLogged,
  uNotificationView,
  uSession.DTM;

{ TPersonCreateUpdateView }
procedure TPersonCreateUpdateView.BeforeShow;
begin
  // Iniciar Loading
  LoadingForm           := True;
  pnlBackground.Enabled := False;
  pgc.Visible           := False;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (FState in [esUpdate, esView]) then
      begin
        if Assigned(FEntity) then FreeAndNil(FEntity);
        FEntity := FService.Show(FEditPK);
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
        MapEntityToForm;
      finally
        // Encerrar Loading
        LoadingForm           := false;
        pnlBackground.Enabled := True;
        pgc.Visible           := True;
        edtname.SetFocus;
      end;
    end)
  .Run;
end;

procedure TPersonCreateUpdateView.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := MrCancel;
end;

procedure TPersonCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lResult: Either<String, TPerson>;
begin
  inherited;

  // Não prosseguir se estiver carregando
  if LoadingSave or LoadingForm then
    Exit;

  // Carregar dados em entity
  MapFormToEntity;

  // Iniciar Loading
  LoadingSave           := True;
  LoadingForm           := True;
  pgc.Visible           := False;
  pnlBackground.Enabled := False;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore:  lResult := FService.Store(FEntity);
        esUpdate: lResult := FService.Update(FEntity, FEditPK);
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
        if not lResult.Match then
        begin
          TAlertView.Handle(lResult.Left);
          Exit;
        end;

        // Retornar entidade inserida/atualizada
        NotificationView.Execute('Registro salvo com sucesso.', tneSuccess);
        FEntityResult := lResult.Right;
        ModalResult   := MrOK;
      finally
        // Encerrar Loading
        LoadingSave           := False;
        LoadingForm           := False;
        pgc.Visible           := True;
        pnlBackground.Enabled := True;
      end;
    end)
  .Run;
end;

procedure TPersonCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TPersonService.Make;
  FEntity  := TPerson.Create;
end;

procedure TPersonCreateUpdateView.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FEntity) then
    FEntity.Free;
end;

procedure TPersonCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TPersonCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;

  BeforeShow;
end;

class function TPersonCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): TPerson;
var
  lView: TPersonCreateUpdateView;
begin
  Result       := nil;
  lView        := TPersonCreateUpdateView.Create(nil);
  lView.EditPK := AEditPK;
  lView.State  := AState;
  Try
    if (lView.ShowModal = mrOK) then
      Result := lView.FEntityResult;
  Finally
    if Assigned(lView) then
      FreeAndNil(lView);
  End;
end;

procedure TPersonCreateUpdateView.MapEntityToForm;
begin
  // Person
  edtId.Text         := FEntity.id.ToString;
  edtname.Text       := FEntity.name;
  edtalias_name.Text := FEntity.alias_name;
end;

procedure TPersonCreateUpdateView.MapFormToEntity;
begin
  // Person
  FEntity.name       := edtname.Text;
  FEntity.alias_name := edtalias_name.Text;
end;

procedure TPersonCreateUpdateView.SetState(const Value: TEntityState);
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

