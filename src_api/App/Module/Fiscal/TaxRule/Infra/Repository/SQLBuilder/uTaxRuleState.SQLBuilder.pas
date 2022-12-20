unit uTaxRuleState.SQLBuilder;

interface

uses
  uTaxRuleState.SQLBuilder.Interfaces,
  cqlbr.interfaces,
  uBase.Entity,
  uTaxRuleState;

type
  TTaxRuleStateSQLBuilder = class(TInterfacedObject, ITaxRuleStateSQLBuilder)
  private
    procedure LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ATaxRuleState: TTaxRuleState);
  public
    FDBName: TDBName;
    constructor Create;

    function ScriptCreateTable: String; virtual; abstract;
    function DeleteById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectById(AId: Int64; ATenantId: Int64 = 0): String;
    function SelectAll: String;
    function InsertInto(AEntity: TBaseEntity): String;
    function LastInsertId: String;
    function Update(AEntity: TBaseEntity; AId: Int64): String;
    function DeleteByTaxRuleId(ATaxRuleId: Int64): String;
    function SelectByTaxRuleId(ATaxRuleId: Int64): String;
  end;

implementation

uses
  criteria.query.language,
  System.SysUtils,
  uApplication.Types,
  uConnection.Types;

{ TTaxRuleStateSQLBuilder }
constructor TTaxRuleStateSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TTaxRuleStateSQLBuilder.DeleteById(AId, ATenantId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('tax_rule_state')
    .Where('tax_rule_state.id = ' + AId.ToString)
  .AsString;
end;

function TTaxRuleStateSQLBuilder.DeleteByTaxRuleId(ATaxRuleId: Int64): String;
begin
  Result := TCQL.New(FDBName)
    .Delete
    .From('tax_rule_state')
    .Where('tax_rule_state.tax_rule_id = ' + ATaxRuleId.ToString)
  .AsString;
end;

function TTaxRuleStateSQLBuilder.InsertInto(AEntity: TBaseEntity): String;
var
  lTaxRuleState: TTaxRuleState;
  lCQL: ICQL;
begin
  lTaxRuleState := AEntity as TTaxRuleState;
  lCQL := TCQL.New(FDBName)
    .Insert
    .Into('tax_rule_state');

  // Carregar campos default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lTaxRuleState);

  // Retornar String SQL
  Result := lCQL.AsString;
end;

function TTaxRuleStateSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
end;

procedure TTaxRuleStateSQLBuilder.LoadDefaultFieldsToInsertOrUpdate(const ACQL: ICQL; const ATaxRuleState: TTaxRuleState);
const
  LDECIMAL_PLACES = 4;
begin
  ACQL
    .&Set('tax_rule_id',                             ATaxRuleState.tax_rule_id)
    .&Set('target_state',                            ATaxRuleState.target_state)
    .&Set('cfop_id',                                 ATaxRuleState.cfop_id)
    .&Set('icms_regime',                             Ord(ATaxRuleState.icms_regime))
    .&Set('icms_situation',                          Ord(ATaxRuleState.icms_situation))
    .&Set('icms_origin',                             Ord(ATaxRuleState.icms_origin))
    .&Set('icms_applicable_credit_calc_rate',        ATaxRuleState.icms_applicable_credit_calc_rate, LDECIMAL_PLACES)
    .&Set('icms_perc_of_used_credit',                ATaxRuleState.icms_perc_of_used_credit, LDECIMAL_PLACES)
    .&Set('icms_calc_base_mode',                     Ord(ATaxRuleState.icms_calc_base_mode))
    .&Set('icms_perc_of_calc_base_reduction',        ATaxRuleState.icms_perc_of_calc_base_reduction, LDECIMAL_PLACES)
    .&Set('icms_rate',                               ATaxRuleState.icms_rate, LDECIMAL_PLACES)
    .&Set('icms_perc_of_own_operation_calc_base',    ATaxRuleState.icms_perc_of_own_operation_calc_base, LDECIMAL_PLACES)
    .&Set('icms_deferral_perc',                      ATaxRuleState.icms_deferral_perc, LDECIMAL_PLACES)
    .&Set('icms_pst',                                ATaxRuleState.icms_pst, LDECIMAL_PLACES)
    .&Set('icms_coupon_rate',                        ATaxRuleState.icms_coupon_rate, LDECIMAL_PLACES)
    .&Set('icms_is_calc_base_with_insurance',        ATaxRuleState.icms_is_calc_base_with_insurance)
    .&Set('icms_is_calc_base_with_freight',          ATaxRuleState.icms_is_calc_base_with_freight)
    .&Set('icms_is_calc_base_with_ipi',              ATaxRuleState.icms_is_calc_base_with_ipi)
    .&Set('icms_is_calc_base_with_other_expenses',   ATaxRuleState.icms_is_calc_base_with_other_expenses)
    .&Set('icmsst_calc_base_mode',                   Ord(ATaxRuleState.icmsst_calc_base_mode))
    .&Set('icmsst_perc_of_calc_base_reduction',      ATaxRuleState.icmsst_perc_of_calc_base_reduction, LDECIMAL_PLACES)
    .&Set('icmsst_rate',                             ATaxRuleState.icmsst_rate, LDECIMAL_PLACES)
    .&Set('icmsst_interstate_rate',                  ATaxRuleState.icmsst_interstate_rate, LDECIMAL_PLACES)
    .&Set('icmsst_is_calc_base_with_insurance',      ATaxRuleState.icmsst_is_calc_base_with_insurance)
    .&Set('icmsst_is_calc_base_with_freight',        ATaxRuleState.icmsst_is_calc_base_with_freight)
    .&Set('icmsst_is_calc_base_with_ipi',            ATaxRuleState.icmsst_is_calc_base_with_ipi)
    .&Set('icmsst_is_calc_base_with_other_expenses', ATaxRuleState.icmsst_is_calc_base_with_other_expenses)
    .&Set('ipi_situation',                           Ord(ATaxRuleState.ipi_situation))
    .&Set('ipi_rate',                                ATaxRuleState.ipi_rate, LDECIMAL_PLACES)
    .&Set('pis_situation',                           Ord(ATaxRuleState.pis_situation))
    .&Set('pis_rate',                                ATaxRuleState.pis_rate, LDECIMAL_PLACES)
    .&Set('pisst_rate',                              ATaxRuleState.pisst_rate, LDECIMAL_PLACES)
    .&Set('cofins_situation',                        Ord(ATaxRuleState.cofins_situation))
    .&Set('cofins_rate',                             ATaxRuleState.cofins_rate, LDECIMAL_PLACES)
    .&Set('cofinsst_rate',                           ATaxRuleState.cofinsst_rate, LDECIMAL_PLACES)
    .&Set('taxpayer_note',                           ATaxRuleState.taxpayer_note);
end;

function TTaxRuleStateSQLBuilder.SelectAll: String;
begin
  Result := TCQL.New(FDBName)
    .Select
    .Column('tax_rule_state.*')
    .Column('cfop.code').&As('cfop_code')
    .Column('cfop.name').&As('cfop_name')
    .From('tax_rule_state')
    .InnerJoin('cfop')
          .&On('cfop.id = tax_rule_state.cfop_id')
  .AsString;
end;

function TTaxRuleStateSQLBuilder.SelectById(AId: Int64; ATenantId: Int64): String;
begin
  Result := SelectAll + ' WHERE tax_rule_state.id = ' + AId.ToString;
end;

function TTaxRuleStateSQLBuilder.SelectByTaxRuleId(ATaxRuleId: Int64): String;
begin
  Result := SelectAll + ' WHERE tax_rule_state.tax_rule_id = ' + ATaxRuleId.ToString;
end;

function TTaxRuleStateSQLBuilder.Update(AEntity: TBaseEntity; AId: Int64): String;
var
  lTaxRuleState: TTaxRuleState;
  lCQL: ICQL;
begin
  lTaxRuleState := AEntity as TTaxRuleState;
  lCQL := TCQL.New(FDBName)
    .Insert
    .Into('tax_rule_state');

  // Carregar campos default
  LoadDefaultFieldsToInsertOrUpdate(lCQL, lTaxRuleState);

  // Retornar String SQL
  Result := lCQL.Where('tax_rule_state.id = ' + AId.ToString).AsString;
end;

end.
