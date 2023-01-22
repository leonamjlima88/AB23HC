unit uProduct.Index.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBase.Index.View, Data.DB,
  Vcl.WinXCtrls, Vcl.StdCtrls, JvExStdCtrls, JvEdit, JvValidateEdit,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid, JvExControls,
  JvGradient, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Menus, JvMenus,

  Skia,
  Skia.Vcl,
  uIndexResult,
  uSearchColumns,
  uProduct.MTB,
  uApplication.Types;

type
  TProductIndexView = class(TBaseIndexView)
    tmrDoSearch: TTimer;
    pnlLocate: TPanel;
    imgLocateAppend: TImage;
    imgLocateEdit: TImage;
    lblLocateAppend: TLabel;
    lblLocateEdit: TLabel;
    pnlSave: TPanel;
    pnlSave2: TPanel;
    btnLocateConfirm: TSpeedButton;
    pnlSave3: TPanel;
    imgSave: TImage;
    pnlCancel: TPanel;
    pnlCancel2: TPanel;
    btnLocateClose: TSpeedButton;
    pnlCancel3: TPanel;
    imgCancel4: TImage;
    lblFilterIndex2: TLabel;
    lblFilterSearchType2: TLabel;
    cbxFilterIndex: TComboBox;
    cbxFilterSearchType: TComboBox;
    ppmOptions: TJvPopupMenu;
    mniRegistros1: TMenuItem;
    mniAppend: TMenuItem;
    mniEdit: TMenuItem;
    mniDelete: TMenuItem;
    mniView: TMenuItem;
    N1: TMenuItem;
    mniGrade1: TMenuItem;
    mniSaveGridConfig: TMenuItem;
    mniDeleteGridConfig: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure cbxFilterIndexSelect(Sender: TObject);
    procedure edtSearchValueChange(Sender: TObject);
    procedure tmrDoSearchTimer(Sender: TObject);
    procedure imgSearchClearClick(Sender: TObject);
    procedure edtSearchValueKeyPress(Sender: TObject; var Key: Char);
    procedure imgDoSearchClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnEditClick(Sender: TObject);
    procedure btnAppendClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
    procedure btnNavigationClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSplitViewApplyClick(Sender: TObject);
    procedure imgFilterCleanClick(Sender: TObject);
    procedure mniSaveGridConfigClick(Sender: TObject);
    procedure mniDeleteGridConfigClick(Sender: TObject);
    procedure btnLocateConfirmClick(Sender: TObject);
    procedure btnLocateCloseClick(Sender: TObject);
    procedure imgOptionsClick(Sender: TObject);
  private
    FIndexResult: IIndexResult;
    FFilterOrderBy: String;
    FSearchColumns: ISearchColumns;
    FLayoutLocate: Boolean;
    FLocateResult: String;
    FReturnSkuCode: Boolean;
    procedure CleanFilter;
    procedure DoSearch(ACurrentPage: Integer = 1; ATryLocateId: Int64 = 0);
    procedure RefreshIndexWithoutRequestAPI(AMemTable: IProductMTB; AEntityState: TEntityState);
    procedure SetLocateResult(const Value: String);
  public
    constructor Create(AOwner: TComponent; AReturnSkuCode: Boolean); overload;
    class function HandleLocate(AReturnSkuCode: Boolean = False): String;
    property  LocateResult: String read FLocateResult write SetLocateResult;
    procedure SetLayoutLocate(ABackgroundTransparent: Boolean = True);
  end;

var
  ProductIndexView: TProductIndexView;

implementation

uses
  uHlp,
  System.StrUtils,
  uProduct.CreateUpdate.View,
  uNotificationView,
  uSession.DTM,
  uYesOrNo.View,
  uProduct.Service,
  uAlert.View,
  uPageFilter,
  Quick.Threads,
  uHandle.Exception,
  DataSet.Serialize,
  uUserLogged;

{$R *.dfm}

procedure TProductIndexView.RefreshIndexWithoutRequestAPI(AMemTable: IProductMTB; AEntityState: TEntityState);
var
  lKeepGoing: Boolean;
