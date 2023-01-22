unit uBusinessProposal.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvExStdCtrls, JvEdit,
  JvValidateEdit, JvCombobox, JvDBCombobox, JvExMask, JvToolEdit, JvDBControls,

  uBusinessProposal.Service,
  uBusinessProposal.MTB,
  uApplication.Types;

type
  TBusinessProposalCreateUpdateView = class(TBaseCreateUpdateView)
    dtsBusinessProposal: TDataSource;
    dtsBusinessProposalItemList: TDataSource;
    Label22: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label37: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label10: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Panel5: TPanel;
    edtId: TDBEdit;
    JvDBDateEdit1: TJvDBDateEdit;
    edtperson_name: TDBEdit;
    Panel41: TPanel;
    Panel42: TPanel;
    imgLocaPerson: TImage;
    edtperson_id: TDBEdit;
    JvDBComboBox1: TJvDBComboBox;
    DBEdit1: TDBEdit;
    DBEdit4: TDBEdit;
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
    TabSheet3: TTabSheet;
    Panel14: TPanel;
    DBMemo3: TDBMemo;
    Panel2: TPanel;
    Panel6: TPanel;
    dbgBusinessProposalItemList: TJvDBGrid;
    Panel9: TPanel;
    Label8: TLabel;
    Label15: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    imgbusiness_proposal_item_append: TImage;
    Panel10: TPanel;
    Panel11: TPanel;
    imgbusiness_proposal_item_loca_product: TImage;
    edtbusiness_proposal_item_id: TJvValidateEdit;
    edtbusiness_proposal_item_name: TEdit;
    edtbusiness_proposal_item_price: TJvValidateEdit;
    edtbusiness_proposal_item_quantity: TJvValidateEdit;
    edtbusiness_proposal_item_total: TJvValidateEdit;
    chkItemReadAndInsert: TCheckBox;
    Panel15: TPanel;
    Label6: TLabel;
    edtsum_business_proposal_item_total: TDBEdit;
    Label9: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnBusinessProposalItemListDeleteClick(Sender: TObject);
    procedure btnBusinessProposalItemListEditClick(Sender: TObject);
    procedure imgBusinessProposalItemAddClick(Sender: TObject);
    procedure dbgBusinessProposalItemListDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtFieldExit(Sender: TObject);
    procedure imgLocaSellerClick(Sender: TObject);
    procedure imgLocaPersonClick(Sender: TObject);
    procedure imgbusiness_proposal_item_loca_productClick(Sender: TObject);
    procedure imgbusiness_proposal_item_appendClick(Sender: TObject);
    procedure edtbusiness_proposal_item_totalKeyPress(Sender: TObject; var Key: Char);
    procedure dbgBusinessProposalItemListCellClick(Column: TColumn);
  private
    FService: IBusinessProposalService;
    FMTB: IBusinessProposalMTB;
    FHandleResult: IBusinessProposalMTB;
    FState: TEntityState;
    FEditPK: Int64;
    Fbusiness_proposal_item_selected_id: Int64;
    Fbusiness_proposal_item_selected_unit_name: String;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    procedure ClearBusinessProposalItemFields;
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): IBusinessProposalMTB;
  end;

const
  TITLE_NAME = 'Proposta Comercial';

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
  uBusinessProposalItem.CreateUpdate.View,
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

{ TBusinessProposalCreateUpdateView }
procedure TBusinessProposalCreateUpdateView.BeforeShow;
begin
  // Iniciar Loading
  LoadingForm                         := True;
  pnlBackground.Enabled               := False;
  pgc.Visible                         := False;
  dtsBusinessProposal.DataSet         := nil;
  dtsBusinessProposalItemList.DataSet := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore: Begin
          FMTB := TBusinessProposalMTB.Make;
          FMTB.BusinessProposal.DataSet.Append;
        end;
        esUpdate, esView: Begin
          FMTB := FService.Show(FEditPK);
          FMTB.BusinessProposal.DataSet.Edit;
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
      LoadingForm                            := false;
      pnlBackground.Enabled                  := True;
      pgc.Visible                            := True;
      dtsBusinessProposal.DataSet            := FMTB.BusinessProposal.DataSet;
      dtsBusinessProposalItemList.DataSet    := FMTB.BusinessProposalItemList.DataSet;
      dbgBusinessProposalItemList.DataSource := dtsBusinessProposalItemList;
      if edtseller_id.CanFocus then
        edtseller_id.SetFocus;
    end)
  .Run;
end;

procedure TBusinessProposalCreateUpdateView.btnBusinessProposalItemListDeleteClick;
begin
  // Mensagem de Sim/Não
  if not (TYesOrNoView.Handle(DO_YOU_WANT_TO_DELETE_SELECTED_RECORD, EXCLUSION) = mrOK) then
    Exit;

  Try
    pnlBackground.Enabled := False;

    dtsBusinessProposalItemList.DataSet.Delete;
    FMTB.BusinessProposalCalcTotals;
    NotificationView.Execute(RECORD_DELETED, tneError);
  Finally
    pnlBackground.Enabled := True;
  End;
