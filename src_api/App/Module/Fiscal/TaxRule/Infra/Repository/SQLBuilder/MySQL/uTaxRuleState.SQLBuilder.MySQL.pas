unit uTaxRuleState.SQLBuilder.MySQL;

interface

uses
  uTaxRuleState.SQLBuilder,
  uTaxRuleState.SQLBuilder.Interfaces;

type
  TTaxRuleStateSQLBuilderMySQL = class(TTaxRuleStateSQLBuilder, ITaxRuleStateSQLBuilder)
  public
    constructor Create;
    class function Make: ITaxRuleStateSQLBuilder;
    function ScriptCreateTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TTaxRuleStateSQLBuilderMySQL }

constructor TTaxRuleStateSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TTaxRuleStateSQLBuilderMySQL.Make: ITaxRuleStateSQLBuilder;
begin
  Result := Self.Create;
end;

function TTaxRuleStateSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `tax_rule_state` ( '+
            '   `id` bigint NOT NULL AUTO_INCREMENT, '+
            '   `tax_rule_id` bigint NOT NULL, '+
            '   `target_state` varchar(20) NOT NULL, '+
            '   `cfop_id` bigint NOT NULL, '+
            '   `icms_regime` tinyint NOT NULL COMMENT ''Regime tributário [0=SimplesNacional, 1=SimplesExcessoReceita, 2=RegimeNormal]'', '+
            '   `icms_situation` tinyint NOT NULL COMMENT ''[0=cst00, 1=cst10, 2=cst20, 3=cst30, 4=cst40, 5=cst41, 6=cst45, 7=cst50, '+
            '    8=cst51, 9=cst60, 10=cst70, 11=cst80, 12=cst81, 13=cst90, 14=cstPart10, 15=cstPart90, 16=cstRep41, 17=cstVazio, 18=cstICMSOutraUF,'+
            '    19=cstICMSSN, 20=cstRep60, 21=csosnVazio, 22=csosn101, 23=csosn102, 24=csosn103, 25=csosn201, 26=csosn202, 27=csosn203, 28=csosn300,'+
            '    29=csosn400,  0=csosn500, 31=csosn900]'', '+
            '   `icms_origin` tinyint NOT NULL COMMENT ''Origem do icms [0=Nacional, 1=EstrangeiraImportacaoDireta, 2=EstrangeiraAdquiridaBrasil,'+
            '    3=NacionalConteudoImportacaoSuperior40, 4=NacionalProcessosBasicos, 5=NacionalConteudoImportacaoInferiorIgual40, 6=EstrangeiraImportacaoDiretaSemSimilar,'+
            '    7=EstrangeiraAdquiridaBrasilSemSimilar, 8=NacionalConteudoImportacaoSuperior70, 9=ReservadoParaUsoFuturo, 10=Vazio]'', '+
            '   `icms_applicable_credit_calc_rate` decimal(18,4) DEFAULT NULL, '+
            '   `icms_perc_of_used_credit` decimal(18,4) DEFAULT NULL, '+
            '   `icms_calc_base_mode` tinyint DEFAULT NULL COMMENT ''Modalidade da base de cálculo do icms [0=MargemValorAgregado, 1=Pauta, 2=PrecoTabelado, 3=ValorOperacao, 4=Nenhum]'', '+
            '   `icms_perc_of_calc_base_reduction` decimal(18,4) DEFAULT NULL, '+
            '   `icms_rate` decimal(18,4) DEFAULT NULL, '+
            '   `icms_perc_of_own_operation_calc_base` decimal(18,4) DEFAULT NULL, '+
            '   `icms_deferral_perc` decimal(18,4) DEFAULT NULL, '+
            '   `icms_pst` decimal(18,4) DEFAULT NULL, '+
            '   `icms_coupon_rate` decimal(18,4) DEFAULT NULL, '+
            '   `icms_is_calc_base_with_insurance` tinyint DEFAULT NULL, '+
            '   `icms_is_calc_base_with_freight` tinyint DEFAULT NULL, '+
            '   `icms_is_calc_base_with_ipi` tinyint DEFAULT NULL, '+
            '   `icms_is_calc_base_with_other_expenses` tinyint DEFAULT NULL, '+
            '   `icmsst_calc_base_mode` tinyint DEFAULT NULL COMMENT ''Modalidade da base de cálculo do icmsst [0=PrecoTabelado, 1=ListaNegativa, 2=ListaPositiva, 3=ListaNeutra, 4=MargemValorAgregado, 5=Pauta, 6=ValordaOperacao]'', '+
            '   `icmsst_perc_of_calc_base_reduction` decimal(18,4) DEFAULT NULL, '+
            '   `icmsst_rate` decimal(18,4) DEFAULT NULL, '+
            '   `icmsst_interstate_rate` decimal(18,4) DEFAULT NULL, '+
            '   `icmsst_is_calc_base_with_insurance` tinyint DEFAULT NULL, '+
            '   `icmsst_is_calc_base_with_freight` tinyint DEFAULT NULL, '+
            '   `icmsst_is_calc_base_with_ipi` tinyint DEFAULT NULL, '+
            '   `icmsst_is_calc_base_with_other_expenses` tinyint DEFAULT NULL, '+
            '   `ipi_situation` tinyint DEFAULT NULL COMMENT ''Situação do ipi [0=ipi00, 1=ipi49, 2=ipi50, 3=ipi99, 4=ipi01, 5=ipi02, 6=ipi03, 7=ipi04, 8=ipi05, ipi51, ipi52, 9=ipi53, 10=ipi54, 11=ipi55]'', '+
            '   `ipi_rate` decimal(18,4) DEFAULT NULL, '+
            '   `pis_situation` tinyint NOT NULL COMMENT ''Situação do pis [0=pis01, 1=pis02, 2=pis03, 3=pis04, 4=pis05, 5=pis06, 6=pis07, 7=pis08, 8=pis09, 9=pis49, 10=pis50, 11=pis51, 12=pis52, 13=pis53,'+
            '    14=pis54, 15=pis55, 16=pis56, 17=pis60, 18=pis61, 19=pis62, 20=pis63, 21=pis64, 22=pis65, 23=pis66, 24=pis67, 25=pis70, 26=pis71, 27=pis72, 28=pis73, 29=pis74, 30=pis75, 31=pis98, 32=pis99]'', '+
            '   `pis_rate` decimal(18,4) DEFAULT NULL, '+
            '   `pisst_rate` decimal(18,4) DEFAULT NULL, '+
            '   `cofins_situation` tinyint NOT NULL COMMENT ''Situação do cofins [0=cof01, 1=cof02, 2=cof03, 3=cof04, 4=cof05, 5=cof06, 6=cof07, 7=cof08, 8=cof09, 9=cof49, 10cof50, 11=cof51, 12=cof52, 13=cof53,'+
            '    14=cof54, 15=cof55, 16=cof56, 17=cof60, 18=cof61, 19=cof62, 20=cof63, 21=cof64, 22=cof65, 23=cof66, 24=cof67, 25=cof70, 26=cof71, 27=cof72, 28=cof73, 29=cof74, 30=cof75, 31=cof98, 32=cof99]'', '+
            '   `cofins_rate` decimal(18,4) DEFAULT NULL, '+
            '   `cofinsst_rate` decimal(18,4) DEFAULT NULL, '+
            '   `taxpayer_note` text, '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `tax_rule_state_fk_tax_rule_id` (`tax_rule_id`), '+
            '   KEY `tax_rule_state_fk_cfop_id` (`cfop_id`), '+
            '   CONSTRAINT `tax_rule_state_fk_cfop_id` FOREIGN KEY (`cfop_id`) REFERENCES `cfop` (`id`), '+
            '   CONSTRAINT `tax_rule_state_fk_tax_rule_id` FOREIGN KEY (`tax_rule_id`) REFERENCES `tax_rule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE '+
            ' ) ';
end;

end.
