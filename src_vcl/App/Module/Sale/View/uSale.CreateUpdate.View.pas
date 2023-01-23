unit uSale.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvExStdCtrls, JvEdit,
  JvValidateEdit, JvCombobox, JvDBCombobox, JvExMask, JvToolEdit, JvDBControls,

  uSale.Service,
  uSale.MTB,
  uApplication.Types;

type
  TSaleCreateUpdateView = class(TBaseCreateUpdateView)
    dtsSale: TDataSource;
    dtsSaleItemList: TDataSource;
    Label22: TLabel;
    Label37: TLabel;
    Label5: TLabel;
    Label10: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Panel5: TPanel;
    edtId: TDBEdit;
    edtperson_name: TDBEdit;
    Panel41: TPanel;
    Panel42: TPanel;
    imgLocaPerson: TImage;
    edtperson_id: TDBEdit;
    JvDBComboBox1: TJvDBComboBox;
    edtseller_name: TDBEdit;
    Panel4: TPanel;
    Panel1: TPanel;
    imgLocaSeller: TImage;
    edtseller_id: TDBEdit;
    pgcNote: TPageControl;
    TabSheet1: TTabSheet;
    Panel12: TPanel;
    DBMemo1: TDBMemo;
    TabSheet2: TTabSheet;
    Panel13: TPanel;
    DBMemo2: TDBMemo;
    Panel2: TPanel;
    Panel6: TPanel;
    dbgSaleItemList: TJvDBGrid;
    Panel9: TPanel;
    Label8: TLabel;
    Label15: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    imgsale_item_append: TImage;
    Panel10: TPanel;
    Panel11: TPanel;
    imgsale_item_loca_product: TImage;
    edtsale_item_id: TJvValidateEdit;
    edtsale_item_name: TEdit;
    edtsale_item_price: TJvValidateEdit;
    edtsale_item_quantity: TJvValidateEdit;
    edtsale_item_total: TJvValidateEdit;
    chkItemReadAndInsert: TCheckBox;
    Panel15: TPanel;
    Label6: TLabel;
    edtsum_sale_item_total: TDBEdit;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSaleItemListDeleteClick(Sender: TObject);
    procedure btnSaleItemListEditClick(Sender: TObject);
    procedure imgSaleItemAddClick(Sender: TObject);
    procedure dbgSaleItemListDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtFieldExit(Sender: TObject);
    procedure imgLocaSellerClick(Sender: TObject);
    procedure imgLocaPersonClick(Sender: TObject);
    procedure imgsale_item_loca_productClick(Sender: TObject);
    procedure imgsale_item_appendClick(Sender: TObject);
    procedure edtsale_item_totalKeyPress(Sender: TObject; var Key: Char);
    procedure dbgSaleItemListCellClick(Column: TColumn);
  private
    FService: ISaleService;
    FMTB: ISaleMTB;
    FHandleResult: ISaleMTB;
    FState: TEntityState;
    FEditPK: Int64;
    Fsale_item_selected_id: Int64;
    Fsale_item_selected_unit_name: String;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    procedure ClearSaleItemFields;
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): ISaleMTB;
  end;

const
  TITLE_NAME = 'Venda';

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
  uSaleItem.CreateUpdate.View,
  uHlp,
  uSearchLegalEntityNumber.Lib,
  uCity.Index.View,
  uSearchZipCode.Lib,
  uCity.MTB,
  uCity.Service,
  uPageFilter,
  uZLMemTable.Interfaces,
  uIndexResult,
  uPerson.Index.View,
  uPerson.TypeInput,
  uProduct.MTB,
  uProduct.Service,
  uProduct.Index.View;

{ TSaleCreateUpdateView }
procedure TSaleCreateUpdateView.BeforeShow;
begin
  // Iniciar Loading
  LoadingForm             := True;
  pnlBackground.Enabled   := False;
  pgc.Visible             := False;
  dtsSale.DataSet         := nil;
  dtsSaleItemList.DataSet := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore: Begin
          FMTB := TSaleMTB.Make;
          FMTB.Sale.DataSet.Append;
        end;
        esUpdate, esView: Begin
          FMTB := FService.Show(FEditPK);
          FMTB.Sale.DataSet.Edit;
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
      LoadingForm                := false;
      pnlBackground.Enabled      := True;
      pgc.Visible                := True;
      dtsSale.DataSet            := FMTB.Sale.DataSet;
      dtsSaleItemList.DataSet    := FMTB.SaleItemList.DataSet;
      dbgSaleItemList.DataSource := dtsSaleItemList;
      if edtseller_id.CanFocus then
        edtseller_id.SetFocus;
    end)
  .Run;
end;

procedure TSaleCreateUpdateView.btnSaleItemListDeleteClick;
begin
  // Mensagem de Sim/Não
  if not (TYesOrNoView.Handle(DO_YOU_WANT_TO_DELETE_SELECTED_RECORD, EXCLUSION) = mrOK) then
    Exit;

  Try
    pnlBackground.Enabled := False;

    dtsSaleItemList.DataSet.Delete;
    FMTB.SaleCalcTotals;
    NotificationView.Execute(RECORD_DELETED, tneError);
  Finally
    pnlBackground.Enabled := True;
  End;
