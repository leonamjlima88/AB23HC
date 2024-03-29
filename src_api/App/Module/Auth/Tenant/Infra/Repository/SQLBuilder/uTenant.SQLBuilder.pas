unit uTenant.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uTenant,
  criteria.query.language,
  uTenant.SQLBuilder.Interfaces,
  uBase.Entity,
  cqlbr.interfaces;

type
  TTenantSQLBuilder = class(TInterfacedObject, ITenantSQLBuilder)
  private
    procedure LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ATenant: TTenant);
  public
    FDBName: TDBName;
    constructor Create;
    destructor Destroy; override;

    // Tenant
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectAll: String;
    function SelectById(AId: Int64; ATenantId: Int64 = 0): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function RegisteredLegalEntityNumbers(ALegalEntityNumber: String; AId: Int64): String;
  end;

implementation

uses
  cqlbr.select.mysql,
  cqlbr.serialize.mysql,
  System.Classes,
  System.SysUtils,
  uZLConnection.Types,
  uApplication.Types,
  uHlp;

{ TTenantSQLBuilder }
function TTenantSQLBuilder.RegisteredLegalEntityNumbers(ALegalEntityNumber: String; AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('tenant.legal_entity_number')
    .From('tenant')
    .Where('tenant.legal_entity_number').Equal(ALegalEntityNumber)
    .&And('tenant.id').NotEqual(AId)
  .AsString;
end;

constructor TTenantSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TTenantSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('tenant')
    .Where('tenant.id = ' + AId.ToString)
  .AsString;
end;

destructor TTenantSQLBuilder.Destroy;
begin
  inherited;
end;

function TTenantSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lTenant: TTenant;
  lCQL: ICQL;
begin
  lTenant := AEntity as TTenant;
  lCQL := TCQL.New(FDBName)
    .Insert
    .Into('tenant')
    .&Set('created_at', lTenant.created_at);

  // Carregar Campos Default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lTenant);

  // Retornar String SQL
  Result := lCQL.AsString;
end;

function TTenantSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

procedure TTenantSQLBuilder.LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ATenant: TTenant);
begin
  ACQL
    .&Set('name',                   ATenant.name)
    .&Set('alias_name',             ATenant.alias_name)
    .&Set('legal_entity_number',    ATenant.legal_entity_number.Value)
    .&Set('icms_taxpayer',          ATenant.icms_taxpayer)
    .&Set('state_registration',     ATenant.state_registration)
    .&Set('municipal_registration', ATenant.municipal_registration)
    .&Set('zipcode',                ATenant.zipcode)
    .&Set('address',                ATenant.address)
    .&Set('address_number',         ATenant.address_number)
    .&Set('complement',             ATenant.complement)
    .&Set('district',               ATenant.district)
    .&Set('reference_point',        ATenant.reference_point)
    .&Set('phone_1',                ATenant.phone_1)
    .&Set('phone_2',                ATenant.phone_2)
    .&Set('phone_3',                ATenant.phone_3)
    .&Set('company_email',          ATenant.company_email)
    .&Set('financial_email',        ATenant.financial_email)
    .&Set('internet_page',          ATenant.internet_page)
    .&Set('note',                   ATenant.note)
    .&Set('bank_note',              ATenant.bank_note)
    .&Set('commercial_note',        ATenant.commercial_note)
    .&Set('city_id',                THlp.If0RetNull(ATenant.city_id));
end;

function TTenantSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('tenant.*')
    .Column('city.name').&As('city_name')
    .Column('city.state').&As('city_state')
    .Column('city.ibge_code').&As('city_ibge_code')
    .From('tenant')
    .LeftJoin('city')
         .&On('city.id = tenant.city_id')
  .AsString;
end;

function TTenantSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'tenant.id', ddMySql);
  end;
end;

function TTenantSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE tenant.id = ' + AId.ToString;
end;

function TTenantSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lTenant: TTenant;
  lCQL: ICQL;
begin
  lTenant := AEntity as TTenant;
  lCQL := TCQL.New(FDBName)
    .Update('tenant')
    .&Set('updated_at', lTenant.updated_at);

  // Carregar Campos Default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lTenant);

  Result := lCQL.Where('tenant.id = ' + AId.ToString).AsString;
end;

end.
