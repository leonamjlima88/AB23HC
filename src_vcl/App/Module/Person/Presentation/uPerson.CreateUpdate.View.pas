unit uPerson.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,

  uPerson.Service,
  uPerson.MemTable,
  uApplication.Types;

type
  TPersonCreateUpdateView = class(TBaseCreateUpdateView)
    Label22: TLabel;
    Panel5: TPanel;
    Label35: TLabel;
    edtId: TDBEdit;
    Label3: TLabel;
    Label5: TLabel;
    edtname: TDBEdit;
    dtsPerson: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    dtsPersonContactList: TDataSource;
    dbgPersonContactList: TJvDBGrid;
    btnPersonContactListAdd: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgPersonContactListDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnPersonContactListAddClick(Sender: TObject);
    procedure dbgPersonContactListCellClick(Column: TColumn);
    procedure btnPersonContactListDeleteClick(Sender: TObject);
    procedure btnPersonContactListEditClick(Sender: TObject);
  private
    FService: IPersonService;
    FMTB: IPersonMemTable;
    FHandleResult: IPersonMemTable;
    FState: TEntityState;
    FEditPK: Int64;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): IPersonMemTable;
  end;

const
  TITLE_NAME = 'Pessoa';

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
  uPersonContact.CreateUpdate.View;

{ TPersonCreateUpdateView }
procedure TPersonCreateUpdateView.BeforeShow;
begin
  // Iniciar Loading
  LoadingForm                  := True;
  pnlBackground.Enabled        := False;
  pgc.Visible                  := False;
  dtsPerson.DataSet            := nil;
  dtsPersonContactList.DataSet := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore: Begin
          FMTB := TPersonMemTable.Make;
          FMTB.Person.DataSet.Append;
        end;
        esUpdate, esView: Begin
          FMTB := FService.Show(FEditPK);
          FMTB.Person.DataSet.Edit;
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
      dtsPerson.DataSet               := FMTB.Person.DataSet;
      dtsPersonContactList.DataSet    := FMTB.PersonContactList.DataSet;
      dbgPersonContactList.DataSource := dtsPersonContactList;
      edtname.SetFocus;
    end)
  .Run;
end;

procedure TPersonCreateUpdateView.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := MrCancel;
end;

procedure TPersonCreateUpdateView.btnPersonContactListAddClick(Sender: TObject);
begin
  Try
    pnlBackground.Enabled := False;

    // Incluir Novo Registro
    TPersonContactCreateUpdateView.Handle(esStore, FMTB);
  Finally
    pnlBackground.Enabled := true;
  End;
end;

procedure TPersonCreateUpdateView.btnPersonContactListDeleteClick(Sender: TObject);
begin
  // Mensagem de Sim/Não
  if not (TYesOrNoView.Handle(DO_YOU_WANT_TO_DELETE_SELECTED_RECORD, EXCLUSION) = mrOK) then
    Exit;

  Try
    pnlBackground.Enabled := False;

    dtsPersonContactList.DataSet.Delete;
    NotificationView.Execute(RECORD_DELETED, tneError);
  Finally
    pnlBackground.Enabled := True;
  End;
end;

procedure TPersonCreateUpdateView.btnPersonContactListEditClick(Sender: TObject);
begin
  Try
    pnlBackground.Enabled := False;

    // Incluir Novo Registro
    TPersonContactCreateUpdateView.Handle(esUpdate, FMTB);
  Finally
    pnlBackground.Enabled := true;
  End;
end;

procedure TPersonCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lSaved: Either<String, IPersonMemTable>;
begin
  inherited;

  // Não prosseguir se estiver carregando
  btnFocus.SetFocus;
  if LoadingSave or LoadingForm then
    Exit;

  // Sempre salvar dataset para evitar erros
  if FMTB.Person.DataSet.State in [dsInsert, dsEdit] then
    FMTB.Person.DataSet.Post;

  // Iniciar Loading
  LoadingSave                  := True;
  LoadingForm                  := True;
  pgc.Visible                  := False;
  pnlBackground.Enabled        := False;
  dtsPerson.DataSet            := nil;
  dtsPersonContactList.DataSet := nil;

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
          FMTB.Person.DataSet.Edit;
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
        dtsPerson.DataSet            := FMTB.Person.DataSet;
        dtsPersonContactList.DataSet := FMTB.PersonContactList.DataSet;
      end;
    end)
  .Run;
end;

procedure TPersonCreateUpdateView.dbgPersonContactListCellClick(Column: TColumn);
var
  lKeepGoing: Boolean;
begin
  inherited;
  lKeepGoing := Assigned(dtsPersonContactList.DataSet) and dtsPersonContactList.DataSet.Active and (dtsPersonContactList.DataSet.RecordCount > 0);
  if not lKeepGoing then
    Exit;

  // Editar
  if (AnsiLowerCase(Column.FieldName) = 'action_edit') then
    btnPersonContactListEditClick(dbgPersonContactList);

  // Deletar
  if (AnsiLowerCase(Column.FieldName) = 'action_delete') then
    btnPersonContactListDeleteClick(dbgPersonContactList);
end;

procedure TPersonCreateUpdateView.dbgPersonContactListDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
Var
  lI: Integer;
  lKeepGoing: Boolean;
begin
  inherited;
  lKeepGoing := Assigned(dtsPersonContactList.DataSet) and (dtsPersonContactList.DataSet.Active) and (dtsPersonContactList.DataSet.RecordCount > 0);
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

  // Exibir imagem de Visualizar
  if (AnsiLowerCase(Column.FieldName) = 'action_view') then
  begin
    TDBGrid(Sender).Canvas.FillRect(Rect);
    SessionDTM.imgListGrid.Draw(TDBGrid(Sender).Canvas, Rect.Left +1,Rect.Top + 1, 2);
  end;
end;

procedure TPersonCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TPersonService.Make;
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

class function TPersonCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): IPersonMemTable;
var
  lView: TPersonCreateUpdateView;
begin
  Result       := nil;
  lView        := TPersonCreateUpdateView.Create(nil);
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

