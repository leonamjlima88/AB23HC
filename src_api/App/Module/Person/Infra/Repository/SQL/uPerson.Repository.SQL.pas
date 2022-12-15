unit uPerson.Repository.SQL;

interface

uses
  uBase.Repository,
  uPerson.Repository.Interfaces,
  uPerson.SQLBuilder.Interfaces,
  uConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uPerson,
  uPersonContact.SQLBuilder.Interfaces;

type
  TPersonRepositorySQL = class(TBaseRepository, IPersonRepository)
  private
    FPersonSQLBuilder: IPersonSQLBuilder;
    FPersonContactSQLBuilder: IPersonContactSQLBuilder;
    constructor Create(AConn: IConnection; ASQLBuilder: IPersonSQLBuilder);
    function DataSetToEntity(ADtsPerson: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    function LoadPersonContactsToShow(APerson: TPerson): IPersonRepository;
    function EinExists(AId: Int64; AEin: String): Boolean;
    procedure Validate(APerson: TPerson);
  public
    class function Make(AConn: IConnection; ASQLBuilder: IPersonSQLBuilder): IPersonRepository;
    function Show(AId: Int64): TPerson;
    function Store(APerson: TPerson; AManageTransaction: Boolean): Int64; overload;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize,
  uPersonContact,
  uQry.Interfaces,
  System.SysUtils,
  uQtdStr,
  uHlp,
  uApplication.Types,
  uSQLBuilder.Factory;

{ TPersonRepositorySQL }

class function TPersonRepositorySQL.Make(AConn: IConnection; ASQLBuilder: IPersonSQLBuilder): IPersonRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TPersonRepositorySQL.Create(AConn: IConnection; ASQLBuilder: IPersonSQLBuilder);
begin
  inherited Create;
  FConn                    := AConn;
  FSQLBuilder              := ASQLBuilder;
  FPersonSQLBuilder        := ASQLBuilder;
  FPersonContactSQLBuilder := TSQLBuilderFactory.Make(FConn.DriverDB).PersonContact;
end;

function TPersonRepositorySQL.DataSetToEntity(ADtsPerson: TDataSet): TBaseEntity;
var
  lPerson: TPerson;
begin
  lPerson := TPerson.FromJSON(ADtsPerson.ToJSONObjectString);

  // Person - Virtuais
  lPerson.ein                      := ADtsPerson.FieldByName('ein').AsString;
  lPerson.city.id                  := ADtsPerson.FieldByName('city_id').AsLargeInt;
  lPerson.city.name                := ADtsPerson.FieldByName('city_name').AsString;
  lPerson.city.state               := ADtsPerson.FieldByName('city_state').AsString;
  lPerson.city.ibge_code           := ADtsPerson.FieldByName('city_ibge_code').AsString;
  lPerson.created_by_acl_user.id   := ADtsPerson.FieldByName('created_by_acl_user_id').AsLargeInt;
  lPerson.created_by_acl_user.name := ADtsPerson.FieldByName('created_by_acl_user_name').AsString;
  lPerson.updated_by_acl_user.id   := ADtsPerson.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lPerson.updated_by_acl_user.name := ADtsPerson.FieldByName('updated_by_acl_user_name').AsString;

  Result := lPerson;
end;

function TPersonRepositorySQL.EinExists(AId: Int64; AEin: String): Boolean;
var
  lSQL: String;
begin
  lSQL := Format('select count(person.id) from person where person.ein = %s and person.id <> %s', [
    TQtdStr.Value(THlp.OnlyNumbers(AEin)),
    TQtdStr.Value(AId)
  ]);
  Result := FConn.MakeQry.Open(lSQL).DataSet.Fields[0].AsInteger > 0;
end;

function TPersonRepositorySQL.LoadPersonContactsToShow(APerson: TPerson): IPersonRepository;
var
  lPersonContact: TPersonContact;
begin
  Result := Self;
  With FConn.MakeQry.Open(FPersonContactSQLBuilder.SelectByPersonId(APerson.id)) do
  begin
    DataSet.First;
    while not DataSet.Eof do
    begin
      lPersonContact := TPersonContact.FromJSON(DataSet.ToJSONObjectString);
      APerson.person_contact_list.Add(lPersonContact);
      DataSet.Next;
    end;
  end;
end;

function TPersonRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FPersonSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TPersonRepositorySQL.Show(AId: Int64): TPerson;
var
  lPerson: TPerson;
begin
  Result := nil;

  // Person
  lPerson := ShowById(AId) as TPerson;

  // PersonContacts
  LoadPersonContactsToShow(lPerson);

  Result := lPerson;
end;

function TPersonRepositorySQL.Store(APerson: TPerson; AManageTransaction: Boolean): Int64;
var
  lPk: Int64;
  lPersonContact: TPersonContact;
  lQry: IQry;
begin
  // Validar antes de persistir
  Validate(APerson);

  // Instanciar Qry
  lQry := FConn.MakeQry;

  Try
    if AManageTransaction then
      FConn.StartTransaction;

    // Incluir Person
    lPk := inherited Store(APerson);

    // Incluir PersonContact
    for lPersonContact in APerson.person_contact_list do
    begin
      lPersonContact.person_id := lPk;
      lQry.ExecSQL(FPersonContactSQLBuilder.InsertInto(lPersonContact))
    end;

    if AManageTransaction then
      FConn.CommitTransaction;
  except on E: Exception do
    Begin
      if AManageTransaction then
        FConn.RollBackTransaction;
      raise;
    end;
  end;

  Result := lPk;
end;

procedure TPersonRepositorySQL.Validate(APerson: TPerson);
begin
  // Verificar se CPF/CNPJ já existe
  if (APerson.ein.Trim.IsEmpty = False) and EinExists(APerson.id, APerson.ein) then
    raise Exception.Create(Format(FIELD_WITH_VALUE_IS_IN_USE, ['person.ein', APerson.ein]));
end;

end.
