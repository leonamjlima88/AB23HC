unit uPerson.Repository.SQL;

interface

uses
  uBase.Repository,
  uPerson.Repository.Interfaces,
  uPerson.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
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
    constructor Create(AConn: IZLConnection; ASQLBuilder: IPersonSQLBuilder);
    function DataSetToEntity(ADtsPerson: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    function LoadPersonContactsToShow(APerson: TPerson): IPersonRepository;
    function LegalEntityNumberExists(ALegalEntityNumber: String; AId, ATenantId: Int64): Boolean;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: IPersonSQLBuilder): IPersonRepository;
    function Show(AId, ATenantId: Int64): TPerson;
    function Store(APerson: TPerson; AManageTransaction: Boolean): Int64; overload;
    function Update(APerson: TPerson; AId: Int64; AManageTransaction: Boolean): Boolean; overload;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize,
  uPersonContact,
  uZLQry.Interfaces,
  System.SysUtils,
  uQtdStr,
  uHlp,
  uApplication.Types,
  uSQLBuilder.Factory,
  uLegalEntityNumber.VO;

{ TPersonRepositorySQL }

class function TPersonRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: IPersonSQLBuilder): IPersonRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TPersonRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: IPersonSQLBuilder);
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
  lPerson.legal_entity_number      := TLegalEntityNumberVO.Make(ADtsPerson.FieldByName('legal_entity_number').AsString);
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

function TPersonRepositorySQL.LegalEntityNumberExists(ALegalEntityNumber: String; AId, ATenantId: Int64): Boolean;
begin
  Result := not FConn.MakeQry.Open(
    FPersonSQLBuilder.RegisteredLegalEntityNumbers(THlp.OnlyNumbers(ALegalEntityNumber), AId, ATenantId)
  ).DataSet.IsEmpty;
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
      lPersonContact                     := TPersonContact.FromJSON(DataSet.ToJSONObjectString);
      lPersonContact.legal_entity_number := TLegalEntityNumberVO.Make(DataSet.FieldByName('legal_entity_number').AsString);

      APerson.person_contact_list.Add(lPersonContact);
      DataSet.Next;
    end;
  end;
end;

function TPersonRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FPersonSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TPersonRepositorySQL.Show(AId, ATenantId: Int64): TPerson;
var
  lPerson: TPerson;
begin
  Result := nil;

  // Person
  lPerson := ShowById(AId, ATenantId) as TPerson;
  if not Assigned(lPerson) then
    Exit;

  // PersonContacts
  LoadPersonContactsToShow(lPerson);

  Result := lPerson;
end;

function TPersonRepositorySQL.Store(APerson: TPerson; AManageTransaction: Boolean): Int64;
var
  lPk: Int64;
  lPersonContact: TPersonContact;
  lQry: IZLQry;
begin
  // Instanciar Qry
  lQry := FConn.MakeQry;

  Try
    if AManageTransaction then
      FConn.StartTransaction;

    // Incluir Person
    lPk := inherited Store(APerson);

    // Incluir PersonContacts
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

function TPersonRepositorySQL.Update(APerson: TPerson; AId: Int64; AManageTransaction: Boolean): Boolean;
var
  lPersonContact: TPersonContact;
  lQry: IZLQry;
begin
  // Instanciar Qry
  lQry := FConn.MakeQry;

  Try
    if AManageTransaction then
      FConn.StartTransaction;

    // Atualizar Person
    inherited Update(APerson, AId);

    // Atualizar PersonContacts
    lQry.ExecSQL(FPersonContactSQLBuilder.DeleteByPersonId(AId));
    for lPersonContact in APerson.person_contact_list do
    begin
      lPersonContact.person_id := AId;
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

  Result := True;
end;

procedure TPersonRepositorySQL.Validate(AEntity: TBaseEntity);
var
  lPerson: TPerson;
begin
  lPerson := AEntity as TPerson;

  // Verificar se CPF/CNPJ j� existe
  if not lPerson.legal_entity_number.Value.Trim.IsEmpty then
  begin
    if LegalEntityNumberExists(lPerson.legal_entity_number.Value, lPerson.id, lPerson.tenant_id) then
      raise Exception.Create(Format(FIELD_WITH_VALUE_IS_IN_USE, ['CPF/CNPJ', lPerson.legal_entity_number.Value]));
  end;
end;

end.