end;

procedure TSaleCreateUpdateView.btnSaleItemListEditClick(Sender: TObject);
var
  lKeepGoing: Boolean;
begin
  lKeepGoing := Assigned(dtsSaleItemList.DataSet) and dtsSaleItemList.DataSet.Active and (dtsSaleItemList.DataSet.RecordCount > 0);
  if not lKeepGoing then
    Exit;

  Try
    pnlBackground.Enabled := False;

    // Incluir Novo Registro
    TSaleItemCreateUpdateView.Handle(esUpdate, FMTB);
    FMTB.SaleCalcTotals;
  Finally
    pnlBackground.Enabled := true;
  End;
end;

procedure TSaleCreateUpdateView.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := MrCancel;
end;

procedure TSaleCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lSaved: Either<String, ISaleMTB>;
begin
  inherited;

  // Não prosseguir se estiver carregando
  btnFocus.SetFocus;
  if LoadingSave or LoadingForm then
    Exit;

  // Sempre salvar dataset para evitar erros
  if FMTB.Sale.DataSet.State in [dsInsert, dsEdit] then
    FMTB.Sale.DataSet.Post;

  // Iniciar Loading
  LoadingSave                         := True;
  LoadingForm                         := True;
  pgc.Visible                         := False;
  pnlBackground.Enabled               := False;
  dtsSale.DataSet         := nil;
  dtsSaleItemList.DataSet := nil;

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
          FMTB.Sale.DataSet.Edit;
          NotificationView.Execute(RECORD_SAVE_FAILED, tneError);
          Exit;
        end;

        // Retornar registro inserido/atualizado
        NotificationView.Execute(RECORD_SAVED, tneSuccess);
        FHandleResult := lSaved.Right;
        ModalResult   := MrOK;
      finally
        // Encerrar Loading
        LoadingSave                         := False;
        LoadingForm                         := False;
        pgc.Visible                         := True;
        pnlBackground.Enabled               := True;
        dtsSale.DataSet         := FMTB.Sale.DataSet;
        dtsSaleItemList.DataSet := FMTB.SaleItemList.DataSet;
      end;
    end)
  .Run;
end;

procedure TSaleCreateUpdateView.ClearSaleItemFields;
begin
  edtsale_item_id.Clear;
  edtsale_item_name.Clear;
  edtsale_item_quantity.AsFloat := 0;
  edtsale_item_price.AsFloat    := 0;
  edtsale_item_total.AsFloat    := 0;
  Fsale_item_selected_id        := 0;
  Fsale_item_selected_unit_name := EmptyStr;
end;

procedure TSaleCreateUpdateView.dbgSaleItemListCellClick(Column: TColumn);
var
  lKeepGoing: Boolean;
begin
  inherited;
  lKeepGoing := Assigned(dtsSaleItemList.DataSet) and dtsSaleItemList.DataSet.Active and (dtsSaleItemList.DataSet.RecordCount > 0);
  if not lKeepGoing then
    Exit;

  // Editar
  if (AnsiLowerCase(Column.FieldName) = 'action_edit') then
    btnSaleItemListEditClick(dbgSaleItemList);

  // Deletar
  if (AnsiLowerCase(Column.FieldName) = 'action_delete') then
    btnSaleItemListDeleteClick(dbgSaleItemList);
end;

procedure TSaleCreateUpdateView.dbgSaleItemListDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
Var
  lI: Integer;
  lKeepGoing: Boolean;
begin
  inherited;
  lKeepGoing := Assigned(dtsSaleItemList.DataSet) and (dtsSaleItemList.DataSet.Active) and (dtsSaleItemList.DataSet.RecordCount > 0);
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
end;

procedure TSaleCreateUpdateView.edtsale_item_totalKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) then
    imgsale_item_appendClick(imgsale_item_append);
end;

procedure TSaleCreateUpdateView.edtFieldExit(Sender: TObject);
var
  lProductMTB: IProductMTB;
  lProductKey: String;
