unit uBusinessProposal.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uBusinessProposal,
  criteria.query.language,
  uBusinessProposal.SQLBuilder.Interfaces,
  uBase.Entity,
  cqlbr.interfaces;

type
  TBusinessProposalSQLBuilder = class(TInterfacedObject, IBusinessProposalSQLBuilder)
  private
    procedure LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ABusinessProposal: TBusinessProposal);
  public
    FDBName: TDBName;
    constructor Create;
    destructor Destroy; override;

    // BusinessProposal
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

{ TBusinessProposalSQLBuilder }
constructor TBusinessProposalSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TBusinessProposalSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
var
  lCQL: ICQL;
begin
  lCQL := TCQL.New(FDBName)
    .Delete
    .From('business_proposal')
    .Where('business_proposal.id = ' + AId.ToString);

  if (ATenantId > 0) then
    lCQL.&And('business_proposal.tenant_id = ' + ATenantId.ToString);

  Result := lCQL.AsString;
end;

destructor TBusinessProposalSQLBuilder.Destroy;
begin
  inherited;
end;

function TBusinessProposalSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lBusinessProposal: TBusinessProposal;
  lCQL: ICQL;
begin
  lBusinessProposal := AEntity as TBusinessProposal;
  lCQL := TCQL.New(FDBName)
    .Insert
    .Into('business_proposal')
    .&Set('created_at',             now)
    .&Set('created_by_acl_user_id', lBusinessProposal.created_by_acl_user_id)
    .&Set('tenant_id',              lBusinessProposal.tenant_id);

  // Carregar Campos Default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lBusinessProposal);

  // Retornar String SQL
  Result := lCQL.AsString;
end;

function TBusinessProposalSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

procedure TBusinessProposalSQLBuilder.LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ABusinessProposal: TBusinessProposal);
begin
  ACQL
    .&Set('person_id',                        THlp.If0RetNull(ABusinessProposal.person_id))
    .&Set('requester',                        ABusinessProposal.requester)
    .&Set('expiration_date',                  ABusinessProposal.expiration_date)
    .&Set('delivery_forecast',                ABusinessProposal.delivery_forecast)
    .&Set('seller_id',                        THlp.If0RetNull(ABusinessProposal.seller_id))
    .&Set('note',                             ABusinessProposal.note)
    .&Set('internal_note',                    ABusinessProposal.internal_note)
    .&Set('payment_term_note',                ABusinessProposal.payment_term_note)
    .&Set('status',                           Ord(ABusinessProposal.status))
    .&Set('sum_business_proposal_item_total', ABusinessProposal.sum_business_proposal_item_total);
end;

function TBusinessProposalSQLBuilder.ReportById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('business_proposal.*')
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
    .From('business_proposal')
    .LeftJoin('person')
         .&On('person.id = business_proposal.person_id')
    .LeftJoin('city')
         .&On('city.id = person.city_id')
    .InnerJoin('person', 'seller')
          .&On('seller.id = business_proposal.seller_id')
    .Where('business_proposal.id = '       + AId.ToString)
    .&And('business_proposal.tenant_id = ' + ATenantId.ToString)
  .AsString;
end;

function TBusinessProposalSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('business_proposal.*')
    .Column('person.name').&As('person_name')
    .Column('seller.name').&As('seller_name')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('business_proposal')
    .LeftJoin('person')
         .&On('person.id = business_proposal.person_id')
    .InnerJoin('person', 'seller')
          .&On('seller.id = business_proposal.seller_id')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = business_proposal.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = business_proposal.updated_by_acl_user_id')
  .AsString;
end;

function TBusinessProposalSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'business_proposal.id', ddMySql);
  end;
end;

function TBusinessProposalSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE business_proposal.id = ' + AId.ToString;
  if (ATenantId > 0) then
    Result := Result + ' AND business_proposal.tenant_id = ' + ATenantId.ToString;
end;

function TBusinessProposalSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lBusinessProposal: TBusinessProposal;
  lCQL: ICQL;
begin
  lBusinessProposal := AEntity as TBusinessProposal;
  lCQL := TCQL.New(FDBName)
    .Update('business_proposal')
    .&Set('updated_at',             now)
    .&Set('updated_by_acl_user_id', lBusinessProposal.updated_by_acl_user_id);

  // Carregar Campos Default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lBusinessProposal);

  Result := lCQL
    .Where('business_proposal.id = '       + AId.ToString)
    .&And('business_proposal.tenant_id = ' + lBusinessProposal.tenant_id.ToString)
  .AsString;
end;

end.
