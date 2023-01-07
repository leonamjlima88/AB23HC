unit uProduct.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvExStdCtrls, JvCombobox,
  JvDBCombobox,

  uProduct.Service,
  uProduct.MTB,
  uApplication.Types;

type
  TProductCreateUpdateView = class(TBaseCreateUpdateView)
    dtsProduct: TDataSource;
    Label22: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label12: TLabel;
    Image1: TImage;
    Label37: TLabel;
    Label9: TLabel;
    Image2: TImage;
    Label10: TLabel;
    Image3: TImage;
    Label11: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label23: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label71: TLabel;
    Label34: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label13: TLabel;
    Panel5: TPanel;
    pnlFotoCapa: TPanel;
    Panel46: TPanel;
    Label83: TLabel;
    imgFotoCapa: TImage;
    btnIncluirFotoCapa: TImage;
    btnRemoverFotoCapa: TImage;
    edtName: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit10: TDBEdit;
    edtunit_name: TDBEdit;
    Panel41: TPanel;
    Panel42: TPanel;
    imgLocaUnit: TImage;
    edtunit_id: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit3: TDBEdit;
    JvDBComboBox1: TJvDBComboBox;
    DBCheckBox4: TDBCheckBox;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    Panel6: TPanel;
    edtbrand_name: TDBEdit;
    Panel37: TPanel;
    Panel38: TPanel;
    imgLocaBrand: TImage;
    edtbrand_id: TDBEdit;
    edtcategory_name: TDBEdit;
    Panel39: TPanel;
    Panel40: TPanel;
    imgLocaCategory: TImage;
    edtcategory_id: TDBEdit;
    edtstorage_location_name: TDBEdit;
    Panel43: TPanel;
    Panel44: TPanel;
    imgLocaStorageLocation: TImage;
    edtstorage_location_id: TDBEdit;
    edtsize_name: TDBEdit;
    Panel17: TPanel;
    Panel19: TPanel;
    imgLocaSize: TImage;
    edtsize_id: TDBEdit;
    Panel7: TPanel;
    Panel8: TPanel;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    Label18: TLabel;
    Label19: TLabel;
    edtncm_ncm: TDBEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    imgLocaNCM: TImage;
    edtncm_id: TDBEdit;
    edtncm_name: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure imgLocaUnitClick(Sender: TObject);
    procedure EdtFieldExit(Sender: TObject); override;
    procedure imgLocaNCMClick(Sender: TObject);
    procedure imgLocaCategoryClick(Sender: TObject);
    procedure imgLocaBrandClick(Sender: TObject);
    procedure imgLocaStorageLocationClick(Sender: TObject);
    procedure imgLocaSizeClick(Sender: TObject);
  private
    FService: IProductService;
    FMTB: IProductMTB;
    FHandleResult: IProductMTB;
    FState: TEntityState;
    FEditPK: Int64;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): IProductMTB;
  end;

const
  TITLE_NAME = 'Produto';

implementation

{$R *.dfm}

uses
  uNotificationView,
  Quick.Threads,
  Vcl.Dialogs,
  uHandle.Exception,
  uEither,
  uHlp,
  uAlert.View,
  uSession.DTM,
  uYesOrNo.View,
  uUnit.Index.View,
  uBrand.Index.View,
  uCategory.Index.View,
  uSize.Index.View,
  uNCM.Index.View,
  uStorageLocation.Index.View;

{ TProductCreateUpdateView }
procedure TProductCreateUpdateView.BeforeShow;
begin
  // Iniciar Loading
  LoadingForm           := True;
  pnlBackground.Enabled := False;
  pgc.Visible           := False;
  dtsProduct.DataSet    := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      case FState of
        esStore: Begin
          FMTB := TProductMTB.Make;
          FMTB.Product.DataSet.Append;
        end;
        esUpdate, esView: Begin
          FMTB := FService.Show(FEditPK);
          FMTB.Product.DataSet.Edit;
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
      Try
        // Carregar campos virtuais na inclusão
        if (FState = esStore) then
        begin
          FMTB.ProductSetUnit(FMTB.Product.DataSet.FieldByName('unit_id').AsInteger);
          FMTB.ProductSetNCM(FMTB.Product.DataSet.FieldByName('unit_id').AsInteger);
        end;
      finally
        // Encerrar Loading
        LoadingForm           := false;
        pnlBackground.Enabled := True;
        pgc.Visible           := True;
        dtsProduct.DataSet    := FMTB.Product.DataSet;
        if edtName.CanFocus then
          edtName.SetFocus;
      end;
    end)
  .Run;
end;

procedure TProductCreateUpdateView.btnCancelClick(Sender: TObject);
begin
  inherited;
  ModalResult := MrCancel;
end;

procedure TProductCreateUpdateView.btnSaveClick(Sender: TObject);
var
  lSaved: Either<String, IProductMTB>;
begin
  inherited;

  // Não prosseguir se estiver carregando
  btnFocus.SetFocus;
  if LoadingSave or LoadingForm then
    Exit;

  // Sempre salvar dataset para evitar erros
  if FMTB.Product.DataSet.State in [dsInsert, dsEdit] then
    FMTB.Product.DataSet.Post;

  // Iniciar Loading
  LoadingSave           := True;
  LoadingForm           := True;
  pgc.Visible           := False;
  pnlBackground.Enabled := False;
  dtsProduct.DataSet    := nil;

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
          FMTB.Product.DataSet.Edit;
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
        dtsProduct.DataSet      := FMTB.Product.DataSet;
      end;
    end)
  .Run;
