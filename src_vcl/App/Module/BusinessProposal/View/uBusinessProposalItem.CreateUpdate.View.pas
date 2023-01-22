unit uBusinessProposalItem.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl,

  uApplication.Types,
  uBusinessProposal.MTB,
  uZLMemTable.Interfaces;

type
  TBusinessProposalItemCreateUpdateView = class(TBaseCreateUpdateView)
    dtsBusinessProposalItem: TDataSource;
    Label22: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel5: TPanel;
    edtproduct_name: TDBEdit;
    edtquantity: TDBEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit3: TDBEdit;
    Panel1: TPanel;
    memNote: TDBMemo;
    Panel2: TPanel;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBEdit5KeyPress(Sender: TObject; var Key: Char);
  private
    FState: TEntityState;
    FMTB: IBusinessProposalMTB;
    FMTBBackup: IZLMemTable;
    FMTBBackupRecNumber: Integer;
    procedure BeforeShow;
  public
    class function Handle(AState: TEntityState; AMTB: IBusinessProposalMTB): Integer;
  end;

const
  TITLE_NAME = 'Proposta > Item';

implementation

uses
  Vcl.Dialogs,
  uHandle.Exception,
  uAlert.View,
  uMemTable.Factory;

{$R *.dfm}

{ TBusinessProposalItemCreateUpdateView }

procedure TBusinessProposalItemCreateUpdateView.BeforeShow;
begin
  // Efetua uma cópia para restaurar se necessário
  dtsBusinessProposalItem.DataSet := FMTB.BusinessProposalItemList.DataSet;
  FMTBBackup.FromDataSet(dtsBusinessProposalItem.DataSet);
  FMTBBackupRecNumber := dtsBusinessProposalItem.DataSet.RecNo;

  // Iniciar Loading
  Try
    LoadingForm              := True;
    pnlBackground.Enabled    := False;
    pgc.Visible              := False;
    dtsBusinessProposalItem.DataSet := nil;

    case FState of
      esStore: Begin
        lblTitle.Caption := TITLE_NAME + ' (Incluindo...)';
        FMTB.BusinessProposalItemList.DataSet.Append;
      end;
      esUpdate, esView: Begin
        lblTitle.Caption := TITLE_NAME + ' (Editando...)';
        FMTB.BusinessProposalItemList.DataSet.Edit;
      end;
    end;
  finally
    // Encerrar Loading
    LoadingForm              := false;
    pnlBackground.Enabled    := True;
    pgc.Visible              := True;
    dtsBusinessProposalItem.DataSet := FMTB.BusinessProposalItemList.DataSet;
    if edtquantity.CanFocus then
      edtquantity.SetFocus;
  end;
end;

procedure TBusinessProposalItemCreateUpdateView.btnCancelClick(Sender: TObject);
var
  lI: Integer;
begin
  inherited;

  // Cancelar Operação
  case FState of
    esStore: Begin
      case dtsBusinessProposalItem.DataSet.State of
        dsInsert: dtsBusinessProposalItem.DataSet.Cancel;
        dsBrowse: dtsBusinessProposalItem.DataSet.Delete;
        dsEdit: Begin
          dtsBusinessProposalItem.DataSet.Cancel;
          dtsBusinessProposalItem.DataSet.Delete;
        end;
      end;
    end;
    esUpdate: Begin
      // Restaurar dados anteriores (Evita erros)
      FMTBBackup.DataSet.First;
      for lI := 2 to FMTBBackupRecNumber do
        FMTBBackup.DataSet.Next;
      dtsBusinessProposalItem.DataSet.Edit;
      for lI := 0 to Pred(dtsBusinessProposalItem.DataSet.Fields.Count) do
        dtsBusinessProposalItem.DataSet.Fields[lI].Value := FMTBBackup.DataSet.FieldByName(dtsBusinessProposalItem.DataSet.Fields[lI].FieldName).Value;
      dtsBusinessProposalItem.DataSet.Post;
    end;
  end;

  ModalResult := MrCancel;
end;

procedure TBusinessProposalItemCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lErrors: String;
begin
  btnFocus.SetFocus;
  Try
    // Ativar Loading
    LoadingSave := True;

    // Sempre salvar dataset para evitar erros
    if FMTB.BusinessProposalItemList.DataSet.State in [dsInsert, dsEdit] then
      FMTB.BusinessProposalItemList.DataSet.Post;

    // Validar dados
    lErrors := FMTB.ValidateCurrentBusinessProposalItem;
    if not lErrors.Trim.IsEmpty then
    begin
      TAlertView.Handle(lErrors);
      FMTB.BusinessProposalItemList.DataSet.Edit;
      Abort;
    end;

    ModalResult := mrOk;
  Finally
    LoadingSave := False;
  End;
end;

procedure TBusinessProposalItemCreateUpdateView.DBEdit5KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) then
    btnSaveClick(btnSave);
end;

procedure TBusinessProposalItemCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FMTBBackup := TMemTableFactory.Make;
end;

procedure TBusinessProposalItemCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TBusinessProposalItemCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;
  BeforeShow;
end;

class function TBusinessProposalItemCreateUpdateView.Handle(AState: TEntityState; AMTB: IBusinessProposalMTB): Integer;
var
  lView: TBusinessProposalItemCreateUpdateView;
begin
  lView := TBusinessProposalItemCreateUpdateView.Create(nil);
  Try
    lView.FState := AState;
    lView.FMTB   := AMTB;

    Result := lView.ShowModal;
  Finally
    lView.Free;
  End;
end;

end.

