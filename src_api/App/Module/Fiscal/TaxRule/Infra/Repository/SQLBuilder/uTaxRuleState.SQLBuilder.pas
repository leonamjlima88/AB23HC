unit uTaxRuleState.SQLBuilder;

interface

uses
  uTaxRuleState.SQLBuilder.Interfaces,
  cqlbr.interfaces,
  uBase.Entity;

type
  TTaxRuleStateSQLBuilder = class(TInterfacedObject, ITaxRuleStateSQLBuilder)
  public
    FDBName: TDBName;
    constructor Create;

    function ScriptCreateTable: String; virtual; abstract;
    function DeleteById(AId: Int64): String;
    function SelectById(AId: Int64): String;
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
  uTaxRuleState,
  uApplication.Types,
  uConnection.Types;

{ TTaxRuleStateSQLBuilder }
constructor TTaxRuleStateSQLBuilder.Create;
begin
  inherited Create;
  FDBName := dbnDB2;
end;

function TTaxRuleStateSQLBuilder.DeleteById(AId: Int64): String;
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
begin
  lTaxRuleState := AEntity as TTaxRuleState;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('tax_rule_state')
    .&Set('tax_rule_id',                             lTaxRuleState.tax_rule_id)
    .&Set('target_state',                            lTaxRuleState.target_state)
    .&Set('cfop_id',                                 lTaxRuleState.cfop_id)
    .&Set('icms_regime',                             Ord(lTaxRuleState.icms_regime))
    .&Set('icms_situation',                          Ord(lTaxRuleState.icms_situation))
    .&Set('icms_origin',                             Ord(lTaxRuleState.icms_origin))
    .&Set('icms_applicable_credit_calc_rate',        Extended(lTaxRuleState.icms_applicable_credit_calc_rate))
    .&Set('icms_perc_of_used_credit',                Extended(lTaxRuleState.icms_perc_of_used_credit))
    .&Set('icms_calc_base_mode',                     Ord(lTaxRuleState.icms_calc_base_mode))
    .&Set('icms_perc_of_calc_base_reduction',        Extended(lTaxRuleState.icms_perc_of_calc_base_reduction))
    .&Set('icms_rate',                               Extended(lTaxRuleState.icms_rate))
    .&Set('icms_perc_of_own_operation_calc_base',    Extended(lTaxRuleState.icms_perc_of_own_operation_calc_base))
    .&Set('icms_deferral_perc',                      Extended(lTaxRuleState.icms_deferral_perc))
    .&Set('icms_pst',                                Extended(lTaxRuleState.icms_pst))
    .&Set('icms_coupon_rate',                        Extended(lTaxRuleState.icms_coupon_rate))
    .&Set('icms_is_calc_base_with_insurance',        lTaxRuleState.icms_is_calc_base_with_insurance)
    .&Set('icms_is_calc_base_with_freight',          lTaxRuleState.icms_is_calc_base_with_freight)
    .&Set('icms_is_calc_base_with_ipi',              lTaxRuleState.icms_is_calc_base_with_ipi)
    .&Set('icms_is_calc_base_with_other_expenses',   lTaxRuleState.icms_is_calc_base_with_other_expenses)
    .&Set('icmsst_calc_base_mode',                   Ord(lTaxRuleState.icmsst_calc_base_mode))
    .&Set('icmsst_perc_of_calc_base_reduction',      Extended(lTaxRuleState.icmsst_perc_of_calc_base_reduction))
    .&Set('icmsst_rate',                             Extended(lTaxRuleState.icmsst_rate))
    .&Set('icmsst_interstate_rate',                  Extended(lTaxRuleState.icmsst_interstate_rate))
    .&Set('icmsst_is_calc_base_with_insurance',      lTaxRuleState.icmsst_is_calc_base_with_insurance)
    .&Set('icmsst_is_calc_base_with_freight',        lTaxRuleState.icmsst_is_calc_base_with_freight)
    .&Set('icmsst_is_calc_base_with_ipi',            lTaxRuleState.icmsst_is_calc_base_with_ipi)
    .&Set('icmsst_is_calc_base_with_other_expenses', lTaxRuleState.icmsst_is_calc_base_with_other_expenses)
    .&Set('ipi_situation',                           Ord(lTaxRuleState.ipi_situation))
    .&Set('ipi_rate',                                Extended(lTaxRuleState.ipi_rate))
    .&Set('pis_situation',                           Ord(lTaxRuleState.pis_situation))
    .&Set('pis_rate',                                Extended(lTaxRuleState.pis_rate))
    .&Set('pisst_rate',                              Extended(lTaxRuleState.pisst_rate))
    .&Set('cofins_situation',                        Ord(lTaxRuleState.cofins_situation))
    .&Set('cofins_rate',                             Extended(lTaxRuleState.cofins_rate))
    .&Set('cofinsst_rate',                           Extended(lTaxRuleState.cofinsst_rate))
    .&Set('taxpayer_note',                           lTaxRuleState.taxpayer_note)
  .AsString;
