unit uPerson.CreateUpdate.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Data.DB, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Controls, Vcl.Buttons, uBase.CreateUpdate.View,
  Skia, Skia.Vcl, Vcl.Grids, Vcl.DBGrids, JvExDBGrids, JvDBGrid,

  uPerson.Service,
  uPerson.MTB,
  uApplication.Types;

type
  TPersonCreateUpdateView = class(TBaseCreateUpdateView)
    dtsPerson: TDataSource;
    dtsPersonContactList: TDataSource;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label22: TLabel;
    Label35: TLabel;
    Label1: TLabel;
    Label15: TLabel;
    Label4: TLabel;
    Label16: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label2: TLabel;
    Label21: TLabel;
    Label7: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label8: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Panel5: TPanel;
    edtId: TDBEdit;
    chkis_seller: TDBCheckBox;
    chkis_supplier: TDBCheckBox;
    chkis_carrier: TDBCheckBox;
    chkis_technician: TDBCheckBox;
    chkis_employee: TDBCheckBox;
    chkis_other: TDBCheckBox;
    chkis_customer: TDBCheckBox;
    chkis_final_customer: TDBCheckBox;
    Panel1: TPanel;
    edtlegal_entity_number: TDBEdit;
    edtstate_registration: TDBEdit;
    edtmunicipal_registration: TDBEdit;
    Panel26: TPanel;
    Panel27: TPanel;
    imgLocaLegalNumberEntity: TImage;
    loadLegalEntityNumber: TActivityIndicator;
    rdgicms_taxpayer: TDBRadioGroup;
    edtname: TDBEdit;
    edtalias_name: TDBEdit;
    Panel2: TPanel;
    edtzipcode: TDBEdit;
    edtaddress: TDBEdit;
    Panel7: TPanel;
    Panel9: TPanel;
    imgLocaZipcode: TImage;
    edtaddress_number: TDBEdit;
    edtcomplement: TDBEdit;
    edtdistrict: TDBEdit;
    edtcity_id: TDBEdit;
    Panel10: TPanel;
    Panel12: TPanel;
    imgLocaCity: TImage;
    edtcity_name: TDBEdit;
    edtcity_state: TDBEdit;
    edtreference_point: TDBEdit;
    Panel3: TPanel;
    edtphone_1: TDBEdit;
    edtphone_2: TDBEdit;
    edtphone_3: TDBEdit;
    edtinternet_page: TDBEdit;
    edtcompany_email: TDBEdit;
    edtfinancial_email: TDBEdit;
    loadZipCode: TActivityIndicator;
    pnlContact: TPanel;
    dbgPersonContactList: TJvDBGrid;
    Panel29: TPanel;
    imgPersonContactListAdd: TImage;
    Panel16: TPanel;
    Panel20: TPanel;
    Label42: TLabel;
    Panel21: TPanel;
    Panel22: TPanel;
    memNote: TDBMemo;
    Panel17: TPanel;
    Label33: TLabel;
    Panel18: TPanel;
    Panel19: TPanel;
    membank_note: TDBMemo;
    Panel23: TPanel;
    Label34: TLabel;
    Panel24: TPanel;
    Panel25: TPanel;
    memcommercial_note: TDBMemo;
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
    procedure EdtFieldExit(Sender: TObject); override;
    procedure imgLocaLegalNumberEntityClick(Sender: TObject);
    procedure imgLocaCityClick(Sender: TObject);
    procedure imgLocaZipcodeClick(Sender: TObject);
    procedure imgPersonContactAddClick(Sender: TObject);
  private
    FService: IPersonService;
    FMTB: IPersonMTB;
    FHandleResult: IPersonMTB;
    FState: TEntityState;
    FEditPK: Int64;
    procedure BeforeShow;
    procedure SetState(const Value: TEntityState);
    property  State: TEntityState read FState write SetState;
    property  EditPk: Int64 read FEditPk write FEditPk;
  public
    class function Handle(AState: TEntityState; AEditPK: Int64 = 0): IPersonMTB;
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
  uPersonContact.CreateUpdate.View,
  uHlp,
  uSearchLegalEntityNumber.Lib,
  uCity.Index.View,
  uSearchZipCode.Lib, uCity.MTB, uCity.Service, uPageFilter,
  uZLMemTable.Interfaces, uIndexResult;

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
          FMTB := TPersonMTB.Make;
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
      if edtlegal_entity_number.CanFocus then
        edtlegal_entity_number.SetFocus;
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
  lSaved: Either<String, IPersonMTB>;
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
end;

