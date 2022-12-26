unit uBrand.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,

  uApplication.Types,
  uBrand,
  uBrand.Service,
  uAlert.View,
  Skia,
  Skia.Vcl;

type
  TBrandCreateUpdateView = class(TBaseCreateUpdateView)
    Label22: TLabel;
    Panel5: TPanel;
    Label35: TLabel;
    edtId: TEdit;
    Label3: TLabel;
    Label5: TLabel;
    edtname: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FService: IBrandService;
    FEntity: TBrand;
    FEntityResult: TBrand;
    FState: TEntityState;
    FEditPK: Int64;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
    procedure MapFormToEntity;
    procedure MapEntityToForm;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): TBrand;
  end;

const
  TITLE_NAME = 'Marca';

implementation

{$R *.dfm}

uses
  uEither,
  Quick.Threads,
  Vcl.Dialogs,
  uHandle.Exception,
  uUserLogged,
  uNotificationView;

{ TBrandCreateUpdateView }
procedure TBrandCreateUpdateView.BeforeShow;
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

procedure TBrandCreateUpdateView.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := MrCancel;
end;

procedure TBrandCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lResult: Either<String, TBrand>;
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

procedure TBrandCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TBrandService.Make;
  FEntity  := TBrand.Create;
end;

procedure TBrandCreateUpdateView.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FEntity) then
    FEntity.Free;
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

class function TBrandCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): TBrand;
var
  lView: TBrandCreateUpdateView;
begin
  Result       := nil;
  lView        := TBrandCreateUpdateView.Create(nil);
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

procedure TBrandCreateUpdateView.MapEntityToForm;
begin
  edtId.Text   := FEntity.id.ToString;
  edtname.Text := FEntity.name;
end;

procedure TBrandCreateUpdateView.MapFormToEntity;
begin
  FEntity.name := edtname.Text;
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