begin
  // Evitar erros
  lKeepGoing := Assigned(dtsIndex.DataSet) and dtsIndex.DataSet.Active and (LoadingSearch = False);
  if not lKeepGoing then
    Exit;

  case AEntityState of
    esStore: Begin
      With dtsIndex.DataSet do
      begin
        Append;
        Post;
        MergeFromJSONObject(AMemTable.ToJsonString);
        Edit;
        FieldByName('updated_at').Clear;
        Post;
      end;
    end;
    esUpdate: dtsIndex.DataSet.MergeFromJSONObject(AMemTable.ToJsonString);
  end;
end;

procedure TProductIndexView.SetLayoutLocate(ABackgroundTransparent: Boolean);
const
  L_ACTIONS: TArray<String> = ['action_edit','action_delete','action_view','action_option'];
var
  lI: Integer;
begin
  FLayoutLocate      := true;
  pnlNavigator.Align := alNone;
  pnlLocate.Visible  := true;
  pnlLocate.Align    := alNone;
  pnlLocate.Align    := alBottom;
  pnlNavigator.Align := alBottom;

  lblTitle.Caption           := 'Pesquisando... Produtos';
  pnlAppend.Width            := 0;
  Self.BorderStyle           := bsNone;
  pnlBackground.BorderWidth  := 1;
  pnlBackground.Color        := $00857950;
  if ABackgroundTransparent then
    Thlp.createTransparentBackground(Self);

  // Varrer dbgrid e esconder botoes
  for lI := 0 to DBGrid1.Columns.Count-1 do
  begin
    if MatchStr(AnsiLowerCase(DBGrid1.Columns[lI].FieldName), L_ACTIONS) Then
      DBGrid1.Columns[lI].Visible := False;
  end;
end;

procedure TProductIndexView.SetLocateResult(const Value: String);
begin
  FLocateResult := Value;
end;

procedure TProductIndexView.btnAppendClick(Sender: TObject);
var
  lStored: IProductMTB;
begin
  inherited;

  if not pnlAppend.Enabled then Exit;
  Try
    pnlAppend.Enabled := False;
    DBGrid1.Enabled   := False;

    // Incluir Novo Registro
    lStored := TProductCreateUpdateView.Handle(TEntityState.esStore);
    if not Assigned(lStored) then
      Exit;

    // Atualizar Listagem
    RefreshIndexWithoutRequestAPI(lStored, esStore);
  Finally
    pnlAppend.Enabled := true;
    DBGrid1.Enabled := True;
    if edtSearchValue.CanFocus then
      edtSearchValue.SetFocus;
  End;
end;

procedure TProductIndexView.btnDeleteClick(Sender: TObject);
var
  lKeepGoing: Boolean;
begin
  // Evitar erros
  lKeepGoing := Assigned(dtsIndex.DataSet) and dtsIndex.DataSet.Active and (dtsIndex.DataSet.RecordCount > 0) and (LoadingSearch = False);
  if not lKeepGoing then
    Exit;

  // Mensagem de Sim/Não
  if not (TYesOrNoView.Handle(DO_YOU_WANT_TO_DELETE_SELECTED_RECORD, EXCLUSION) = mrOK) then
    Exit;

  Try
    pnlBackground.Enabled := False;
    if not TProductService.Make.Delete(dtsIndex.DataSet.Fields[0].AsLargeInt) then
    begin
      TAlertView.Handle(RECORD_DELETION_FAILED);
      Exit;
    end;

    dtsIndex.DataSet.Delete;
    NotificationView.Execute(RECORD_DELETED, tneError);
  Finally
    pnlBackground.Enabled := True;
    if edtSearchValue.CanFocus then edtSearchValue.SetFocus;
  End;
end;

procedure TProductIndexView.btnEditClick(Sender: TObject);
var
  lKeepGoing: Boolean;
  lUpdated: IProductMTB;