procedure TPersonCreateUpdateView.EdtFieldExit(Sender: TObject);
begin
  inherited;

  // Cidade
  if (Sender = edtcity_id) then
  begin
    FMTB.PersonSetCity(THlp.StrInt(edtcity_id.Text));
    Exit;
  end;
end;

procedure TPersonCreateUpdateView.FormCreate(Sender: TObject);
begin
  inherited;
  FService := TPersonService.Make;

  loadLegalEntityNumber.Visible := False;
  loadZipCode.Visible           := False;
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

  // F1 - Localizar CPF/CNPJ
  if (Key = VK_F1) and (edtlegal_entity_number.Focused) then
  begin
    imgLocaLegalNumberEntityClick(imgLocaLegalNumberEntity);
    Exit;
  end;

  // F1 - Localizar Cep
  if (Key = VK_F1) and (edtzipcode.Focused) then
  begin
    imgLocaZipcodeClick(imgLocaZipcode);
    Exit;
  end;

  // F1 - Localizar Cidade
  if (Key = VK_F1) and (edtcity_id.Focused or edtcity_name.Focused or edtcity_state.Focused) then
  begin
    imgLocaCityClick(imgLocaCity);
    Exit;
  end;
end;

procedure TPersonCreateUpdateView.FormShow(Sender: TObject);
begin
  inherited;

  BeforeShow;
end;

class function TPersonCreateUpdateView.Handle(AState: TEntityState; AEditPK: Int64): IPersonMTB;
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

procedure TPersonCreateUpdateView.imgLocaCityClick(Sender: TObject);
var
  lPk: Integer;
begin
  lPk := TCityIndexView.HandleLocate;
  if (lPk > 0) then
  Begin
    dtsPerson.DataSet.FieldByName('city_id').AsLargeInt := lPk;
    EdtFieldExit(edtcity_id);
  end;
end;

procedure TPersonCreateUpdateView.imgLocaLegalNumberEntityClick(Sender: TObject);
var
  lLegalEntityNumber: String;
  lLib: ISearchLegalEntityNumberLib;
  lProcThreadCustomFinally: TProc;
begin
  if loadLegalEntityNumber.Animate then
    Exit;

  // Interromper se CNPJ inválido
  if edtstate_registration.CanFocus then
    edtstate_registration.SetFocus;
  lLegalEntityNumber := THlp.removeDots(dtsPerson.DataSet.FieldByName('legal_entity_number').AsString);
  if (Length(lLegalEntityNumber) <> 14) or (THlp.validateCpfCnpj(lLegalEntityNumber).Trim.IsEmpty) Then
  Begin
    NotificationView.Execute('CNPJ informado é inválido!', tneError);
    Exit;
  End;

  // Iniciar Loading
  loadLegalEntityNumber.Visible := True;
  loadLegalEntityNumber.Animate := True;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      lLib := TSearchLegalEntityNumberLib.Make(lLegalEntityNumber).Execute;
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
    var
      lKeepGoing: Boolean;
    begin
      Try
        // Exibir erro se ocorrer
        if not lLib.ResponseError.Trim.IsEmpty then
        begin
          NotificationView.Execute(lLib.ResponseError, tneError);
          Exit;
        end;

        // Evitar erros
        lKeepGoing := Assigned(dtsPerson.DataSet) and dtsPerson.DataSet.Active and (dtsPerson.DataSet.State in [dsInsert, dsEdit]);
        if not lKeepGoing then
          Exit;

        // Carregar Resultado
        With dtsPerson.DataSet do
        begin
          FieldByName('name').AsString           := lLib.ResponseData.Name;
          FieldByName('alias_name').AsString     := lLib.ResponseData.AliasName;
          FieldByName('phone_1').AsString        := lLib.ResponseData.Phone;
          FieldByName('company_email').AsString  := lLib.ResponseData.Email;
          FieldByName('address').AsString        := lLib.ResponseData.Address;
          FieldByName('address_number').AsString := lLib.ResponseData.AddressNumber;
          FieldByName('district').AsString       := lLib.ResponseData.District;
          FieldByName('zipcode').AsString        := lLib.ResponseData.ZipCode;
        end;

        // Localizar/cadastrar cidade pelo cep
        if (Length(lLib.ResponseData.ZipCode) = 8) then
          imgLocaZipcodeClick(imgLocaZipcode);
      finally
        // Encerrar Loading
        loadLegalEntityNumber.Visible := False;
        loadLegalEntityNumber.Animate := False;
      end;
    end)
  .Run;