begin
  inherited;

  // Seller
  if (Sender = edtseller_id) then
  begin
    FMTB.SaleSetSeller(THlp.StrInt(edtseller_id.Text));
    Exit;
  end;

  // Person
  if (Sender = edtperson_id) then
  begin
    FMTB.SaleSetPerson(THlp.StrInt(edtperson_id.Text));
    Exit;
  end;

  // Product
  if (Sender = edtsale_item_id) then
  begin
    lProductKey := String(edtsale_item_id.Text).Trim;
    if lProductKey.IsEmpty then
    begin
      ClearSaleItemFields;
      Exit;
    end;

    // Localizar
    lProductMTB := TProductService.Make.ShowBySkuOrEanCode(lProductKey);
    if not Assigned(lProductMTB) then
    begin
      ClearSaleItemFields;
      Exit;
    end;

    // Carregar resultado
    edtsale_item_name.Text        := lProductMTB.Product.FieldByName('name').AsString;
    edtsale_item_quantity.AsFloat := 1;
    edtsale_item_price.AsFloat    := lProductMTB.Product.FieldByName('price').AsFloat;
    edtsale_item_total.AsFloat    := lProductMTB.Product.FieldByName('price').AsFloat;
    Fsale_item_selected_id        := lProductMTB.Product.FieldByName('id').AsLargeInt;
    Fsale_item_selected_unit_name := lProductMTB.Product.FieldByName('unit_name').AsString;

    // Lançar produto se marcado
    if chkItemReadAndInsert.Checked then
      imgsale_item_appendClick(imgsale_item_append);

    Exit;
  end;

  // Calcular Input de Produto
  if (Sender = edtsale_item_quantity) or (Sender = edtsale_item_price) then
  begin
    edtsale_item_total.AsFloat := edtsale_item_quantity.AsFloat * edtsale_item_price.AsFloat;
    Exit;
  end;
end;

procedure TSaleCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TSaleService.Make;
end;

procedure TSaleCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

  // F1 - Localizar Vendedor
  if (Key = VK_F1) and (edtseller_id.Focused or edtseller_name.Focused) then
  begin
    imgLocaSellerClick(imgLocaSeller);
    Exit;
  end;

  // F1 - Localizar Cliente
  if (Key = VK_F1) and (edtperson_id.Focused or edtperson_name.Focused) then
  begin
    imgLocaPersonClick(imgLocaPerson);
    Exit;
  end;

  // F2 - Localizar Produto
  if (Key = VK_F2) and (pgc.ActivePageIndex = 0) then
  begin
    imgsale_item_loca_productClick(imgsale_item_loca_product);
    Exit;
  end;
end;

procedure TSaleCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;

  BeforeShow;
end;

class function TSaleCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): ISaleMTB;
var
  lView: TSaleCreateUpdateView;
begin
  Result       := nil;
  lView        := TSaleCreateUpdateView.Create(nil);
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

procedure TSaleCreateUpdateView.imgSaleItemAddClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TSaleCreateUpdateView.imgsale_item_appendClick(Sender: TObject);
var
  lKeepGoing: Boolean;
begin
  inherited;
  lKeepGoing := (Fsale_item_selected_id > 0) and (String(edtsale_item_id.Text).Trim > EmptyStr) and (edtsale_item_quantity.AsFloat > 0);
  if not lKeepGoing then
  begin
    TAlertView.Handle(
      'Verifique se os campos foram preenchidos: ' + #13 +
      '  ID, Descrição e Quantidade'
    );
    Abort;
  end;

  Try
    pnlBackground.Enabled       := False;
    imgsale_item_append.Enabled := False;
    With dtsSaleItemList.DataSet do
    begin
      Append;
      FieldByName('product_id').AsLargeInt := Fsale_item_selected_id;
      FieldByName('note').AsString         := EmptyStr;
      FieldByName('quantity').AsFloat      := edtsale_item_quantity.AsFloat;
      FieldByName('price').AsFloat         := edtsale_item_price.AsFloat;
      FieldByName('unit_discount').AsFloat := 0;

      // Virtual
      FieldByName('product_name').AsString      := edtsale_item_name.Text;
      FieldByName('product_unit_name').AsString := Fsale_item_selected_unit_name;
      Post;
    end;
    FMTB.SaleCalcTotals;
  finally
    imgsale_item_append.Enabled := True;
    pnlBackground.Enabled       := True;
    ClearSaleItemFields;
    if edtsale_item_id.CanFocus then
      edtsale_item_id.SetFocus;
  end;
end;

procedure TSaleCreateUpdateView.imgsale_item_loca_productClick(Sender: TObject);
var
  lSkuCode: String;
begin
  lSkuCode := TProductIndexView.HandleLocate(True);
  if not lSkuCode.Trim.IsEmpty then
  Begin
    edtsale_item_id.Text := lSkuCode;
    if edtsale_item_name.CanFocus then
      edtsale_item_name.SetFocus;
    EdtFieldExit(edtsale_item_id);
  end;
end;

procedure TSaleCreateUpdateView.imgLocaPersonClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TPersonIndexView.HandleLocate(TPersonTypeInput.Make.is_customer(True));
  if (lPk > 0) then
  Begin
    dtsSale.DataSet.FieldByName('person_id').AsLargeInt := lPk;
    EdtFieldExit(edtperson_id);
  end;
end;

procedure TSaleCreateUpdateView.imgLocaSellerClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TPersonIndexView.HandleLocate(TPersonTypeInput.Make.is_seller(True));
  if (lPk > 0) then
  Begin
    dtsSale.DataSet.FieldByName('seller_id').AsLargeInt := lPk;
    EdtFieldExit(edtseller_id);
  end;
end;

procedure TSaleCreateUpdateView.SetState(const Value: TEntityState);
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