begin
  // Evitar erros
  lKeepGoing := Assigned(dtsIndex.DataSet) and dtsIndex.DataSet.Active and (dtsIndex.DataSet.RecordCount > 0) and (dtsIndex.DataSet.Fields[0].AsLargeInt > 0) and (LoadingSearch = False);
  if not lKeepGoing then
    Exit;

  Try
    pnlBackground.Enabled := False;

    // Editar Registro
    lUpdated := TProductCreateUpdateView.Handle(TEntityState.esUpdate, dtsIndex.DataSet.Fields[0].AsLargeInt);
    if not Assigned(lUpdated) then
      Exit;

    // Atualizar Listagem
    RefreshIndexWithoutRequestAPI(lUpdated, esUpdate);
  Finally
    pnlBackground.Enabled := True;
    if edtSearchValue.CanFocus then
      edtSearchValue.SetFocus;
  End;
end;

procedure TProductIndexView.btnLocateCloseClick(Sender: TObject);
begin
  inherited;
  FLocateResult := EmptyStr;
  ModalResult   := MrCancel;
end;

procedure TProductIndexView.btnLocateConfirmClick(Sender: TObject);
var
  lKeepGoing: Boolean;
begin
  inherited;
  lKeepGoing := FLayoutLocate and Assigned(dtsIndex.DataSet) and dtsIndex.DataSet.Active and (dtsIndex.DataSet.RecordCount > 0) and (LoadingSearch = False);
  if not lKeepGoing then
    Exit;

  case FReturnSkuCode of
    True:  FLocateResult := dtsIndex.DataSet.FieldByName('sku_code').AsString;
    False: FLocateResult := dtsIndex.DataSet.FieldByName('id').AsString;
  end;

  ModalResult   := mrOK;
end;

procedure TProductIndexView.btnNavigationClick(Sender: TObject);
begin
  inherited;

  // Primeira página
  if (Sender = btnNavFirst) then
  begin
    DoSearch;
    Exit;
  end;

  // Voltar página
  if (Sender = btnNavPrior) then
  begin
    DoSearch(edtNavCurrentPage.AsInteger-1);
    Exit;
  end;

  // Próxima Página
  if (Sender = btnNavNext) then
  begin
    DoSearch(edtNavCurrentPage.AsInteger+1);
    Exit;
  end;

  // Última página
  if (Sender = btnNavLast) then
  begin
    DoSearch(THlp.StrInt(edtNavLastPageNumber.Text));
    Exit;
  end;
end;

procedure TProductIndexView.btnSplitViewApplyClick(Sender: TObject);
begin
  inherited;
  SplitView1.Opened := False;
  DoSearch;
  if edtSearchValue.CanFocus then
    edtSearchValue.SetFocus;
end;

procedure TProductIndexView.btnViewClick(Sender: TObject);
var
  lKeepGoing: Boolean;
begin
  // Evitar erros
  lKeepGoing :=  Assigned(dtsIndex.DataSet) and dtsIndex.DataSet.Active and (dtsIndex.DataSet.RecordCount > 0) and (dtsIndex.DataSet.Fields[0].AsLargeInt > 0) and (LoadingSearch = False);
  if not lKeepGoing then
    Exit;

  // Visualizar Registro
  TProductCreateUpdateView.Handle(TEntityState.esView, dtsIndex.DataSet.Fields[0].AsLargeInt);
end;

procedure TProductIndexView.cbxFilterIndexSelect(Sender: TObject);
begin
  inherited;
  lblSearchTitle.Caption := 'F5 - Pesquise por: "' + cbxFilterIndex.Text + '"';
end;

procedure TProductIndexView.CleanFilter;
begin
  // Modo de Pesquisa
  cbxFilterSearchType.ItemIndex := THlp.StrInt(UserLogged.GetParam(GERAL_FILTER_SEARCH_TYPE), 1);
  if (cbxFilterSearchType.ItemIndex < 0) then
    cbxFilterSearchType.ItemIndex := 1;

  // Indexadores
  cbxFilterIndex.ItemIndex := 0;
  cbxFilterIndexSelect(cbxFilterIndex);

  // Ordenar por
  FFilterOrderBy := 'product.name';

  // Limite de Registros p/ Página
  edtNavLimitPerPage.Text := THlp.StrInt(UserLogged.GetParam(GERAL_LIMIT_PER_PAGE), 50).ToString;

  // Limpar Input de Pesquisa e Fazer Refresh
  edtSearchValue.OnChange := nil;
  edtSearchValue.Clear;
  edtSearchValue.OnChange := edtSearchValueChange;
