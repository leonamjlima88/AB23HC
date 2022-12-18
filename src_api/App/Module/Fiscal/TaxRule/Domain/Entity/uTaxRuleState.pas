unit uTaxRuleState;

interface

uses
  uBase.Entity,
  uCFOP,
  uTaxRuleState.Types;

type
  TTaxRuleState = class(TBaseEntity)
  private
    Fid: Int64;
    Ftax_rule_id: Int64;
    Ficms_perc_of_own_operation_calc_base: Double;
    Ficms_situation: TTaxRuleStateIcmsSituation;
    Ficmsst_is_calc_base_with_insurance: SmallInt;
    Ficmsst_interstate_rate: Double;
    Ficms_regime: TTaxRuleStateIcmsRegime;
    Ficms_coupon_rate: Double;
    Ficms_deferral_perc: Double;
    Fpisst_rate: Double;
    Ficms_rate: Double;
    Fcofinsst_rate: Double;
    Ficmsst_is_calc_base_with_freight: SmallInt;
    Ficmsst_is_calc_base_with_ipi: SmallInt;
    Ficmsst_perc_of_calc_base_reduction: Double;
    Ficms_pst: Double;
    Ficms_origin: TTaxRuleStateIcmsOrigin;
    Ficms_applicable_credit_calc_rate: Double;
    Fpis_situation: TTaxRuleStatePisSituation;
    Fcofins_situation: TTaxRuleStateCofinsSituation;
    Ficms_is_calc_base_with_insurance: SmallInt;
    Ficmsst_is_calc_base_with_other_expenses: SmallInt;
    Fpis_rate: Double;
    Fcfop_id: Int64;
    Ftarget_state: string;
    Fcofins_rate: Double;
    Ficmsst_calc_base_mode: TTaxRuleStateIcmsStCalcBaseMode;
    Ficms_is_calc_base_with_freight: SmallInt;
    Ficms_is_calc_base_with_ipi: SmallInt;
    Ficms_perc_of_calc_base_reduction: Double;
    Fipi_situation: TTaxRuleStateIpiSituation;
    Ficms_perc_of_used_credit: Double;
    Ftaxpayer_note: String;
    Ficms_is_calc_base_with_other_expenses: SmallInt;
    Fipi_rate: Double;
    Ficmsst_rate: Double;
    Ficms_calc_base_mode: TTaxRuleStateIcmsCalcBaseMode;

    // OneToOne
    Fcfop: TCFOP;

    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property tax_rule_id: Int64 read Ftax_rule_id write Ftax_rule_id;
    property target_state: string read Ftarget_state write Ftarget_state;
    property cfop_id: Int64 read Fcfop_id write Fcfop_id;
    property icms_regime: TTaxRuleStateIcmsRegime read Ficms_regime write Ficms_regime;
    property icms_situation: TTaxRuleStateIcmsSituation read Ficms_situation write Ficms_situation;
    property icms_origin: TTaxRuleStateIcmsOrigin read Ficms_origin write Ficms_origin;
    property icms_applicable_credit_calc_rate: Double read Ficms_applicable_credit_calc_rate write Ficms_applicable_credit_calc_rate;
    property icms_perc_of_used_credit: Double read Ficms_perc_of_used_credit write Ficms_perc_of_used_credit;
    property icms_calc_base_mode: TTaxRuleStateIcmsCalcBaseMode read Ficms_calc_base_mode write Ficms_calc_base_mode;
    property icms_perc_of_calc_base_reduction: Double read Ficms_perc_of_calc_base_reduction write Ficms_perc_of_calc_base_reduction;
    property icms_rate: Double read Ficms_rate write Ficms_rate;
    property icms_perc_of_own_operation_calc_base: Double read Ficms_perc_of_own_operation_calc_base write Ficms_perc_of_own_operation_calc_base;
    property icms_deferral_perc: Double read Ficms_deferral_perc write Ficms_deferral_perc;
    property icms_pst: Double read Ficms_pst write Ficms_pst;
    property icms_coupon_rate: Double read Ficms_coupon_rate write Ficms_coupon_rate;
    property icms_is_calc_base_with_insurance: SmallInt read Ficms_is_calc_base_with_insurance write Ficms_is_calc_base_with_insurance;
    property icms_is_calc_base_with_freight: SmallInt read Ficms_is_calc_base_with_freight write Ficms_is_calc_base_with_freight;
    property icms_is_calc_base_with_ipi: SmallInt read Ficms_is_calc_base_with_ipi write Ficms_is_calc_base_with_ipi;
    property icms_is_calc_base_with_other_expenses: SmallInt read Ficms_is_calc_base_with_other_expenses write Ficms_is_calc_base_with_other_expenses;
    property icmsst_calc_base_mode: TTaxRuleStateIcmsStCalcBaseMode read Ficmsst_calc_base_mode write Ficmsst_calc_base_mode;
    property icmsst_perc_of_calc_base_reduction: Double read Ficmsst_perc_of_calc_base_reduction write Ficmsst_perc_of_calc_base_reduction;
    property icmsst_rate: Double read Ficmsst_rate write Ficmsst_rate;
    property icmsst_interstate_rate: Double read Ficmsst_interstate_rate write Ficmsst_interstate_rate;
    property icmsst_is_calc_base_with_insurance: SmallInt read Ficmsst_is_calc_base_with_insurance write Ficmsst_is_calc_base_with_insurance;
    property icmsst_is_calc_base_with_freight: SmallInt read Ficmsst_is_calc_base_with_freight write Ficmsst_is_calc_base_with_freight;
    property icmsst_is_calc_base_with_ipi: SmallInt read Ficmsst_is_calc_base_with_ipi write Ficmsst_is_calc_base_with_ipi;
    property icmsst_is_calc_base_with_other_expenses: SmallInt read Ficmsst_is_calc_base_with_other_expenses write Ficmsst_is_calc_base_with_other_expenses;
    property ipi_situation: TTaxRuleStateIpiSituation read Fipi_situation write Fipi_situation;
    property ipi_rate: Double read Fipi_rate write Fipi_rate;
    property pis_situation: TTaxRuleStatePisSituation read Fpis_situation write Fpis_situation;
    property pis_rate: Double read Fpis_rate write Fpis_rate;
    property pisst_rate: Double read Fpisst_rate write Fpisst_rate;
    property cofins_situation: TTaxRuleStateCofinsSituation read Fcofins_situation write Fcofins_situation;
    property cofins_rate: Double read Fcofins_rate write Fcofins_rate;
    property cofinsst_rate: Double read Fcofinsst_rate write Fcofinsst_rate;
    property taxpayer_note: String read Ftaxpayer_note write Ftaxpayer_note;

    // OneToOne
    property cfop: TCFOP read Fcfop write Fcfop;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils,
  uHlp,
  uApplication.Types,
  System.StrUtils;

{ TTaxRuleState }

constructor TTaxRuleState.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TTaxRuleState.Destroy;
begin
  if Assigned(Fcfop) then Fcfop.Free;
  inherited;
end;

procedure TTaxRuleState.Initialize;
begin
  Fcfop := TCFOP.Create;
end;

procedure TTaxRuleState.Validate;
begin
  if not MatchStr(Ftarget_state.Trim.ToUpper, THlp.StateList) then
    raise Exception.Create(Format(FIELD_WITH_VALUE_IS_INVALID, ['tax_rule_state.target_state', Ftarget_state.Trim.ToUpper]));
end;

end.
