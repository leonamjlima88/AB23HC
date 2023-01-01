unit uTaxRuleState.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TTaxRuleStateBaseDTO = class
  private
    Ficms_perc_of_own_operation_calc_base: Double;
    Ficms_situation: SmallInt;
    Ficmsst_is_calc_base_with_insurance: SmallInt;
    Ficmsst_interstate_rate: Double;
    Ficms_regime: SmallInt;
    Ficms_coupon_rate: Double;
    Ficms_deferral_perc: Double;
    Fpisst_rate: Double;
    Ficms_rate: Double;
    Fcofinsst_rate: Double;
    Ficmsst_is_calc_base_with_freight: SmallInt;
    Ficmsst_is_calc_base_with_ipi: SmallInt;
    Ficmsst_perc_of_calc_base_reduction: Double;
    Ficms_pst: Double;
    Ficms_origin: SmallInt;
    Ficms_applicable_credit_calc_rate: Double;
    Fpis_situation: SmallInt;
    Fcofins_situation: SmallInt;
    Ficms_is_calc_base_with_insurance: SmallInt;
    Ficmsst_is_calc_base_with_other_expenses: SmallInt;
    Fpis_rate: Double;
    Fcfop_id: Int64;
    Ftarget_state: string;
    Fcofins_rate: Double;
    Ficmsst_calc_base_mode: SmallInt;
    Ficms_is_calc_base_with_freight: SmallInt;
    Ficms_is_calc_base_with_ipi: SmallInt;
    Ficms_perc_of_calc_base_reduction: Double;
    Fipi_situation: SmallInt;
    Ficms_perc_of_used_credit: Double;
    Ftaxpayer_note: String;
    Ficms_is_calc_base_with_other_expenses: SmallInt;
    Fipi_rate: Double;
    Ficmsst_rate: Double;
    Ficms_calc_base_mode: Double;
    Fcfop_name: String;
    Fcfop_code: String;
  public
    [SwagString(20)]
    [SwagProp('target_state', 'UF', true)]
    property target_state: string read Ftarget_state write Ftarget_state;

    [SwagNumber]
    [SwagProp('cfop_id', 'ID do CFOP', true)]
    property cfop_id: Int64 read Fcfop_id write Fcfop_id;

    [SwagString] {virtual}
    [SwagProp('cfop_code', 'Código do CFOP', false)]
    property cfop_code: String read Fcfop_code write Fcfop_code;

    [SwagString] {virtual}
    [SwagProp('cfop_name', 'Nome do CFOP', false)]
    property cfop_name: String read Fcfop_name write Fcfop_name;

    [SwagNumber(0,2)]
    [SwagProp('icms_regime', 'Regime tributário [0=SimplesNacional, 1=SimplesExcessoReceita, 2=RegimeNormal]', false)]
    property icms_regime: SmallInt read Ficms_regime write Ficms_regime;

    [SwagNumber(0,31)]
    [SwagProp('icms_situation',
      'Situação do icms [0=cst00, 1=cst10, 2=cst20, 3=cst30, 4=cst40, 5=cst41, 6=cst45, 7=cst50,'+
      ' 8=cst51, 9=cst60, 10=cst70, 11=cst80, 12=cst81, 13=cst90, 14=cstPart10, 15=cstPart90, 16=cstRep41,'+
      ' 17=cstVazio, 18=cstICMSOutraUF, 19=cstICMSSN, 20=cstRep60, 21=csosnVazio, 22=csosn101, 23=csosn102,'+
      ' 24=csosn103, 25=csosn201, 26=csosn202, 27=csosn203, 28=csosn300, 29=csosn400, 30=csosn500, 31=csosn900]',
      false
    )]
    property icms_situation: SmallInt read Ficms_situation write Ficms_situation;

    [SwagNumber(0,10)]
    [SwagProp('icms_origin',
      'Origem do icms [0=Nacional, 1=EstrangeiraImportacaoDireta, 2=EstrangeiraAdquiridaBrasil, 3=NacionalConteudoImportacaoSuperior40,'+
      ' 4=NacionalProcessosBasicos, 5=NacionalConteudoImportacaoInferiorIgual40, 6=EstrangeiraImportacaoDiretaSemSimilar, '+
      ' 7=EstrangeiraAdquiridaBrasilSemSimilar, 8=NacionalConteudoImportacaoSuperior70, 9=ReservadoParaUsoFuturo, 10=Vazio)',
      false
    )]
    property icms_origin: SmallInt read Ficms_origin write Ficms_origin;

    [SwagNumber]
    [SwagProp('icms_applicable_credit_calc_rate', 'Alíquota aplicável de cálculo de crédito do icms', false)]
    property icms_applicable_credit_calc_rate: Double read Ficms_applicable_credit_calc_rate write Ficms_applicable_credit_calc_rate;

    [SwagNumber]
    [SwagProp('icms_perc_of_used_credit', 'Percentual de crédito aproveitado do icms', false)]
    property icms_perc_of_used_credit: Double read Ficms_perc_of_used_credit write Ficms_perc_of_used_credit;

    [SwagNumber]
    [SwagProp('icms_calc_base_mode', 'Modalidade da base de cálculo do icms [0=MargemValorAgregado, 1=Pauta, 2=PrecoTabelado, 3=ValorOperacao, 4=Nenhum]', false)]
    property icms_calc_base_mode: Double read Ficms_calc_base_mode write Ficms_calc_base_mode;

    [SwagNumber]
    [SwagProp('icms_perc_of_calc_base_reduction', 'Percentual de redução da base de cálculo do icms', false)]
    property icms_perc_of_calc_base_reduction: Double read Ficms_perc_of_calc_base_reduction write Ficms_perc_of_calc_base_reduction;

    [SwagNumber]
    [SwagProp('icms_rate', 'Alíquota do icms', false)]
    property icms_rate: Double read Ficms_rate write Ficms_rate;

    [SwagNumber]
    [SwagProp('icms_perc_of_own_operation_calc_base', 'Percentual da base de cálculo operação própria', false)]
    property icms_perc_of_own_operation_calc_base: Double read Ficms_perc_of_own_operation_calc_base write Ficms_perc_of_own_operation_calc_base;

    [SwagNumber]
    [SwagProp('icms_deferral_perc', 'Percentual de diferimento do icms', false)]
    property icms_deferral_perc: Double read Ficms_deferral_perc write Ficms_deferral_perc;

    [SwagNumber]
    [SwagProp('icms_pst', 'Pst do icms', false)]
    property icms_pst: Double read Ficms_pst write Ficms_pst;

    [SwagNumber]
    [SwagProp('icms_coupon_rate', 'Alíquota do cupom fiscal', false)]
    property icms_coupon_rate: Double read Ficms_coupon_rate write Ficms_coupon_rate;

    [SwagNumber(0,1)]
    [SwagProp('icms_is_calc_base_with_insurance', 'Adicionar seguro na base de cálculo? [0=False, 1=True]', false)]
    property icms_is_calc_base_with_insurance: SmallInt read Ficms_is_calc_base_with_insurance write Ficms_is_calc_base_with_insurance;

    [SwagNumber(0,1)]
    [SwagProp('icms_is_calc_base_with_freight', 'Adicionar frete na base de cálculo? [0=False, 1=True]', false)]
    property icms_is_calc_base_with_freight: SmallInt read Ficms_is_calc_base_with_freight write Ficms_is_calc_base_with_freight;

    [SwagNumber(0,1)]
    [SwagProp('icms_is_calc_base_with_ipi', 'Adicionar ipi na base de cálculo? [0=False, 1=True]', false)]
    property icms_is_calc_base_with_ipi: SmallInt read Ficms_is_calc_base_with_ipi write Ficms_is_calc_base_with_ipi;

    [SwagNumber(0,1)]
    [SwagProp('icms_is_calc_base_with_other_expenses', 'Adicionar outras despesas na base de cálculo? [0=False, 1=True]', false)]
    property icms_is_calc_base_with_other_expenses: SmallInt read Ficms_is_calc_base_with_other_expenses write Ficms_is_calc_base_with_other_expenses;

    [SwagNumber(0,6)]
    [SwagProp('icmsst_calc_base_mode', 'Modalidade da base de cálculo do icmsst [0=PrecoTabelado, 1=ListaNegativa, 2=ListaPositiva, 3=ListaNeutra, 4=MargemValorAgregado, 5=Pauta, 6=ValordaOperacao)', false)]
    property icmsst_calc_base_mode: SmallInt read Ficmsst_calc_base_mode write Ficmsst_calc_base_mode;

    [SwagNumber]
    [SwagProp('icmsst_perc_of_calc_base_reduction', 'Percentual da redução da base de cálculo do icmsst', false)]
    property icmsst_perc_of_calc_base_reduction: Double read Ficmsst_perc_of_calc_base_reduction write Ficmsst_perc_of_calc_base_reduction;

    [SwagNumber]
    [SwagProp('icmsst_rate', 'Alíquota do icmsst', false)]
    property icmsst_rate: Double read Ficmsst_rate write Ficmsst_rate;

    [SwagNumber]
    [SwagProp('icmsst_interstate_rate', 'Alíquota interestadual do icmsst', false)]
    property icmsst_interstate_rate: Double read Ficmsst_interstate_rate write Ficmsst_interstate_rate;

    [SwagNumber(0,1)]
    [SwagProp('icmsst_is_calc_base_with_insurance', 'Adicionar seguro na base de cálculo do icmsst? [0=False, 1=True]', false)]
    property icmsst_is_calc_base_with_insurance: SmallInt read Ficmsst_is_calc_base_with_insurance write Ficmsst_is_calc_base_with_insurance;

    [SwagNumber(0,1)]
    [SwagProp('icmsst_is_calc_base_with_freight', 'Adicionar frete na base de cálculo do icmsst? [0=False, 1=True]', false)]
    property icmsst_is_calc_base_with_freight: SmallInt read Ficmsst_is_calc_base_with_freight write Ficmsst_is_calc_base_with_freight;

    [SwagNumber(0,1)]
    [SwagProp('icmsst_is_calc_base_with_ipi', 'Adicionar ipi na base de cálculo do icmsst? [0=False, 1=True]', false)]
    property icmsst_is_calc_base_with_ipi: SmallInt read Ficmsst_is_calc_base_with_ipi write Ficmsst_is_calc_base_with_ipi;

    [SwagNumber(0,1)]
    [SwagProp('icmsst_is_calc_base_with_other_expenses', 'Adicionar outras despesas na base de cálculo do icmsst? [0=False, 1=True]', false)]
    property icmsst_is_calc_base_with_other_expenses: SmallInt read Ficmsst_is_calc_base_with_other_expenses write Ficmsst_is_calc_base_with_other_expenses;

    [SwagNumber(0,11)]
    [SwagProp('ipi_situation',
      'Situação do ipi [0=ipi00, 1=ipi49, 2=ipi50, 3=ipi99, 4=ipi01, 5=ipi02, 6=ipi03, 7=ipi04, 8=ipi05, ipi51, ipi52,'+
      ' 9=ipi53, 10=ipi54, 11=ipi55]',
      false
    )]
    property ipi_situation: SmallInt read Fipi_situation write Fipi_situation;

    [SwagNumber]
    [SwagProp('ipi_rate', 'Alíquota do ipi', false)]
    property ipi_rate: Double read Fipi_rate write Fipi_rate;

    [SwagNumber(0,32)]
    [SwagProp('pis_situation',
      'Situação do pis [0=pis01, 1=pis02, 2=pis03, 3=pis04, 4=pis05, 5=pis06, 6=pis07, 7=pis08, 8=pis09, 9=pis49, 10=pis50,'+
      ' 11=pis51, 12=pis52, 13=pis53, 14=pis54, 15=pis55, 16=pis56, 17=pis60, 18=pis61, 19=pis62, 20=pis63, 21=pis64,'+
      ' 22=pis65, 23=pis66, 24=pis67, 25=pis70, 26=pis71, 27=pis72, 28=pis73, 29=pis74, 30=pis75, 31=pis98, 32=pis99]',
      false
    )]
    property pis_situation: SmallInt read Fpis_situation write Fpis_situation;

    [SwagNumber]
    [SwagProp('pis_rate', 'Alíquota do pis', false)]
    property pis_rate: Double read Fpis_rate write Fpis_rate;

    [SwagNumber]
    [SwagProp('pisst_rate', 'Alíquota do pisst', false)]
    property pisst_rate: Double read Fpisst_rate write Fpisst_rate;

    [SwagNumber(0,32)]
    [SwagProp('cofins_situation',
      'Situação do cofins [0=cof01, 1=cof02, 2=cof03, 3=cof04, 4=cof05, 5=cof06, 6=cof07, 7=cof08, 8=cof09, 9=cof49,'+
      ' 10cof50, 11=cof51, 12=cof52, 13=cof53, 14=cof54, 15=cof55, 16=cof56, 17=cof60, 18=cof61, 19=cof62, 20=cof63, 21=cof64,' +
      ' 22=cof65, 23=cof66, 24=cof67, 25=cof70, 26=cof71, 27=cof72, 28=cof73, 29=cof74, 30=cof75, 31=cof98, 32=cof99]',
      false
    )]
    property cofins_situation: SmallInt read Fcofins_situation write Fcofins_situation;

    [SwagNumber]
    [SwagProp('cofins_rate', 'Alíquota do cofins', false)]
    property cofins_rate: Double read Fcofins_rate write Fcofins_rate;

    [SwagNumber]
    [SwagProp('cofinsst_rate', 'Alíquota do cofinsst', false)]
    property cofinsst_rate: Double read Fcofinsst_rate write Fcofinsst_rate;

    [SwagString]
    [SwagProp('taxpayer_note', 'Observação de interesse do contribuinte de icms', false)]
    property taxpayer_note: String read Ftaxpayer_note write Ftaxpayer_note;
  end;

implementation

end.
