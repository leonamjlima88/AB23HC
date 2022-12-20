unit uPerson.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uPerson,
  criteria.query.language,
  uPerson.SQLBuilder.Interfaces,
  uBase.Entity,
  cqlbr.interfaces;

type
  TPersonSQLBuilder = class(TInterfacedObject, IPersonSQLBuilder)
  private
    procedure LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const APerson: TPerson);
  public
    FDBName: TDBName;
    constructor Create;
    destructor Destroy; override;

    // Person
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectAll: String;
    function SelectById(AId: Int64; ATenantId: Int64 = 0): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function RegisteredEins(AEin: String; AId, ATenantId: Int64): String;
  end;

implementation

uses
  cqlbr.select.mysql,
  cqlbr.serialize.mysql,
  System.Classes,
  System.SysUtils,
  uConnection.Types,
  uApplication.Types,
  uHlp;

{ TPersonSQLBuilder }
function TPersonSQLBuilder.RegisteredEins(AEin: String; AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('person.ein')
    .From('person')
    .Where('person.ein').Equal(AEin)
    .&And('person.id').NotEqual(AId)
    .&And('person.tenant_id').Equal(ATenantId)
  .AsString;
end;

constructor TPersonSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TPersonSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
var
  lCQL: ICQL;
begin
  lCQL := TCQL.New(FDBName)
    .Delete
    .From('person')
    .Where('person.id = ' + AId.ToString);

  if (ATenantId > 0) then
    lCQL.&And('person.tenant_id = ' + ATenantId.ToString);

  Result := lCQL.AsString;
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
    .&Set('created_at',             lPerson.created_at)
    .&Set('created_by_acl_user_id', lPerson.created_by_acl_user_id)
    .&Set('tenant_id',              lPerson.tenant_id);

  // Carregar Campos Default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lPerson);

  // Retornar String SQL
  Result := lCQL.AsString;
end;

function TPersonSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

procedure TPersonSQLBuilder.LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const APerson: TPerson);
begin
  ACQL
    .&Set('name',                   APerson.name)
    .&Set('alias_name',             APerson.alias_name)
    .&Set('ein',                    APerson.ein.Value)
    .&Set('icms_taxpayer',          APerson.icms_taxpayer)
    .&Set('state_registration',     APerson.state_registration)
    .&Set('municipal_registration', APerson.municipal_registration)
    .&Set('zipcode',                APerson.zipcode)
    .&Set('address',                APerson.address)
    .&Set('address_number',         APerson.address_number)
    .&Set('complement',             APerson.complement)
    .&Set('district',               APerson.district)
    .&Set('reference_point',        APerson.reference_point)
    .&Set('phone_1',                APerson.phone_1)
    .&Set('phone_2',                APerson.phone_2)
    .&Set('phone_3',                APerson.phone_3)
    .&Set('company_email',          APerson.company_email)
    .&Set('financial_email',        APerson.financial_email)
    .&Set('internet_page',          APerson.internet_page)
    .&Set('note',                   APerson.note)
    .&Set('bank_note',              APerson.bank_note)
    .&Set('commercial_note',        APerson.commercial_note)
    .&Set('is_customer',            APerson.is_customer)
    .&Set('is_seller',              APerson.is_seller)
    .&Set('is_supplier',            APerson.is_supplier)
    .&Set('is_carrier',             APerson.is_carrier)
    .&Set('is_technician',          APerson.is_technician)
    .&Set('is_employee',            APerson.is_employee)
    .&Set('is_other',               APerson.is_other)
    .&Set('is_final_customer',      APerson.is_final_customer);

  // Tratar chaves estrangeiras
  if (APerson.city_id > 0) then ACQL.&Set('city_id', APerson.city_id);
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

function TPersonSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE person.id = ' + AId.ToString;
  if (ATenantId > 0) then
    Result := Result + ' AND person.tenant_id = ' + ATenantId.ToString;
end;

function TPersonSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lPerson: TPerson;
  lCQL: ICQL;
begin
  lPerson := AEntity as TPerson;
  lCQL := TCQL.New(FDBName)
    .Update('person')
    .&Set('updated_at',             lPerson.updated_at)
    .&Set('updated_by_acl_user_id', lPerson.updated_by_acl_user_id);

  // Carregar Campos Default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lPerson);

  Result := lCQL
    .Where('person.id = '       + AId.ToString)
    .&And('person.tenant_id = ' + lPerson.tenant_id.ToString)
  .AsString;
end;

end.
