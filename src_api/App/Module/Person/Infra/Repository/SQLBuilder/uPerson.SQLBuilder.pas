unit uPerson.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uPerson,
  criteria.query.language,
  uPerson.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TPersonSQLBuilder = class(TInterfacedObject, IPersonSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;
    destructor Destroy; override;

    // Person
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64): String;
    function SelectAll: String;
    function SelectById(AId: Int64): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;

    // PersonContact
    function PersonContactScriptCreateTable: String; virtual; abstract;
    function PersonContactSelectAll: String;
    function PersonContactDeleteByPersonId(APersonId: Int64): String;
    function PersonContactSelectByPersonId(APersonId: Int64): String;
    function PersonContactInsertInto(AEntity: TBaseEntity): String;
  end;

implementation

uses
  cqlbr.interfaces,
  cqlbr.select.mysql,
  cqlbr.serialize.mysql,
  System.Classes,
  System.SysUtils,
  uConnection.Types,
  uApplication.Types,
  uHlp,
  uPersonContact;

{ TPersonSQLBuilder }
constructor TPersonSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TPersonSQLBuilder.DeleteById(AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('person')
    .Where('person.id = ' + AId.ToString)
  .AsString;
end;

destructor TPersonSQLBuilder.Destroy;
begin
  inherited;
end;

function TPersonSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lPerson: TPerson;
  lCQL: ICQL;
begin
  lPerson := AEntity as TPerson;
  lCQL := TCQL.New(FDBName)
    .Insert
    .Into('person')
    .&Set('name',                   lPerson.name)
    .&Set('alias_name',             lPerson.alias_name)
    .&Set('ein',                    lPerson.ein)
    .&Set('icms_taxpayer',          lPerson.icms_taxpayer)
    .&Set('state_registration',     lPerson.state_registration)
    .&Set('municipal_registration', lPerson.municipal_registration)
    .&Set('zipcode',                lPerson.zipcode)
    .&Set('address',                lPerson.address)
    .&Set('address_number',         lPerson.address_number)
    .&Set('complement',             lPerson.complement)
    .&Set('district',               lPerson.district)
    .&Set('reference_point',        lPerson.reference_point)
    .&Set('phone_1',                lPerson.phone_1)
    .&Set('phone_2',                lPerson.phone_2)
    .&Set('phone_3',                lPerson.phone_3)
    .&Set('company_email',          lPerson.company_email)
    .&Set('financial_email',        lPerson.financial_email)
    .&Set('internet_page',          lPerson.internet_page)
    .&Set('note',                   lPerson.note)
    .&Set('bank_note',              lPerson.bank_note)
    .&Set('commercial_note',        lPerson.commercial_note)
    .&Set('is_customer',            lPerson.is_customer)
    .&Set('is_seller',              lPerson.is_seller)
    .&Set('is_supplier',            lPerson.is_supplier)
    .&Set('is_carrier',             lPerson.is_carrier)
    .&Set('is_technician',          lPerson.is_technician)
    .&Set('is_employee',            lPerson.is_employee)
    .&Set('is_other',               lPerson.is_other)
    .&Set('is_final_customer',      lPerson.is_final_customer)
    .&Set('created_at',             lPerson.created_at)
    .&Set('created_by_acl_user_id', lPerson.created_by_acl_user_id);

  // Tratar chaves estrangeiras
  if (lPerson.city_id > 0) then lCQL.&Set('city_id', lPerson.city_id);

  Result := lCQL.AsString;
end;

function TPersonSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TPersonSQLBuilder.PersonContactDeleteByPersonId(APersonId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('person_contact')
    .Where('person_contact.person_id = ' + APersonId.ToString)
  .AsString;
end;

function TPersonSQLBuilder.PersonContactInsertInto(AEntity: TBaseEntity): String;
var
  lPersonContact: TPersonContact;
begin
  lPersonContact := AEntity as TPersonContact;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('person_contact')
    .&Set('person_id', lPersonContact.person_id)
    .&Set('name',      lPersonContact.name)
    .&Set('ein',       lPersonContact.ein)
    .&Set('type',      lPersonContact.&type)
    .&Set('note',      lPersonContact.note)
    .&Set('phone',     lPersonContact.phone)
    .&Set('email',     lPersonContact.email)
  .AsString;
end;

function TPersonSQLBuilder.PersonContactSelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('person_contact.*')
    .From('person_contact')
  .AsString;
end;

function TPersonSQLBuilder.PersonContactSelectByPersonId(APersonId: Int64): String;
begin
  Result := PersonContactSelectAll + ' WHERE person_contact.person_id = ' + APersonId.ToString;
end;

function TPersonSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('person.*')
    .Column('city.name').&As('city_name')
    .Column('city.state').&As('city_state')
    .Column('city.ibge_code').&As('city_ibge_code')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('person')
    .LeftJoin('city')
         .&On('city.id = person.city_id')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = person.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = person.updated_by_acl_user_id')
  .AsString;
end;

function TPersonSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'person.id', ddMySql);
  end;
end;

function TPersonSQLBuilder.SelectById(AId: Int64): String;
begin
  Result := SelectAll + ' WHERE person.id = ' + AId.ToString;
end;

function TPersonSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lPerson: TPerson;
  lCQL: ICQL;
begin
  lPerson := AEntity as TPerson;
  lCQL := TCQL.New(FDBName)
    .Update('person')
    .&Set('name',                   lPerson.name)
    .&Set('alias_name',             lPerson.alias_name)
    .&Set('ein',                    lPerson.ein)
    .&Set('icms_taxpayer',          lPerson.icms_taxpayer)
    .&Set('state_registration',     lPerson.state_registration)
    .&Set('municipal_registration', lPerson.municipal_registration)
    .&Set('zipcode',                lPerson.zipcode)
    .&Set('address',                lPerson.address)
    .&Set('address_number',         lPerson.address_number)
    .&Set('complement',             lPerson.complement)
    .&Set('district',               lPerson.district)
    .&Set('reference_point',        lPerson.reference_point)
    .&Set('phone_1',                lPerson.phone_1)
    .&Set('phone_2',                lPerson.phone_2)
    .&Set('phone_3',                lPerson.phone_3)
    .&Set('company_email',          lPerson.company_email)
    .&Set('financial_email',        lPerson.financial_email)
    .&Set('internet_page',          lPerson.internet_page)
    .&Set('note',                   lPerson.note)
    .&Set('bank_note',              lPerson.bank_note)
    .&Set('commercial_note',        lPerson.commercial_note)
    .&Set('is_customer',            lPerson.is_customer)
    .&Set('is_seller',              lPerson.is_seller)
    .&Set('is_supplier',            lPerson.is_supplier)
    .&Set('is_carrier',             lPerson.is_carrier)
    .&Set('is_technician',          lPerson.is_technician)
    .&Set('is_employee',            lPerson.is_employee)
    .&Set('is_other',               lPerson.is_other)
    .&Set('is_final_customer',      lPerson.is_final_customer)
    .&Set('updated_at',             lPerson.updated_at)
    .&Set('updated_by_acl_user_id', lPerson.updated_by_acl_user_id)
    .Where('person.id = ' + AId.ToString);

  // Tratar chaves estrangeiras
  if lPerson.city_id > 0 then lCQL.&Set('city_id', lPerson.city_id);

  Result := lCQL.AsString;
end;

end.
