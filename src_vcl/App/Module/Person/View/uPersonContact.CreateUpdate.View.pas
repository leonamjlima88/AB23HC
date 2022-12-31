unit uPersonContact.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl,

  uApplication.Types,
  uPerson.MTB,
  uZLMemTable.Interfaces;

type
  TPersonContactCreateUpdateView = class(TBaseCreateUpdateView)
    Label22: TLabel;
    Panel5: TPanel;
    dtsPersonContact: TDataSource;
    Label2: TLabel;
    Label10: TLabel;
    Label15: TLabel;
    Label27: TLabel;
    Label31: TLabel;
    Label6: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtname: TDBEdit;
    edtein: TDBEdit;
    edtphone: TDBEdit;
    edtemail: TDBEdit;
    cbxtype: TDBComboBox;
    Panel1: TPanel;
    memNote: TDBMemo;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FState: TEntityState;
    FMTB: IPersonMTB;
    FMTBBackup: IZLMemTable;
    FMTBBackupRecNumber: Integer;
    procedure BeforeShow;
  public
    class function Handle(AState: TEntityState; AMTB: IPersonMTB): Integer;
  end;

const
  TITLE_NAME = 'Pessoa > Contato';

implementation

uses
  Vcl.Dialogs,
  uHandle.Exception,
  uAlert.View,
  uMemTable.Factory;

{$R *.dfm}

{ TPersonContactCreateUpdateView }

procedure TPersonContactCreateUpdateView.BeforeShow;
begin
  // Efetua uma cópia para restaurar se necessário
  dtsPersonContact.DataSet := FMTB.PersonContactList.DataSet;
  FMTBBackup.FromDataSet(dtsPersonContact.DataSet);
  FMTBBackupRecNumber := dtsPersonContact.DataSet.RecNo;

  // Iniciar Loading
  Try
    LoadingForm              := True;
    pnlBackground.Enabled    := False;
    pgc.Visible              := False;
    dtsPersonContact.DataSet := nil;

    case FState of
      esStore: Begin
        lblTitle.Caption := TITLE_NAME + ' (Incluindo...)';
        FMTB.PersonContactList.DataSet.Append;
      end;
      esUpdate, esView: Begin
        lblTitle.Caption := TITLE_NAME + ' (Editando...)';
        FMTB.PersonContactList.DataSet.Edit;
      end;
    end;
  finally
    // Encerrar Loading
    LoadingForm              := false;
    pnlBackground.Enabled    := True;
    pgc.Visible              := True;
    dtsPersonContact.DataSet := FMTB.PersonContactList.DataSet;
    edtname.SetFocus;
  end;
end;

procedure TPersonContactCreateUpdateView.btnCancelClick(Sender: TObject);
var
  lI: Integer;
begin
  inherited;

  // Cancelar Operação
  case FState of
    esStore: Begin
      case dtsPersonContact.DataSet.State of
        dsInsert: dtsPersonContact.DataSet.Cancel;
        dsBrowse: dtsPersonContact.DataSet.Delete;
        dsEdit: Begin
          dtsPersonContact.DataSet.Cancel;
          dtsPersonContact.DataSet.Delete;
        end;
      end;
    end;
    esUpdate: Begin
      // Restaurar dados anteriores (Evita erros)
      FMTBBackup.DataSet.First;
      for lI := 2 to FMTBBackupRecNumber do
        FMTBBackup.DataSet.Next;
      dtsPersonContact.DataSet.Edit;
      for lI := 0 to Pred(dtsPersonContact.DataSet.Fields.Count) do
        dtsPersonContact.DataSet.Fields[lI].Value := FMTBBackup.DataSet.FieldByName(dtsPersonContact.DataSet.Fields[lI].FieldName).Value;
      dtsPersonContact.DataSet.Post;
    end;
  end;

  ModalResult := MrCancel;
end;

procedure TPersonContactCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lErrors: String;
begin
  btnFocus.SetFocus;
  Try
    // Ativar Loading
    LoadingSave := True;

    // Sempre salvar dataset para evitar erros
    if FMTB.PersonContactList.DataSet.State in [dsInsert, dsEdit] then
      FMTB.PersonContactList.DataSet.Post;

    // Validar dados
    lErrors := FMTB.ValidateCurrentPersonContact;
    if not lErrors.Trim.IsEmpty then
    begin
      TAlertView.Handle(lErrors);
      FMTB.PersonContactList.DataSet.Edit;
      Abort;
    end;

    ModalResult := mrOk;
  Finally
    LoadingSave := False;
  End;
end;

procedure TPersonContactCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FMTBBackup := TMemTableFactory.Make;
end;

procedure TPersonContactCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
end;

procedure TPersonContactCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;
  BeforeShow;
end;

class function TPersonContactCreateUpdateView.Handle(AState: TEntityState; AMTB: IPersonMTB): Integer;
var
  lView: TPersonContactCreateUpdateView;
begin
  lView := TPersonContactCreateUpdateView.Create(nil);
  Try
    lView.FState := AState;
    lView.FMTB   := AMTB;

    Result := lView.ShowModal;
  Finally
    lView.Free;
  End;
end;

end.

