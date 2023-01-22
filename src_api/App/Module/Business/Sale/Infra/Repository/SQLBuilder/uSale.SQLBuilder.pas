unit uSale.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uSale,
  criteria.query.language,
  uSale.SQLBuilder.Interfaces,
  uBase.Entity,
  cqlbr.interfaces;

type
  TSaleSQLBuilder = class(TInterfacedObject, ISaleSQLBuilder)
  private
    procedure LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ASale: TSale);
  public
    FDBName: TDBName;
    constructor Create;
    destructor Destroy; override;

    // Sale
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectAll: String;
    function SelectById(AId: Int64; ATenantId: Int64 = 0): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function ReportById(AId, ATenantId: Int64): String;
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

{ TSaleSQLBuilder }
constructor TSaleSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TSaleSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
var
  lCQL: ICQL;
begin
  lCQL := TCQL.New(FDBName)
    .Delete
    .From('sale')
    .Where('sale.id = ' + AId.ToString);

  if (ATenantId > 0) then
    lCQL.&And('sale.tenant_id = ' + ATenantId.ToString);

  Result := lCQL.AsString;
end;

destructor TSaleSQLBuilder.Destroy;
begin
  inherited;
end;

function TSaleSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lSale: TSale;
  lCQL: ICQL;
begin
  lSale := AEntity as TSale;
  lCQL := TCQL.New(FDBName)
    .Insert
    .Into('sale')
    .&Set('created_at',             now)
    .&Set('created_by_acl_user_id', lSale.created_by_acl_user_id)
    .&Set('tenant_id',              lSale.tenant_id);

  // Carregar Campos Default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lSale);

  // Retornar String SQL
  Result := lCQL.AsString;
end;

function TSaleSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

procedure TSaleSQLBuilder.LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ASale: TSale);
begin
  ACQL
    .&Set('person_id',                        THlp.If0RetNull(ASale.person_id))
    .&Set('seller_id',                        THlp.If0RetNull(ASale.seller_id))
    .&Set('note',                             ASale.note)
    .&Set('internal_note',                    ASale.internal_note)
    .&Set('status',                           Ord(ASale.status))
    .&Set('sum_sale_item_total',              ASale.sum_sale_item_total)
    .&Set('sum_sale_payment_amount',          ASale.sum_sale_payment_amount)
    .&Set('payment_discount',                 ASale.payment_discount)
    .&Set('payment_increase',                 ASale.payment_increase)
    .&Set('payment_total',                    ASale.payment_total);
end;

function TSaleSQLBuilder.ReportById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('sale.*')
    .Column('person.name').&As('person_name')
    .Column('person.alias_name').&As('person_alias_name')
    .Column('person.legal_entity_number').&As('person_legal_entity_number')
    .Column('person.state_registration').&As('person_state_registration')
    .Column('person.municipal_registration').&As('person_municipal_registration')
    .Column('person.address').&As('person_address')
    .Column('person.address_number').&As('person_address_number')
    .Column('person.district').&As('person_district')
    .Column('person.complement').&As('person_complement')
    .Column('city.name').&As('city_name')
    .Column('city.state').&As('city_state')
    .Column('person.zipcode').&As('person_zipcode')
    .Column('person.phone_1').&As('person_phone_1')
    .Column('person.phone_2').&As('person_phone_2')
    .Column('person.phone_3').&As('person_phone_3')
    .Column('person.company_email').&As('person_company_email')
    .Column('person.financial_email').&As('person_financial_email')
    .Column('seller.name').&As('seller_name')
    .From('sale')
    .LeftJoin('person')
         .&On('person.id = sale.person_id')
    .LeftJoin('city')
         .&On('city.id = person.city_id')
    .InnerJoin('person', 'seller')
          .&On('seller.id = sale.seller_id')
    .Where('sale.id = '       + AId.ToString)
    .&And('sale.tenant_id = ' + ATenantId.ToString)
  .AsString;
end;

function TSaleSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('sale.*')
    .Column('person.name').&As('person_name')
    .Column('seller.name').&As('seller_name')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('sale')
    .LeftJoin('person')
         .&On('person.id = sale.person_id')
    .InnerJoin('person', 'seller')
          .&On('seller.id = sale.seller_id')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = sale.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = sale.updated_by_acl_user_id')
  .AsString;
end;

function TSaleSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'sale.id', ddMySql);
  end;
end;

function TSaleSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE sale.id = ' + AId.ToString;
  if (ATenantId > 0) then
    Result := Result + ' AND sale.tenant_id = ' + ATenantId.ToString;
end;

function TSaleSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lSale: TSale;
  lCQL: ICQL;
begin
  lSale := AEntity as TSale;
  lCQL := TCQL.New(FDBName)
    .Update('sale')
    .&Set('updated_at',             now)
    .&Set('updated_by_acl_user_id', lSale.updated_by_acl_user_id);

  // Carregar Campos Default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lSale);

  Result := lCQL
    .Where('sale.id = '       + AId.ToString)
    .&And('sale.tenant_id = ' + lSale.tenant_id.ToString)
  .AsString;
end;

end.