end;

constructor TProductIndexView.Create(AOwner: TComponent; AReturnSkuCode: Boolean);
begin
  inherited Create(AOwner);
  FReturnSkuCode := AReturnSkuCode;
end;

procedure TProductIndexView.DBGrid1CellClick(Column: TColumn);
var
  lKeepGoing: Boolean;
begin
  inherited;
  lKeepGoing := Assigned(dtsIndex.DataSet) and dtsIndex.DataSet.Active and (dtsIndex.DataSet.RecordCount > 0) and (LoadingSearch = False);
  if not lKeepGoing then
    Exit;

  // Editar
  if (AnsiLowerCase(Column.FieldName) = 'action_edit') then
    btnEditClick(DBGrid1);

  // Deletar
  if (AnsiLowerCase(Column.FieldName) = 'action_delete') then
    btnDeleteClick(DBGrid1);

  // Visualizar
  if (AnsiLowerCase(Column.FieldName) = 'action_view') then
    btnViewClick(DBGrid1);
end;

procedure TProductIndexView.DBGrid1DblClick(Sender: TObject);
begin
  inherited;
  case FLayoutLocate of
    False: btnEditClick(DBGrid1);
    True:  btnLocateConfirmClick(Sender);
  end;
end;

procedure TProductIndexView.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
Var
  lI: Integer;
  lKeepGoing: Boolean;
begin
  inherited;
  lKeepGoing := Assigned(dtsIndex.DataSet) and (dtsIndex.DataSet.Active) and (dtsIndex.DataSet.RecordCount > 0) and (LoadingSearch = False);
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

procedure TProductIndexView.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  // Bloquear Ctrl + Del
  if (ssCtrl in Shift) and (Key = VK_DELETE) then
    Key := 0;

  // Focus em pesquisa
  If (Shift = [ssShift]) and (key = VK_TAB) then
  Begin
    if edtSearchValue.CanFocus then
      edtSearchValue.SetFocus;
    Key := 0;
  End;

  // Quando Enter Pressionado Editar
  if (Key = VK_RETURN) Then
  Begin
    case FLayoutLocate of
      False: btnEditClick(Sender);
      True:  btnLocateConfirmClick(Sender);
    end;
    Key := 0;
  End;
end;

procedure TProductIndexView.DBGrid1TitleClick(Column: TColumn);
const
  L_ACTIONS: TArray<String> = ['action_edit','action_delete','action_view','action_option'];
  L_DESC = ':D';
var
  lSelectedColumn: String;
  lLastIndex: String;
  lCurrentIndex: String;
  lReverseOrder: Boolean;
  lI: Integer;
begin
  Try
    DBGrid1.Enabled := False;

    // Coluna Selecionado
    lSelectedColumn := AnsiLowerCase(Column.FieldName).Trim;
    if lSelectedColumn.IsEmpty then Exit;
    if MatchStr(Column.FieldName, L_ACTIONS) Then
      Exit;

    // Ordenar por titulo do grid
    lLastIndex    := StringReplace(FIndexResult.Data.IndexFieldNames, L_DESC, '', [rfReplaceAll]);
    lReverseOrder := (lLastIndex = lSelectedColumn) and (Pos(L_DESC, FIndexResult.Data.IndexFieldNames) > 0);
    if (lLastIndex <> lSelectedColumn) then
      lCurrentIndex := lSelectedColumn
    else Begin
      if lLastIndex.IsEmpty then
        lCurrentIndex := lSelectedColumn + L_DESC
      else Begin
        case lReverseOrder of
          True:  lCurrentIndex := lSelectedColumn;
          False: lCurrentIndex := lSelectedColumn + L_DESC;
        end;
      end;
    end;
    FIndexResult.Data.IndexFieldNames(lCurrentIndex);


    // OrderBy e Indexador
    FFilterOrderBy := 'product.'+lSelectedColumn;

    // OrderBy e Indexador (Virtual)
    if (lSelectedColumn = 'created_by_acl_user_name') then FFilterOrderBy := 'created_by_acl_user.name';
    if (lSelectedColumn = 'updated_by_acl_user_name') then FFilterOrderBy := 'updated_by_acl_user.name';

    // Procurar indexador
    for lI := 0 to Pred(FSearchColumns.Columns.Count) do
    begin
      if AnsiLowerCase(FSearchColumns.Columns.Items[lI].FieldName.Trim) = AnsiLowerCase(FFilterOrderBy.Trim) then
      begin
        cbxFilterIndex.ItemIndex := lI+1;
        cbxFilterIndexSelect(cbxFilterIndex);
      end;
    end;

    // Pesquisar na api apenas se grade estiver vazia
    if FIndexResult.Data.DataSet.IsEmpty then
      DoSearch;
  finally
    DBGrid1.Enabled := True;
  end;