end;

procedure TProductCreateUpdateView.EdtFieldExit(Sender: TObject);
begin
  inherited;

  // Unidade de Medida
  if (Sender = edtunit_id) then
  begin
    FMTB.ProductSetUnit(THlp.StrInt(edtunit_id.Text));
    Exit;
  end;

  // Category
  if (Sender = edtcategory_id) then
  begin
    FMTB.ProductSetCategory(THlp.StrInt(edtcategory_id.Text));
    Exit;
  end;

  // Marca
  if (Sender = edtbrand_id) then
  begin
    FMTB.ProductSetBrand(THlp.StrInt(edtbrand_id.Text));
    Exit;
  end;

  // Local de Armazenamento
  if (Sender = edtstorage_location_id) then
  begin
    FMTB.ProductSetStorageLocation(THlp.StrInt(edtstorage_location_id.Text));
    Exit;
  end;

  // Tamanho
  if (Sender = edtsize_id) then
  begin
    FMTB.ProductSetSize(THlp.StrInt(edtsize_id.Text));
    Exit;
  end;

  // NCM
  if (Sender = edtncm_id) then
  begin
    FMTB.ProductSetNCM(THlp.StrInt(edtncm_id.Text));
    Exit;
  end;
end;

procedure TProductCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TProductService.Make;
end;

procedure TProductCreateUpdateView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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

  // F1 - Localizar Unidade de Medida
  if (Key = VK_F1) and (edtunit_id.Focused or edtunit_name.Focused) then
  begin
    imgLocaUnitClick(imgLocaUnit);
    Exit;
  end;

  // F1 - Localizar Categoria
  if (Key = VK_F1) and (edtcategory_id.Focused or edtcategory_name.Focused) then
  begin
    imgLocaCategoryClick(imgLocaCategory);
    Exit;
  end;

  // F1 - Localizar Marca
  if (Key = VK_F1) and (edtbrand_id.Focused or edtbrand_name.Focused) then
  begin
    imgLocaBrandClick(imgLocaBrand);
    Exit;
  end;

  // F1 - Localizar Local de Armazenamento
  if (Key = VK_F1) and (edtstorage_location_id.Focused or edtstorage_location_name.Focused) then
  begin
    imgLocaStorageLocationClick(imgLocaStorageLocation);
    Exit;
  end;

  // F1 - Tamanho
  if (Key = VK_F1) and (edtsize_id.Focused or edtsize_name.Focused) then
  begin
    imgLocaSizeClick(imgLocaSize);
    Exit;
  end;

  // F1 - Localizar NCM
  if (Key = VK_F1) and (edtncm_id.Focused or edtncm_name.Focused or edtncm_ncm.Focused) then
  begin
    imgLocaNCMClick(imgLocaNCM);
    Exit;
  end;
end;

procedure TProductCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;

  BeforeShow;
end;

class function TProductCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): IProductMTB;
var
  lView: TProductCreateUpdateView;
begin
  Result       := nil;
  lView        := TProductCreateUpdateView.Create(nil);
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

procedure TProductCreateUpdateView.imgLocaBrandClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TBrandIndexView.HandleLocate;
  if (lPk > 0) then
  Begin
    dtsProduct.DataSet.FieldByName('brand_id').AsLargeInt := lPk;
    EdtFieldExit(edtbrand_id);
  end;
end;

procedure TProductCreateUpdateView.imgLocaCategoryClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TCategoryIndexView.HandleLocate;
  if (lPk > 0) then
  Begin
    dtsProduct.DataSet.FieldByName('category_id').AsLargeInt := lPk;
    EdtFieldExit(edtcategory_id);
  end;
end;

procedure TProductCreateUpdateView.imgLocaNCMClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TNCMIndexView.HandleLocate;
  if (lPk > 0) then
  Begin
    dtsProduct.DataSet.FieldByName('ncm_id').AsLargeInt := lPk;
    EdtFieldExit(edtncm_id);
  end;
end;

procedure TProductCreateUpdateView.imgLocaSizeClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TSizeIndexView.HandleLocate;
  if (lPk > 0) then
  Begin
    dtsProduct.DataSet.FieldByName('size_id').AsLargeInt := lPk;
    EdtFieldExit(edtsize_id);
  end;
end;

procedure TProductCreateUpdateView.imgLocaStorageLocationClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TStorageLocationIndexView.HandleLocate;
  if (lPk > 0) then
  Begin
    dtsProduct.DataSet.FieldByName('storage_location_id').AsLargeInt := lPk;
    EdtFieldExit(edtstorage_location_id);
  end;
end;

procedure TProductCreateUpdateView.imgLocaUnitClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TUnitIndexView.HandleLocate;
  if (lPk > 0) then
  Begin
    dtsProduct.DataSet.FieldByName('unit_id').AsLargeInt := lPk;
    EdtFieldExit(edtunit_id);
  end;
end;

procedure TProductCreateUpdateView.SetState(const Value: TEntityState);
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