end;

procedure TBusinessProposalCreateUpdateView.btnBusinessProposalItemListEditClick(Sender: TObject);
var
  lKeepGoing: Boolean;
begin
  lKeepGoing := Assigned(dtsBusinessProposalItemList.DataSet) and dtsBusinessProposalItemList.DataSet.Active and (dtsBusinessProposalItemList.DataSet.RecordCount > 0);
  if not lKeepGoing then
    Exit;

  Try
    pnlBackground.Enabled := False;

    // Incluir Novo Registro
    TBusinessProposalItemCreateUpdateView.Handle(esUpdate, FMTB);
    FMTB.BusinessProposalCalcTotals;
  Finally
    pnlBackground.Enabled := true;
  End;
end;

procedure TBusinessProposalCreateUpdateView.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := MrCancel;
end;

procedure TBusinessProposalCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lSaved: Either<String, IBusinessProposalMTB>;
begin
  inherited;

  // Não prosseguir se estiver carregando
  btnFocus.SetFocus;
  if LoadingSave or LoadingForm then
    Exit;

  // Sempre salvar dataset para evitar erros
  if FMTB.BusinessProposal.DataSet.State in [dsInsert, dsEdit] then
    FMTB.BusinessProposal.DataSet.Post;

  // Iniciar Loading
  LoadingSave                         := True;
  LoadingForm                         := True;
  pgc.Visible                         := False;
  pnlBackground.Enabled               := False;
  dtsBusinessProposal.DataSet         := nil;
  dtsBusinessProposalItemList.DataSet := nil;

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
          FMTB.BusinessProposal.DataSet.Edit;
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
        dtsBusinessProposal.DataSet         := FMTB.BusinessProposal.DataSet;
        dtsBusinessProposalItemList.DataSet := FMTB.BusinessProposalItemList.DataSet;
      end;
    end)
  .Run;
end;

procedure TBusinessProposalCreateUpdateView.ClearBusinessProposalItemFields;
begin
  edtbusiness_proposal_item_id.Clear;
  edtbusiness_proposal_item_name.Clear;
  edtbusiness_proposal_item_quantity.AsFloat := 0;
  edtbusiness_proposal_item_price.AsFloat    := 0;
  edtbusiness_proposal_item_total.AsFloat    := 0;
  Fbusiness_proposal_item_selected_id        := 0;
  Fbusiness_proposal_item_selected_unit_name := EmptyStr;
end;

procedure TBusinessProposalCreateUpdateView.dbgBusinessProposalItemListCellClick(Column: TColumn);
var
  lKeepGoing: Boolean;
begin
  inherited;
  lKeepGoing := Assigned(dtsBusinessProposalItemList.DataSet) and dtsBusinessProposalItemList.DataSet.Active and (dtsBusinessProposalItemList.DataSet.RecordCount > 0);
  if not lKeepGoing then
    Exit;

  // Editar
  if (AnsiLowerCase(Column.FieldName) = 'action_edit') then
    btnBusinessProposalItemListEditClick(dbgBusinessProposalItemList);

  // Deletar
  if (AnsiLowerCase(Column.FieldName) = 'action_delete') then
    btnBusinessProposalItemListDeleteClick(dbgBusinessProposalItemList);
end;

procedure TBusinessProposalCreateUpdateView.dbgBusinessProposalItemListDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;  State: TGridDrawState);
Var
  lI: Integer;
  lKeepGoing: Boolean;
begin
  inherited;
  lKeepGoing := Assigned(dtsBusinessProposalItemList.DataSet) and (dtsBusinessProposalItemList.DataSet.Active) and (dtsBusinessProposalItemList.DataSet.RecordCount > 0);
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