end;

procedure TProductIndexView.DoSearch(ACurrentPage: Integer; ATryLocateId: Int64);
var
  lCondOperator: TcondOperator;
  lPageFilter: IPageFilter;
  lI: Integer;
begin
  // Evitar erro
  if LoadingSearch then
    Exit;

  // Filtro de Pesquisa
  lPageFilter := TPageFilter.Make
    .CurrentPage  (ACurrentPage)
    .LimitPerPage (THlp.StrInt(edtNavLimitPerPage.Text))
    .OrderBy      (FFilterOrderBy);

  // Modo de Pesquisa
  case cbxFilterSearchType.ItemIndex of
    0: lCondOperator := TcondOperator.coLikeInitial;  // Pesquise no Início
    1: lCondOperator := TcondOperator.coLikeAnywhere; // Em Qualquer Parte
    2: lCondOperator := TcondOperator.coLikeFinal;    // Pesquise no Fim
  end;

  // Pesquisa Customizada
  if (cbxFilterIndex.ItemIndex = 0) then
  begin
    for lI := 0 to Pred(FSearchColumns.Columns.Count) do
    begin
      if FSearchColumns.Columns.Items[lI].CustomSearch then
        lPageFilter.AddOrWhere(
          FSearchColumns.Columns.Items[lI].FieldName,
          lCondOperator,
          String(edtSearchValue.Text).trim
        );
    end;
  end;

  // Pesquisa c/ Coluna Informada
  if (cbxFilterIndex.ItemIndex > 0) then
  begin
    // Adicionar Filtro
    lPageFilter.AddOrWhere(
        FSearchColumns.Columns.Items[Pred(cbxFilterIndex.ItemIndex)].FieldName,
        lCondOperator,
        String(edtSearchValue.Text).trim
    );
  end;

  // Iniciar Loading
  LoadingSearch           := True;
  pnlNavigator.Enabled    := False;
  edtSearchValue.OnChange := nil;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      // Adicionar ultima pesquisa como referência e pesquisar
      lPageFilter.LastIndexResult(FIndexResult);
      FIndexResult := TProductService.Make.Index(lPageFilter);
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
      // Resultado
      Try
        if not FIndexResult.ETagChanged then
          Exit;

        DBGrid1.DataSource        := dtsIndex;
        dtsIndex.DataSet          := FIndexResult.Data.DataSet;
        edtNavCurrentPage.Text    := FIndexResult.CurrentPage.ToString;
        edtNavLimitPerPage.Text   := FIndexResult.LimitPerPage.ToString;
        btnNavPrior.Enabled       := FIndexResult.NavPrior;
        btnNavNext.Enabled        := FIndexResult.NavNext;
        btnNavFirst.Enabled       := FIndexResult.NavFirst;
        btnNavLast.Enabled        := FIndexResult.NavLast;
        edtNavLastPageNumber.Text := FIndexResult.LastPageNumber.ToString;
        lblNavShowingRecords.Caption :=
          'Exibindo '     + FIndexResult.CurrentPageRecordCount.ToString +
          ' registro de ' + FIndexResult.AllPagesRecordCount.ToString + '.';

        if (ATryLocateId > 0) then
          dtsIndex.DataSet.Locate('id', VarArrayOf([ATryLocateId]), []);
      finally
        // Encerrar Loading
        pnlNavigator.Enabled    := True;
        edtSearchValue.OnChange := edtSearchValueChange;
        LoadingSearch           := False;
      end;
    end)
  .Run;