end;

procedure TPersonCreateUpdateView.imgLocaZipcodeClick(Sender: TObject);
var
  lZipcode: String;
  lLib: ISearchZipCodeLib;
  lError: String;
  lStoreResult: Either<String, Int64>;
  lIndexResult: IIndexResult;
begin
  if loadZipCode.Animate then
    Exit;

  // Interromper se cep inválido
  if edtaddress.CanFocus then edtaddress.SetFocus;
  lZipcode := THlp.removeDots(dtsPerson.DataSet.FieldByName('zipcode').AsString);
  if (Length(lZipcode) <> 8) Then
  begin
    NotificationView.Execute('Cep deve conter 8 caracteres.', tneError);
    Exit;
  End;

  // Ativar Loading
  loadZipCode.Visible := True;
  loadZipCode.Animate := True;

  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    var
      lService: ICityService;
      lCity: ICityMTB;
      lResult: Either<String, ICityMTB>;
      lPageFilter: IPageFilter;
    begin
      // Localizar endereço por API
      lLib := TSearchZipcodeLib.Make(lZipcode).Execute;
      if not lLib.ResponseError.Trim.IsEmpty then
        raise Exception.Create(lLib.ResponseError);

      // Se não existir, cria
      lService     := TCityService.Make;
      lPageFilter  := TPageFilter.Make.AddWhere('city.ibge_code', coEqual, lLib.ResponseData.CityIbgeCode);
      lIndexResult := lService.Index(lPageFilter);
      if lIndexResult.Data.DataSet.IsEmpty then
      begin
        lCity := TCityMTB.Make;
        With lCity.City do
        begin
          Append;
          FieldByName('name').AsString              := lLib.ResponseData.City;
          FieldByName('state').AsString             := lLib.ResponseData.State;
          FieldByName('country').AsString           := lLib.ResponseData.Country;
          FieldByName('ibge_code').AsString         := lLib.ResponseData.CityIbgeCode;
          FieldByName('country_ibge_code').AsString := lLib.ResponseData.CountryIbgeCode;
          Post;
        end;
        lResult := lService.Store(lCity);
        if not lResult.Match then
          raise Exception.Create(lResult.Left);
        lIndexResult := lService.Index(lPageFilter);
      end;
    end)
  .OnException_Sync(
    procedure(ATask : ITask; AException : Exception)
    begin
      MessageDlg(
        OOPS_MESSAGE + #13 + #13 +
        AException.Message,
        mtWarning, [mbOK], 0
      );
    end)
  .OnTerminated_Sync(
    procedure(ATask: ITask)
    var
      lKeepGoing: Boolean;
      lTaskFailed: Boolean;
    begin
      Try
        // Task Falhou
        lTaskFailed := ATask.Failed or not Assigned(lIndexResult);
        if lTaskFailed then
          Exit;

        // Evitar erros
        lKeepGoing := assigned(dtsPerson.DataSet) and dtsPerson.DataSet.Active and (dtsPerson.DataSet.State in [dsInsert, dsEdit]);
        if not lKeepGoing then
          Exit;

        // Carregar resultado
        With dtsPerson.DataSet do
        begin
          FieldByName('address').AsString     := lLib.ResponseData.Address;
          FieldByName('district').AsString    := lLib.ResponseData.District;
          FieldByName('city_id').AsLargeInt   := lIndexResult.Data.FieldByName('id').AsLargeInt;
          FieldByName('city_name').AsString   := lIndexResult.Data.FieldByName('name').AsString;
          FieldByName('city_state').AsString  := lIndexResult.Data.FieldByName('state').AsString;
        end;
      finally
        loadZipCode.Visible := False;
        loadZipCode.Animate := False;
      end;
    end)
  .Run;
end;

procedure TPersonCreateUpdateView.imgPersonContactAddClick(Sender: TObject);
begin
  inherited;
  //
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

