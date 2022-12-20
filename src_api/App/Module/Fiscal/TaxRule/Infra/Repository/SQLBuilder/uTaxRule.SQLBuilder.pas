unit uTaxRule.SQLBuilder;

interface

uses
  uPageFilter,
  uSelectWithFilter,
  uTaxRule,
  criteria.query.language,
  uTaxRule.SQLBuilder.Interfaces,
  uBase.Entity;

type
  TTaxRuleSQLBuilder = class(TInterfacedObject, ITaxRuleSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;
    destructor Destroy; override;

    // TaxRule
    function ScriptCreateTable: String; virtual; abstract;
    function ScriptSeedTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectAll: String;
    function SelectById(AId: Int64; ATenantId: Int64 = 0): String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function RegisteredEins(AEin: String; AId: Int64): String;
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
  uHlp;

{ TTaxRuleSQLBuilder }
function TTaxRuleSQLBuilder.RegisteredEins(AEin: String; AId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('tax_rule.ein')
    .From('tax_rule')
    .Where('tax_rule.ein').Equal(AEin)
    .&And('tax_rule.id').NotEqual(AId)
  .AsString;
end;

constructor TTaxRuleSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TTaxRuleSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
var
  lCQL: ICQL;
begin
  lCQL := TCQL.New(FDBName)
    .Delete
    .From('tax_rule')
    .Where('tax_rule.id = ' + AId.ToString);

  if (ATenantId > 0) then
    lCQL.&And('tax_rule.tenant_id = ' + ATenantId.ToString);

  Result := lCQL.AsString;
end;

destructor TTaxRuleSQLBuilder.Destroy;
begin
  inherited;
end;

function TTaxRuleSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lTaxRule: TTaxRule;
begin
  lTaxRule := AEntity as TTaxRule;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('tax_rule')
    .&Set('name',                   lTaxRule.name)
    .&Set('operation_type_id',      lTaxRule.operation_type_id)
    .&Set('is_final_customer',      lTaxRule.is_final_customer)
    .&Set('created_at',             lTaxRule.created_at)
    .&Set('created_by_acl_user_id', lTaxRule.created_by_acl_user_id)
    .&Set('tenant_id',              lTaxRule.tenant_id)
  .AsString;
end;

function TTaxRuleSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

function TTaxRuleSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('tax_rule.*')
    .Column('created_by_acl_user.name').&As('created_by_acl_user_name')
    .Column('updated_by_acl_user.name').&As('updated_by_acl_user_name')
    .From('tax_rule')
    .LeftJoin('acl_user', 'created_by_acl_user')
         .&On('created_by_acl_user.id = tax_rule.created_by_acl_user_id')
    .LeftJoin('acl_user', 'updated_by_acl_user')
         .&On('updated_by_acl_user.id = tax_rule.updated_by_acl_user_id')
  .AsString;
end;

function TTaxRuleSQLBuilder.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  case FDBName of
    dbnMySQL: Result := TSelectWithFilter.SelectAllWithFilter(APageFilter, SelectAll, 'tax_rule.id', ddMySql);
  end;
end;

function TTaxRuleSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE tax_rule.id = ' + AId.ToString;
  if (ATenantId > 0) then
    Result := Result + ' AND tax_rule.tenant_id = ' + ATenantId.ToString;
end;

function TTaxRuleSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lTaxRule: TTaxRule;
begin
  lTaxRule := AEntity as TTaxRule;
  Result := TCQL.New(FDBName)
    .Update('tax_rule')
    .&Set('name',                   lTaxRule.name)
    .&Set('operation_type_id',      lTaxRule.operation_type_id)
    .&Set('is_final_customer',      lTaxRule.is_final_customer)
    .&Set('updated_at',             lTaxRule.updated_at)
    .&Set('updated_by_acl_user_id', lTaxRule.updated_by_acl_user_id)
    .Where('tax_rule.id = ' + AId.ToString)
    .&And('tax_rule.tenant_id = ' + lTaxRule.tenant_id.ToString)
  .AsString;
end;

end.