procedure TBusinessProposalCreateUpdateView.edtbusiness_proposal_item_totalKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (Key = #13) then
    imgbusiness_proposal_item_appendClick(imgbusiness_proposal_item_append);
end;

procedure TBusinessProposalCreateUpdateView.edtFieldExit(Sender: TObject);
var
  lProductMTB: IProductMTB;
  lProductKey: String;
begin
  inherited;

  // Seller
  if (Sender = edtseller_id) then
  begin
    FMTB.BusinessProposalSetSeller(THlp.StrInt(edtseller_id.Text));
    Exit;
  end;

  // Person
  if (Sender = edtperson_id) then
  begin
    FMTB.BusinessProposalSetPerson(THlp.StrInt(edtperson_id.Text));
    Exit;
  end;

  // Product
  if (Sender = edtbusiness_proposal_item_id) then
  begin
    lProductKey := String(edtbusiness_proposal_item_id.Text).Trim;
    if lProductKey.IsEmpty then
    begin
      ClearBusinessProposalItemFields;
      Exit;
    end;

    // Localizar
    lProductMTB := TProductService.Make.ShowBySkuOrEanCode(lProductKey);
    if not Assigned(lProductMTB) then
    begin
      ClearBusinessProposalItemFields;
      Exit;
    end;

    // Carregar resultado
    edtbusiness_proposal_item_name.Text        := lProductMTB.Product.FieldByName('name').AsString;
    edtbusiness_proposal_item_quantity.AsFloat := 1;
    edtbusiness_proposal_item_price.AsFloat    := lProductMTB.Product.FieldByName('price').AsFloat;
    edtbusiness_proposal_item_total.AsFloat    := lProductMTB.Product.FieldByName('price').AsFloat;
    Fbusiness_proposal_item_selected_id        := lProductMTB.Product.FieldByName('id').AsLargeInt;
    Fbusiness_proposal_item_selected_unit_name := lProductMTB.Product.FieldByName('unit_name').AsString;

    // Lançar produto se marcado
    if chkItemReadAndInsert.Checked then
      imgbusiness_proposal_item_appendClick(imgbusiness_proposal_item_append);

    Exit;
  end;

  // Calcular Input de Produto
  if (Sender = edtbusiness_proposal_item_quantity) or (Sender = edtbusiness_proposal_item_price) then
  begin
    edtbusiness_proposal_item_total.AsFloat := edtbusiness_proposal_item_quantity.AsFloat * edtbusiness_proposal_item_price.AsFloat;
    Exit;
  end;
end;

procedure TBusinessProposalCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TBusinessProposalService.Make;
end;

procedure TBusinessProposalCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    imgbusiness_proposal_item_loca_productClick(imgbusiness_proposal_item_loca_product);
    Exit;
  end;
end;

procedure TBusinessProposalCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;

  BeforeShow;
end;

class function TBusinessProposalCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): IBusinessProposalMTB;
var
  lView: TBusinessProposalCreateUpdateView;
begin
  Result       := nil;
  lView        := TBusinessProposalCreateUpdateView.Create(nil);
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

procedure TBusinessProposalCreateUpdateView.imgBusinessProposalItemAddClick(Sender: TObject);
begin
  inherited;
  //
end;

procedure TBusinessProposalCreateUpdateView.imgbusiness_proposal_item_appendClick(Sender: TObject);
var
  lKeepGoing: Boolean;
begin
  inherited;
  lKeepGoing := (Fbusiness_proposal_item_selected_id > 0) and (String(edtbusiness_proposal_item_id.Text).Trim > EmptyStr) and (edtbusiness_proposal_item_quantity.AsFloat > 0);
  if not lKeepGoing then
  begin
    TAlertView.Handle(
      'Verifique se os campos foram preenchidos: ' + #13 +
      '  ID, Descrição e Quantidade'
    );
    Abort;
  end;

  Try
    pnlBackground.Enabled := False;
    imgbusiness_proposal_item_append.Enabled := False;
    With dtsBusinessProposalItemList.DataSet do
    begin
      Append;
      FieldByName('product_id').AsLargeInt := Fbusiness_proposal_item_selected_id;
      FieldByName('note').AsString         := EmptyStr;
      FieldByName('quantity').AsFloat      := edtbusiness_proposal_item_quantity.AsFloat;
      FieldByName('price').AsFloat         := edtbusiness_proposal_item_price.AsFloat;
      FieldByName('unit_discount').AsFloat := 0;

      // Virtual
      FieldByName('product_name').AsString      := edtbusiness_proposal_item_name.Text;
      FieldByName('product_unit_name').AsString := Fbusiness_proposal_item_selected_unit_name;
      Post;
    end;
    FMTB.BusinessProposalCalcTotals;
  finally
    imgbusiness_proposal_item_append.Enabled := True;
    pnlBackground.Enabled                    := True;
    ClearBusinessProposalItemFields;
    if edtbusiness_proposal_item_id.CanFocus then
      edtbusiness_proposal_item_id.SetFocus;
  end;
end;

procedure TBusinessProposalCreateUpdateView.imgbusiness_proposal_item_loca_productClick(Sender: TObject);
var
  lSkuCode: String;
begin
  lSkuCode := TProductIndexView.HandleLocate(True);
  if not lSkuCode.Trim.IsEmpty then
  Begin
    edtbusiness_proposal_item_id.Text := lSkuCode;
    if edtbusiness_proposal_item_name.CanFocus then
      edtbusiness_proposal_item_name.SetFocus;
    EdtFieldExit(edtbusiness_proposal_item_id);
  end;
end;

procedure TBusinessProposalCreateUpdateView.imgLocaPersonClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TPersonIndexView.HandleLocate(TPersonTypeInput.Make.is_customer(True));
  if (lPk > 0) then
  Begin
    dtsBusinessProposal.DataSet.FieldByName('person_id').AsLargeInt := lPk;
    EdtFieldExit(edtperson_id);
  end;
end;

procedure TBusinessProposalCreateUpdateView.imgLocaSellerClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TPersonIndexView.HandleLocate(TPersonTypeInput.Make.is_seller(True));
  if (lPk > 0) then
  Begin
    dtsBusinessProposal.DataSet.FieldByName('seller_id').AsLargeInt := lPk;
    EdtFieldExit(edtseller_id);
  end;
end;

procedure TBusinessProposalCreateUpdateView.SetState(const Value: TEntityState);
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