end;

function TTaxRuleStateSQLBuilder.LastInsertId: String;
begin
  case FDBName of
    dbnMySQL: Result := SELECT_LAST_INSERT_ID_MYSQL;
  end;
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

function TTaxRuleStateSQLBuilder.SelectById(AId: Int64): String;
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
begin
  lTaxRuleState := AEntity as TTaxRuleState;
  Result := TCQL.New(FDBName)
    .Insert
    .Into('tax_rule_state')
    .&Set('tax_rule_id',                             lTaxRuleState.tax_rule_id)
    .&Set('target_state',                            lTaxRuleState.target_state)
    .&Set('cfop_id',                                 lTaxRuleState.cfop_id)
    .&Set('icms_regime',                             Ord(lTaxRuleState.icms_regime))
    .&Set('icms_situation',                          Ord(lTaxRuleState.icms_situation))
    .&Set('icms_origin',                             Ord(lTaxRuleState.icms_origin))
    .&Set('icms_applicable_credit_calc_rate',        Extended(lTaxRuleState.icms_applicable_credit_calc_rate))
    .&Set('icms_perc_of_used_credit',                Extended(lTaxRuleState.icms_perc_of_used_credit))
    .&Set('icms_calc_base_mode',                     Ord(lTaxRuleState.icms_calc_base_mode))
    .&Set('icms_perc_of_calc_base_reduction',        Extended(lTaxRuleState.icms_perc_of_calc_base_reduction))
    .&Set('icms_rate',                               Extended(lTaxRuleState.icms_rate))
    .&Set('icms_perc_of_own_operation_calc_base',    Extended(lTaxRuleState.icms_perc_of_own_operation_calc_base))
    .&Set('icms_deferral_perc',                      Extended(lTaxRuleState.icms_deferral_perc))
    .&Set('icms_pst',                                Extended(lTaxRuleState.icms_pst))
    .&Set('icms_coupon_rate',                        Extended(lTaxRuleState.icms_coupon_rate))
    .&Set('icms_is_calc_base_with_insurance',        lTaxRuleState.icms_is_calc_base_with_insurance)
    .&Set('icms_is_calc_base_with_freight',          lTaxRuleState.icms_is_calc_base_with_freight)
    .&Set('icms_is_calc_base_with_ipi',              lTaxRuleState.icms_is_calc_base_with_ipi)
    .&Set('icms_is_calc_base_with_other_expenses',   lTaxRuleState.icms_is_calc_base_with_other_expenses)
    .&Set('icmsst_calc_base_mode',                   Ord(lTaxRuleState.icmsst_calc_base_mode))
    .&Set('icmsst_perc_of_calc_base_reduction',      Extended(lTaxRuleState.icmsst_perc_of_calc_base_reduction))
    .&Set('icmsst_rate',                             Extended(lTaxRuleState.icmsst_rate))
    .&Set('icmsst_interstate_rate',                  Extended(lTaxRuleState.icmsst_interstate_rate))
    .&Set('icmsst_is_calc_base_with_insurance',      lTaxRuleState.icmsst_is_calc_base_with_insurance)
    .&Set('icmsst_is_calc_base_with_freight',        lTaxRuleState.icmsst_is_calc_base_with_freight)
    .&Set('icmsst_is_calc_base_with_ipi',            lTaxRuleState.icmsst_is_calc_base_with_ipi)
    .&Set('icmsst_is_calc_base_with_other_expenses', lTaxRuleState.icmsst_is_calc_base_with_other_expenses)
    .&Set('ipi_situation',                           Ord(lTaxRuleState.ipi_situation))
    .&Set('ipi_rate',                                Extended(lTaxRuleState.ipi_rate))
    .&Set('pis_situation',                           Ord(lTaxRuleState.pis_situation))
    .&Set('pis_rate',                                Extended(lTaxRuleState.pis_rate))
    .&Set('pisst_rate',                              Extended(lTaxRuleState.pisst_rate))
    .&Set('cofins_situation',                        Ord(lTaxRuleState.cofins_situation))
    .&Set('cofins_rate',                             Extended(lTaxRuleState.cofins_rate))
    .&Set('cofinsst_rate',                           Extended(lTaxRuleState.cofinsst_rate))
    .&Set('taxpayer_note',                           lTaxRuleState.taxpayer_note)
    .Where('tax_rule_state.id = ' + AId.ToString)
  .AsString;
end;

end.
