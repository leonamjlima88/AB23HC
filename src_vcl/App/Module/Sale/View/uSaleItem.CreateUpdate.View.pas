unit uSaleItem.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl,

  uApplication.Types,
  uSale.MTB,
  uZLMemTable.Interfaces;

type
  TSaleItemCreateUpdateView = class(TBaseCreateUpdateView)
    dtsSaleItem: TDataSource;
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
    FMTB: ISaleMTB;
    FMTBBackup: IZLMemTable;
    FMTBBackupRecNumber: Integer;
    procedure BeforeShow;
  public
    class function Handle(AState: TEntityState; AMTB: ISaleMTB): Integer;
  end;

const
  TITLE_NAME = 'Venda > Item';

implementation

uses
  Vcl.Dialogs,
  uHandle.Exception,
  uAlert.View,
  uMemTable.Factory;

{$R *.dfm}

{ TSaleItemCreateUpdateView }

procedure TSaleItemCreateUpdateView.BeforeShow;
begin
  // Efetua uma cópia para restaurar se necessário
  dtsSaleItem.DataSet := FMTB.SaleItemList.DataSet;
  FMTBBackup.FromDataSet(dtsSaleItem.DataSet);
  FMTBBackupRecNumber := dtsSaleItem.DataSet.RecNo;

  // Iniciar Loading
  Try
    LoadingForm              := True;
    pnlBackground.Enabled    := False;
    pgc.Visible              := False;
    dtsSaleItem.DataSet := nil;

    case FState of
      esStore: Begin
        lblTitle.Caption := TITLE_NAME + ' (Incluindo...)';
        FMTB.SaleItemList.DataSet.Append;
      end;
      esUpdate, esView: Begin
        lblTitle.Caption := TITLE_NAME + ' (Editando...)';
        FMTB.SaleItemList.DataSet.Edit;
      end;
    end;
  finally
    // Encerrar Loading
    LoadingForm              := false;
    pnlBackground.Enabled    := True;
    pgc.Visible              := True;
    dtsSaleItem.DataSet := FMTB.SaleItemList.DataSet;
    if edtquantity.CanFocus then
      edtquantity.SetFocus;
  end;
end;

procedure TSaleItemCreateUpdateView.btnCancelClick(Sender: TObject);
var
  lI: Integer;
begin
  inherited;

  // Cancelar Operação
  case FState of
    esStore: Begin
      case dtsSaleItem.DataSet.State of
        dsInsert: dtsSaleItem.DataSet.Cancel;
        dsBrowse: dtsSaleItem.DataSet.Delete;
        dsEdit: Begin
          dtsSaleItem.DataSet.Cancel;
          dtsSaleItem.DataSet.Delete;
        end;
      end;
    end;
    esUpdate: Begin
      // Restaurar dados anteriores (Evita erros)
      FMTBBackup.DataSet.First;
      for lI := 2 to FMTBBackupRecNumber do
        FMTBBackup.DataSet.Next;
      dtsSaleItem.DataSet.Edit;
      for lI := 0 to Pred(dtsSaleItem.DataSet.Fields.Count) do
        dtsSaleItem.DataSet.Fields[lI].Value := FMTBBackup.DataSet.FieldByName(dtsSaleItem.DataSet.Fields[lI].FieldName).Value;
      dtsSaleItem.DataSet.Post;
    end;
  end;

  ModalResult := MrCancel;
end;

procedure TSaleItemCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lErrors: String;
begin
  btnFocus.SetFocus;
  Try
    // Ativar Loading
    LoadingSave := True;

    // Sempre salvar dataset para evitar erros
    if FMTB.SaleItemList.DataSet.State in [dsInsert, dsEdit] then
      FMTB.SaleItemList.DataSet.Post;

    // Validar dados
    lErrors := FMTB.ValidateCurrentSaleItem;
    if not lErrors.Trim.IsEmpty then
    begin
      TAlertView.Handle(lErrors);
      FMTB.SaleItemList.DataSet.Edit;
      Abort;
    end;

    ModalResult := mrOk;
  Finally
    LoadingSave := False;
  End;
end;

procedure TSaleItemCreateUpdateView.DBEdit5KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) then
    btnSaveClick(btnSave);
end;

procedure TSaleItemCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FMTBBackup := TMemTableFactory.Make;
end;

procedure TSaleItemCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

procedure TSaleItemCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;
  BeforeShow;
end;

class function TSaleItemCreateUpdateView.Handle(AState: TEntityState; AMTB: ISaleMTB): Integer;
var
  lView: TSaleItemCreateUpdateView;
begin
  lView := TSaleItemCreateUpdateView.Create(nil);
  Try
    lView.FState := AState;
    lView.FMTB   := AMTB;

    Result := lView.ShowModal;
  Finally
    lView.Free;
  End;
end;

end.

