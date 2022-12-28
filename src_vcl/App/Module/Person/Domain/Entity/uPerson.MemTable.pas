unit uPerson.MemTable;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces;

type
  IPersonMemTable = Interface(IEntityMemTable)
    ['{C68743AE-A643-408E-8045-FCE6EB1C6205}']
    function Person: IZLMemTable;
    function PersonContactList: IZLMemTable;
    function Validate: String;
    function ValidateCurrentPersonContact: String;
    function FromJsonString(AJsonString: String): IPersonMemTable;
    function ToJsonString: String;
  end;

  TPersonMemTable = class(TInterfacedObject, IPersonMemTable)
  private
    FPerson: IZLMemTable;
    FPersonContactList: IZLMemTable;
  public
    constructor Create;
    class function Make: IPersonMemTable;

    function Person: IZLMemTable;
    function PersonContactList: IZLMemTable;
    function FromJsonString(AJsonString: String): IPersonMemTable;
    function ToJsonString: String;

    procedure Initialize;
    function  Validate: String;
    function  ValidateCurrentPersonContact: String;
  end;

implementation

{ TPersonMemTable }

uses
  uMemTable.Factory,
  Data.DB,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TPersonMemTable.Person: IZLMemTable;
begin
  Result := FPerson;
end;

function TPersonMemTable.PersonContactList: IZLMemTable;
begin
  Result := FPersonContactList;
end;

constructor TPersonMemTable.Create;
begin
  inherited Create;
  Initialize;
end;

function TPersonMemTable.FromJsonString(AJsonString: String): IPersonMemTable;
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

procedure TPersonMemTable.Initialize;
begin
  // Person
  FPerson := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 100)
    .AddField('alias_name',               ftString, 100)
    .AddField('is_customer',              ftSmallint)
    .AddField('created_at',               ftDateTime)
    .AddField('updated_at',               ftDateTime)
    .AddField('created_by_acl_user_id',   ftLargeint)
    .AddField('created_by_acl_user_name', ftString, 100)
    .AddField('updated_by_acl_user_id',   ftLargeint)
    .AddField('updated_by_acl_user_name', ftString, 100)
    .CreateDataSet
    .Active(True);

  // PersonContactList
  FPersonContactList := TMemTableFactory.Make
    .AddField('id',                  ftLargeint)
    .AddField('name',                ftString, 100)
    .AddField('legal_entity_number', ftString, 20)
    .AddField('type',                ftString, 100)
    .AddField('note',                ftString, 5000)
    .AddField('phone',               ftString, 40)
    .AddField('email',               ftString, 255)
    .CreateDataSet
    .Active(True);
end;

class function TPersonMemTable.Make: IPersonMemTable;
begin
  Result := Self.Create;
end;

function TPersonMemTable.ToJsonString: String;
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

function TPersonMemTable.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
  lCurrentError: String;
  lI: Integer;
  lBookMark: TBookMark;
begin
  // Person
  With FPerson.DataSet do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Razão/Nome] é obrigatório' + #13;

    if FieldByName('alias_name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Fantasia/Apelido] é obrigatório' + #13;
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

function TPersonMemTable.ValidateCurrentPersonContact: String;
var
  lErrors: String;
  lAtLeastOneFieldMustBeFilled: Boolean;
begin
  With FPersonContactList.DataSet do
  begin
    // Pelo menos um dos campos precisa estar preenchido
    lAtLeastOneFieldMustBeFilled := not (FieldByName('name').AsString.Trim.IsEmpty and
                                    FieldByName('phone').AsString.Trim.IsEmpty and
                                    FieldByName('email').AsString.Trim.IsEmpty);
    if not lAtLeastOneFieldMustBeFilled then
      lErrors := lErrors + 'O campo [Nome, Telefone ou E-mail] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
