unit uPerson.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IPersonMTB = Interface(IEntityMemTable)
    ['{C68743AE-A643-408E-8045-FCE6EB1C6205}']
    // Person
    function  Person: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IPersonMTB;
    function  ToJsonString: String;
    function  CreatePersonIndexMemTable: IZLMemTable;
    procedure PersonSetCity(ACityId: Int64);

    // PersonContact
    function  PersonContactList: IZLMemTable;
    function  ValidateCurrentPersonContact: String;
  end;

  TPersonMTB = class(TInterfacedObject, IPersonMTB)
  private
    FPerson: IZLMemTable;
    FPersonContactList: IZLMemTable;

    // Person
    procedure PersonAfterInsert(DataSet: TDataSet);
    procedure PersonLegalEntityNumberGetText(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure PersonPhoneGetText(Sender: TField; var Text: string; DisplayText: Boolean);

    // PersonContactList
    procedure PersonContactListAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IPersonMTB;

    // Person
    function  Person: IZLMemTable;
    function  CreatePersonMemTable: IZLMemTable;
    function  CreatePersonIndexMemTable: IZLMemTable;
    procedure PersonSetCity(ACityId: Int64);

    // PersonContactList
    function  PersonContactList: IZLMemTable;
    function  CreatePersonContactListMemTable: IZLMemTable;
    function  FromJsonString(AJsonString: String): IPersonMTB;
    function  ToJsonString: String;

    procedure Initialize;
    function  Validate: String;
    function  ValidateCurrentPersonContact: String;
  end;

implementation

{ TPersonMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp,
  uCity.MTB,
  uCity.Service,
  Quick.Threads,
  Vcl.Dialogs,
  uApplication.Types,
  uHandle.Exception;

function TPersonMTB.Person: IZLMemTable;
begin
  Result := FPerson;
end;

procedure TPersonMTB.PersonAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
  DataSet.FieldByName('is_customer').AsInteger       := 1;
  DataSet.FieldByName('is_final_customer').AsInteger := 1;
end;

function TPersonMTB.PersonContactList: IZLMemTable;
begin
  Result := FPersonContactList;
end;

procedure TPersonMTB.PersonContactListAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
  DataSet.FieldByName('type').AsString := 'Celular';
end;

procedure TPersonMTB.PersonLegalEntityNumberGetText(Sender: TField; var Text: string; DisplayText: Boolean);
var
  lFormated: String;
begin
  lFormated := THlp.ValidateCpfCnpj(Sender.AsString);
  case lFormated.Trim.IsEmpty of
    True:  Text := Sender.AsString;
    False: Text := lFormated;
  end;
end;

procedure TPersonMTB.PersonSetCity(ACityId: Int64);
var
  lMTB: ICityMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (ACityId <= 0) then Exit;
      lMTB := TCityService.Make.Show(ACityId);
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
        lKeepGoing := FPerson.DataSet.Active and (FPerson.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          ACityId := 0;
          Exit;
        End;

        // Carregar resultado
        With FPerson do
        begin
          FieldByName('city_id').AsLargeInt      := lMTB.City.FieldByName('id').AsLargeInt;
          FieldByName('city_name').AsString      := lMTB.City.FieldByName('name').AsString;
          FieldByName('city_state').AsString     := lMTB.City.FieldByName('state').AsString;
          FieldByName('city_ibge_code').AsString := lMTB.City.FieldByName('ibge_code').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (ACityId <= 0) and (FPerson.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FPerson do
          begin
            FieldByName('city_id').Clear;
            FieldByName('city_name').Clear;
            FieldByName('city_state').Clear;
            FieldByName('city_ibge_code').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

procedure TPersonMTB.PersonPhoneGetText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := THlp.FormatPhone(Sender.AsString);
end;

constructor TPersonMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TPersonMTB.CreatePersonContactListMemTable: IZLMemTable;
begin
  // PersonContactList
  Result := TMemTableFactory.Make
    .AddField('id',                  ftLargeint)
    .AddField('name',                ftString, 100)
    .AddField('legal_entity_number', ftString, 20)
    .AddField('type',                ftString, 100)
    .AddField('note',                ftString, 5000)
    .AddField('phone',               ftString, 40)
    .AddField('email',               ftString, 255)
    .CreateDataSet
  .Active(True);

  // Formatar Dataset
  THlp.FormatDataSet(Result.DataSet);

  // Eventos
  With Result do
  begin
    DataSet.AfterInsert                          := PersonContactListAfterInsert;
    FieldByName('legal_entity_number').OnGetText := PersonLegalEntityNumberGetText;
    FieldByName('phone').OnGetText               := PersonPhoneGetText;
  end;
end;

function TPersonMTB.CreatePersonIndexMemTable: IZLMemTable;
begin
  Result := CreatePersonMemTable;
end;

function TPersonMTB.CreatePersonMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 100)
    .AddField('alias_name',               ftString, 100)
    .AddField('legal_entity_number',      ftString, 20)
    .AddField('icms_taxpayer',            ftSmallInt)
    .AddField('state_registration',       ftString, 20)
    .AddField('municipal_registration',   ftString, 20)
    .AddField('zipcode',                  ftString, 10)
    .AddField('address',                  ftString, 100)
    .AddField('address_number',           ftString, 15)
    .AddField('complement',               ftString, 100)
    .AddField('district',                 ftString, 100)
    .AddField('city_id',                  ftLargeint)
    .AddField('reference_point',          ftString, 100)
    .AddField('phone_1',                  ftString, 40)
    .AddField('phone_2',                  ftString, 40)
    .AddField('phone_3',                  ftString, 40)
    .AddField('company_email',            ftString, 100)
    .AddField('financial_email',          ftString, 100)
    .AddField('internet_page',            ftString, 255)
    .AddField('note',                     ftString, 1000)
    .AddField('bank_note',                ftString, 1000)
    .AddField('commercial_note',          ftString, 1000)
    .AddField('is_customer',              ftSmallInt)
    .AddField('is_seller',                ftSmallInt)
    .AddField('is_supplier',              ftSmallInt)
    .AddField('is_carrier',               ftSmallInt)
    .AddField('is_technician',            ftSmallInt)
    .AddField('is_employee',              ftSmallInt)
    .AddField('is_other',                 ftSmallInt)
    .AddField('is_final_customer',        ftSmallInt)
    .AddField('created_at',               ftDateTime)
    .AddField('updated_at',               ftDateTime)
    .AddField('city_name',                ftString, 100)
    .AddField('city_state',               ftString, 2)
    .AddField('city_ibge_code',           ftString, 30)
    .AddField('created_by_acl_user_id',   ftLargeint)
    .AddField('created_by_acl_user_name', ftString, 100)
    .AddField('updated_by_acl_user_id',   ftLargeint)
    .AddField('updated_by_acl_user_name', ftString, 100)
    .CreateDataSet
  .Active(True);

  // Formatar Dataset
  THlp.FormatDataSet(Result.DataSet);

  // Eventos
  With Result do
  begin
    DataSet.AfterInsert                          := PersonAfterInsert;
    FieldByName('legal_entity_number').OnGetText := PersonLegalEntityNumberGetText;
    FieldByName('phone_1').OnGetText             := PersonPhoneGetText;
    FieldByName('phone_2').OnGetText             := PersonPhoneGetText;
    FieldByName('phone_3').OnGetText             := PersonPhoneGetText;
  end;
end;

function TPersonMTB.FromJsonString(AJsonString: String): IPersonMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // Person
  FPerson.DataSet.LoadFromJSON(lSObj.AsJSON);

  // PersonContactList
  FPersonContactList.DataSet.LoadFromJSON(lSObj.A['person_contact_list'].AsJSON);
end;

procedure TPersonMTB.Initialize;
begin
  FPerson            := CreatePersonMemTable;
  FPersonContactList := CreatePersonContactListMemTable;
end;

class function TPersonMTB.Make: IPersonMTB;
begin
  Result := Self.Create;
end;

function TPersonMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // Person
  lSObj := SO(FPerson.DataSet.ToJSONObjectString);

  // PersonContactList
  lSObj.A['person_contact_list'] := SA(FPersonContactList.DataSet.ToJSONArrayString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TPersonMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
  lCurrentError: String;
  lI: Integer;
  lBookMark: TBookMark;
begin
  // Person
  With FPerson do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Razão/Nome] é obrigatório' + #13;

    // Validar CPF/CNPJ
    if not FieldByName('legal_entity_number').AsString.Trim.IsEmpty then
    begin
      if THlp.ValidateCpfCnpj(FieldByName('legal_entity_number').AsString).IsEmpty then
        lErrors := lErrors + 'O campo [CNPJ/CPF] é inválido' + #13;
    end;
  end;

  // PersonContact
  With FPersonContactList.DataSet do
  begin
    Try
      DisableControls;
      lBookMark := GetBookmark;
      lI := 0;
      First;
      while not Eof do
      begin
        Inc(lI);
        lCurrentError := '  ' + ValidateCurrentPersonContact;
        if not lCurrentError.Trim.IsEmpty then
          lErrors := lErrors + 'Em Pessoa > Contato > Posição: ' + THlp.strZero(lI.ToString,2) + ' > ' + #13 + lCurrentError + #13;

        Next;
        Application.ProcessMessages;
      end;
    finally
      GotoBookmark(lBookMark);
      EnableControls;
      FreeBookmark(lBookMark);
    end;
  end;

  Result := lErrors;
end;

function TPersonMTB.ValidateCurrentPersonContact: String;
var
  lErrors: String;
  lAtLeastOneFieldMustBeFilled: Boolean;
begin
  With FPersonContactList do
  begin
    // Pelo menos um dos campos precisa estar preenchido
    lAtLeastOneFieldMustBeFilled := not (FieldByName('name').AsString.Trim.IsEmpty and
                                    FieldByName('phone').AsString.Trim.IsEmpty and
                                    FieldByName('email').AsString.Trim.IsEmpty);
    if not lAtLeastOneFieldMustBeFilled then
      lErrors := lErrors + 'O campo [Nome, Telefone ou E-mail] é obrigatório' + #13;

    // Validar CPF/CNPJ
    if not FieldByName('legal_entity_number').AsString.Trim.IsEmpty then
    begin
      if THlp.ValidateCpfCnpj(FieldByName('legal_entity_number').AsString).IsEmpty then
        lErrors := lErrors + 'O campo [CNPJ/CPF] é inválido' + #13;
    end;
  end;

  Result := lErrors;
end;

end.