end;

procedure TProductIndexView.edtSearchValueChange(Sender: TObject);
begin
  inherited;
  if tmrDoSearch.Enabled then
    tmrDoSearch.Enabled := False;

  tmrDoSearch.Enabled := True;
end;

procedure TProductIndexView.edtSearchValueKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If (Key = #13) Then
  Begin
    if (tmrDoSearch.Enabled and (LoadingSearch = False)) then
    begin
      tmrDoSearch.Enabled := False;
      DoSearch;
    end;
    if DBGrid1.CanFocus then DBGrid1.SetFocus;
    DBGrid1.SelectedIndex := 3;
    Exit;
  End;
end;

procedure TProductIndexView.FormCreate(Sender: TObject);
begin
  inherited;

  // Colunas de Pesquisa da Tabela
  FSearchColumns := TSearchColumns.Make
    .AddColumn ('product.id',                 'ID', True)
    .AddColumn ('product.name',               'Nome', True)
    .AddColumn ('product.created_at',         'Criado em (Data)', False)
    .AddColumn ('product.updated_at',         'Atualizado em (Data)', False)
    .AddColumn ('created_by_acl_user.name',   'Criado por (Nome)', False)
    .AddColumn ('updated_by_acl_user.name',   'Atualizado por (Nome)', False)
    .LabelForCustomSearch ('ID ou Nome');

  // Colunas de Pesquisa da Tabela
  FSearchColumns.LoadStringsWithDisplayName(cbxFilterIndex.Items, True);

  // Carregar Config do Grid
  THlp.DBGridLoadConfig(DBGrid1, '');

  // Abrir pesquisa
  CleanFilter;
  DoSearch;
end;

procedure TProductIndexView.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  // INS - Novo Registro
  if (Key = VK_INSERT) then
  begin
    btnAppendClick(btnAppend);
    Exit;
  end;

  // F5 - Atualizar e setar focus em pesquisa
  if (Key = VK_F5) then
  begin
    DoSearch;
    if edtSearchValue.CanFocus then edtSearchValue.SelectAll;
    Exit;
  end;

  // Esc - Fechar Modal quando estiver pesquisando
  if (Key = VK_ESCAPE) and FLayoutLocate then
  begin
    btnLocateCloseClick(btnLocateClose);
    Exit;
  end;
end;

class function TProductIndexView.HandleLocate(AReturnSkuCode: Boolean): String;
var
  lView: TProductIndexView;
begin
  Try
    lView := TProductIndexView.Create(nil, AReturnSkuCode);
    lView.SetLayoutLocate;
    case (lView.ShowModal = mrOK) of
      True:  Result := lView.LocateResult;
      False: Result := EmptyStr;
    end;
  Finally
    if Assigned(lView) then
      FreeAndNil(lView);
  End;
end;

procedure TProductIndexView.imgDoSearchClick(Sender: TObject);
begin
  inherited;
  DoSearch;
end;

procedure TProductIndexView.imgFilterCleanClick(Sender: TObject);
begin
  inherited;
  CleanFilter;
end;

procedure TProductIndexView.imgOptionsClick(Sender: TObject);
begin
  inherited;
  ppmOptions.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TProductIndexView.imgSearchClearClick(Sender: TObject);
begin
  inherited;
  CleanFilter;
  DoSearch;
end;

procedure TProductIndexView.mniDeleteGridConfigClick(Sender: TObject);
begin
  inherited;
  // Excluir Grid
  THlp.dbgridDeleteConfig(DBGrid1, '');
  NotificationView.Execute('Feche e abra a janela para carregar a nova configuração.');
end;

procedure TProductIndexView.mniSaveGridConfigClick(Sender: TObject);
begin
  inherited;
  // Salvar Config do Grid
  THlp.dbgridSaveConfig(DBGrid1, '');
  NotificationView.Execute('Grade Salva');
end;

procedure TProductIndexView.tmrDoSearchTimer(Sender: TObject);
begin
  inherited;
  tmrDoSearch.Enabled := False;
  DoSearch;
end;

end.
