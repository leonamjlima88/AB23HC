unit uTaxRuleState.Types;

interface

type
  TTaxRuleStateIcmsRegime    = (icrtSimplesNacional, icrtSimplesExcessoReceita, icrtRegimeNormal);
  TTaxRuleStateIcmsSituation = // cst
                               (icst00, icst10, icst20, icst30, icst40, icst41, icst45, icst50, icst51,
                               icst60, icst70, icst80, icst81, icst90, icstPart10, icstPart90,
                               icstRep41, icstVazio, icstICMSOutraUF, icstICMSSN, icstRep60,
                               // csosn
                               icsosnVazio, icsosn101, icsosn102, icsosn103, icsosn201, icsosn202, icsosn203,
                               icsosn300, icsosn400, icsosn500, icsosn900);

  TTaxRuleStateIcmsOrigin = (ioeNacional, ioeEstrangeiraImportacaoDireta, ioeEstrangeiraAdquiridaBrasil,
                             ioeNacionalConteudoImportacaoSuperior40, ioeNacionalProcessosBasicos,
                             ioeNacionalConteudoImportacaoInferiorIgual40,
                             ioeEstrangeiraImportacaoDiretaSemSimilar, ioeEstrangeiraAdquiridaBrasilSemSimilar,
                             ioeNacionalConteudoImportacaoSuperior70, ioeReservadoParaUsoFuturo,
                             ioeVazio);

  TTaxRuleStateIcmsCalcBaseMode = (idbMargemValorAgregado, idbPauta, idbPrecoTabelado, idbValorOperacao, idbNenhum);

  TTaxRuleStateIcmsStCalcBaseMode = (isdbPrecoTabelado, isdbListaNegativa, isdbListaPositiva, isdbListaNeutra,
                                     isdbMargemValorAgregado, isdbPauta, isdbValordaOperacao);

  TTaxRuleStateIpiSituation = (xipi00, xipi49, xipi50, xipi99, xipi01, xipi02, xipi03, xipi04, xipi05, xipi51, xipi52,
                               xipi53, xipi54, xipi55);

  TTaxRuleStatePisSituation = (xpis01, xpis02, xpis03, xpis04, xpis05, xpis06, xpis07, xpis08, xpis09, xpis49, xpis50,
                               xpis51, xpis52, xpis53, xpis54, xpis55, xpis56, xpis60, xpis61, xpis62, xpis63, xpis64,
                               xpis65, xpis66, xpis67, xpis70, xpis71, xpis72, xpis73, xpis74, xpis75, xpis98, xpis99);

  TTaxRuleStateCofinsSituation = (xcof01, xcof02, xcof03, xcof04, xcof05, xcof06, xcof07, xcof08, xcof09, xcof49, xcof50,
                                  xcof51, xcof52, xcof53, xcof54, xcof55, xcof56, xcof60, xcof61, xcof62, xcof63, xcof64,
                                  xcof65, xcof66, xcof67, xcof70, xcof71, xcof72, xcof73, xcof74, xcof75, xcof98, xcof99);
implementation

end.

