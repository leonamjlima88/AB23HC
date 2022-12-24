unit uBank.SQLBuilder.MySQL;

interface

uses
  uBank.SQLBuilder,
  uBank.SQLBuilder.Interfaces;

type
  TBankSQLBuilderMySQL = class(TBankSQLBuilder, IBankSQLBuilder)
  public
    constructor Create;
    class function Make: IBankSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces,
  System.Classes,
  uSmartPointer;

{ TBankSQLBuilderMySQL }

constructor TBankSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TBankSQLBuilderMySQL.Make: IBankSQLBuilder;
begin
  Result := Self.Create;
end;

function TBankSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result :=
    ' CREATE TABLE `bank` (                                                                                               '+
    '   `id` bigint(20) NOT NULL AUTO_INCREMENT,                                                                          '+
    '   `name` varchar(100) NOT NULL,                                                                                     '+
    '   `code` char(3) NOT NULL,                                                                                          '+
    '   `created_at` datetime DEFAULT NULL,                                                                               '+
    '   `updated_at` datetime DEFAULT NULL,                                                                               '+
    '   `created_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   PRIMARY KEY (`id`),                                                                                               '+
    '   KEY `bank_idx_name` (`name`),                                                                                     '+
    '   KEY `bank_fk_created_by_acl_user_id` (`created_by_acl_user_id`),                                                  '+
    '   KEY `bank_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`),                                                  '+
    '   CONSTRAINT `bank_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`),  '+
    '   CONSTRAINT `bank_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`)   '+
    ' )                                                                                                                   ';
end;

function TBankSQLBuilderMySQL.ScriptSeedTable: String;
var
  lStrList: Shared<TStringList>;
begin
  lStrList := TStringList.Create;
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''000 - CAIXA FUNDO FIXO'',''1'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''104 - CAIXA ECONOMICA FEDERAL'',''104'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''106 - BANCO ITABANCO S.A.'',''106'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''107 - BANCO BBM S.A'',''107'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''109 - BANCO CREDIBANCO S.A'',''109'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''116 - BANCO B.N.L DO BRASIL S.A'',''116'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''129 - UBS BRASIL BANCO DE INVESTIMENTO S.A.'',''129'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''148 - MULTI BANCO S.A'',''148'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''151 - CAIXA ECONOMICA DO ESTADO DE SAO PAULO'',''151'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''153 - CAIXA ECONOMICA DO ESTADO DO R.G.SUL'',''153'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''165 - BANCO NORCHEM S.A'',''165'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''166 - BANCO INTER-ATLANTICO S.A'',''166'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''168 - BANCO C.C.F. BRASIL S.A'',''168'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''175 - CONTINENTAL BANCO S.A'',''175'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''184 - BBA - CREDITANSTALT S.A'',''184'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''199 - BANCO FINANCIAL PORTUGUES'',''199'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''002 - BANCO CENTRAL DO BRASIL'',''2'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''020 - BANCO DO ESTADO DE ALAGOAS S.A'',''20'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''200 - BANCO FRICRISA AXELRUD S.A'',''200'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''201 - BANCO AUGUSTA INDUSTRIA E COMERCIAL S.A'',''201'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''204 - BANCO S.R.L S.A'',''204'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''205 - BANCO SUL AMERICA S.A'',''205'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''206 - BANCO MARTINELLI S.A'',''206'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''208 - BANCO PACTUAL S.A'',''208'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''021 - BANCO DO ESTADO DO ESPIRITO SANTO S.A'',''21'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''210 - DEUTSCH SUDAMERIKANICHE BANK AG'',''210'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''211 - BANCO SISTEMA S.A'',''211'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''212 - BANCO ORIGINAL S.A'',''212'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''213 - BANCO ARBI S.A'',''213'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''214 - BANCO DIBENS S.A'',''214'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''215 - BANCO AMERICA DO SUL S.A'',''215'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''216 - BANCO REGIONAL MALCON S.A'',''216'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''217 - BANCO AGROINVEST S.A'',''217'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''218 - BBS - BANCO BONSUCESSO S.A.'',''218'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''219 - BANCO DE CREDITO DE SAO PAULO S.A'',''219'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''022 - BANCO DE CREDITO REAL DE MINAS GERAIS SA'',''22'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''220 - BANCO CREFISUL'',''220'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''221 - BANCO GRAPHUS S.A'',''221'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''222 - BANCO AGF BRASIL S. A.'',''222'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''223 - BANCO INTERUNION S.A'',''223'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''224 - BANCO FIBRA S.A'',''224'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''225 - BANCO BRASCAN S.A'',''225'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''228 - BANCO ICATU S.A'',''228'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''229 - BANCO CRUZEIRO S.A'',''229'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''230 - BANCO BANDEIRANTES S.A'',''230'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''231 - BANCO BOAVISTA S.A'',''231'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''232 - BANCO INTERPART S.A'',''232'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''233 - BANCO MAPPIN S.A'',''233'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''234 - BANCO LAVRA S.A.'',''234'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''235 - BANCO LIBERAL S.A'',''235'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''236 - BANCO CAMBIAL S.A'',''236'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''237 - BANCO BRADESCO S.A'',''237'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''239 - BANCO BANCRED S.A'',''239'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''024 - BANCO DO ESTADO DE PERNAMBUCO'',''24'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''240 - BANCO DE CREDITO REAL DE MINAS GERAIS S.'',''240'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''241 - BANCO CLASSICO S.A'',''241'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''242 - BANCO EUROINVEST S.A'',''242'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''243 - BANCO STOCK S.A'',''243'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''244 - BANCO CIDADE S.A'',''244'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''245 - BANCO EMPRESARIAL S.A'',''245'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''246 - BANCO ABC ROMA S.A'',''246'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''247 - BANCO OMEGA S.A'',''247'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''249 - BANCO INVESTCRED S.A'',''249'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''025 - BANCO ALFA S/A'',''25'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''250 - BANCO SCHAHIN CURY S.A'',''250'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''251 - BANCO SAO JORGE S.A.'',''251'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''252 - BANCO FININVEST S.A'',''252'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''254 - BANCO PARANA BANCO S.A'',''254'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''255 - MILBANCO S.A.'',''255'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''256 - BANCO GULVINVEST S.A'',''256'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''258 - BANCO INDUSCRED S.A'',''258'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''026 - BANCO DO ESTADO DO ACRE S.A'',''26'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''260 - NU PAGAMENTOS S.A'',''260'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''261 - BANCO VARIG S.A'',''261'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''262 - BANCO BOREAL S.A'',''262'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''263 - BANCO CACIQUE'',''263'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''264 - BANCO PERFORMANCE S.A'',''264'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''265 - BANCO FATOR S.A'',''265'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''266 - BANCO CEDULA S.A'',''266'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''267 - BANCO BBM-COM.C.IMOB.CFI S.A.'',''267'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''027 - BANCO DO ESTADO DE SANTA CATARINA S.A'',''27'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''275 - BANCO REAL S.A'',''275'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''277 - BANCO PLANIBANC S.A'',''277'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''028 - BANCO DO ESTADO DA BAHIA S.A'',''28'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''282 - BANCO BRASILEIRO COMERCIAL'',''282'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''029 - BANCO DO ESTADO DO RIO DE JANEIRO S.A'',''29'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''291 - BANCO DE CREDITO NACIONAL S.A'',''291'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''294 - BCR - BANCO DE CREDITO REAL S.A'',''294'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''295 - BANCO CREDIPLAN S.A'',''295'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''003 - BANCO DA AMAZONIA S.A'',''3'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''030 - BANCO DO ESTADO DA PARAIBA S.A'',''30'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''300 - BANCO DE LA NACION ARGENTINA S.A'',''300'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''302 - BANCO DO PROGRESSO S.A'',''302'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''303 - BANCO HNF S.A.'',''303'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''304 - BANCO PONTUAL S.A'',''304'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''308 - BANCO COMERCIAL BANCESA S.A.'',''308'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''031 - BANCO DO ESTADO DE GOIAS S.A'',''31'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''318 - BANCO B.M.G. S.A'',''318'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''032 - BANCO DO ESTADO DO MATO GROSSO S.A.'',''32'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''320 - BANCO INDUSTRIAL E COMERCIAL'',''320'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''033 - BANCO DO ESTADO DE SAO PAULO S.A'',''33'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''034 - BANCO DO ESADO DO AMAZONAS S.A'',''34'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''341 - BANCO ITAU S.A'',''341'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''346 - BANCO FRANCES E BRASILEIRO S.A'',''346'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''347 - BANCO SUDAMERIS BRASIL S.A'',''347'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''035 - BANCO DO ESTADO DO CEARA S.A'',''35'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''351 - BANCO BOZANO SIMONSEN S.A'',''351'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''353 - BANCO GERAL DO COMERCIO S.A'',''353'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''356 - ABN AMRO S.A'',''356'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''036 - BANCO DO ESTADO DO MARANHAO S.A'',''36'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''366 - BANCO SOGERAL S.A'',''366'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''369 - PONTUAL'',''369'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''037 - BANCO DO ESTADO DO PARA S.A'',''37'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''370 - BEAL - BANCO EUROPEU PARA AMERICA LATINA'',''370'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''372 - BANCO ITAMARATI S.A'',''372'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''375 - BANCO FENICIA S.A'',''375'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''376 - CHASE MANHATTAN BANK S.A'',''376'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''038 - BANCO DO ESTADO DO PARANA S.A'',''38'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''388 - BANCO MERCANTIL DE DESCONTOS S/A'',''388'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''389 - BANCO MERCANTIL DO BRASIL S.A'',''389'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''039 - BANCO DO ESTADO DO PIAUI S.A'',''39'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''392 - BANCO MERCANTIL DE SAO PAULO S.A'',''392'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''394 - BANCO B.M.C. S.A'',''394'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''399 - HSBC BANK BRASIL S.A. – BANCO MÚLTIPLO'',''399'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''004 - BANCO DO NORDESTE DO BRASIL S.A'',''4'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''409 - UNIBANCO - UNIAO DOS BANCOS BRASILEIROS'',''409'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''041 - BANCO DO ESTADO DO RIO GRANDE DO SUL S.A'',''41'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''412 - BANCO NACIONAL DA BAHIA S.A'',''412'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''415 - BANCO NACIONAL S.A'',''415'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''420 - BANCO NACIONAL DO NORTE S.A'',''420'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''422 - BANCO SAFRA S.A'',''422'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''424 - BANCO NOROESTE S.A'',''424'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''434 - BANCO FORTALEZA S.A'',''434'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''453 - BANCO RURAL S.A'',''453'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''456 - BANCO TOKIO S.A'',''456'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''464 - BANCO SUMITOMO BRASILEIRO S.A'',''464'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''466 - BANCO MITSUBISHI BRASILEIRO S.A'',''466'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''047 - BANCO DO ESTADO DE SERGIPE S.A'',''47'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''472 - LLOYDS BANK PLC'',''472'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''473 - BANCO FINANCIAL PORTUGUES S.A'',''473'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''477 - CITIBANK N.A'',''477'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''479 - BANCO DE BOSTON S.A'',''479'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''048 - BANCO DO ESTADO DE MINAS GERAIS S.A'',''48'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''480 - BANCO PORTUGUES DO ATLANTICO-BRASIL S.A'',''480'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''483 - BANCO AGRIMISA S.A.'',''483'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''487 - DEUTSCHE BANK S.A - BANCO ALEMAO'',''487'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''488 - BANCO J. P. MORGAN S.A'',''488'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''489 - BANESTO BANCO URUGAUAY S.A'',''489'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''492 - INTERNATIONALE NEDERLANDEN BANK N.V.'',''492'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''493 - BANCO UNION S.A.C.A'',''493'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''494 - BANCO LA REP. ORIENTAL DEL URUGUAY'',''494'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''495 - BANCO LA PROVINCIA DE BUENOS AIRES'',''495'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''496 - BANCO EXTERIOR DE ESPANA S.A'',''496'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''498 - CENTRO HISPANO BANCO'',''498'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''499 - BANCO IOCHPE S.A'',''499'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''501 - BANCO BRASILEIRO IRAQUIANO S.A.'',''501'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''502 - BANCO SANTANDER S.A'',''502'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''504 - BANCO MULTIPLIC S.A'',''504'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''505 - BANCO GARANTIA S.A'',''505'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''059 - BANCO DO ESTADO DE RONDONIA S.A'',''59'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''600 - BANCO LUSO BRASILEIRO S.A'',''600'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''601 - BFC BANCO S.A.'',''601'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''602 - BANCO PATENTE S.A'',''602'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''604 - BANCO INDUSTRIAL DO BRASIL S.A'',''604'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''607 - BANCO SANTOS NEVES S.A'',''607'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''608 - BANCO OPEN S.A'',''608'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''610 - BANCO V.R. S.A'',''610'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''611 - BANCO PAULISTA S.A'',''611'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''612 - BANCO GUANABARA S.A'',''612'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''613 - BANCO PECUNIA S.A'',''613'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''616 - BANCO INTERPACIFICO S.A'',''616'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''617 - BANCO INVESTOR S.A.'',''617'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''618 - BANCO TENDENCIA S.A'',''618'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''621 - BANCO APLICAP S.A.'',''621'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''622 - BANCO DRACMA S.A'',''622'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''623 - BANCO PANAMERICANO S.A'',''623'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''624 - BANCO GENERAL MOTORS S.A'',''624'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''625 - BANCO ARAUCARIA S.A'',''625'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''626 - BANCO FICSA S.A'',''626'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''627 - BANCO DESTAK S.A'',''627'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''628 - BANCO CRITERIUM S.A'',''628'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''629 - BANCORP BANCO COML. E. DE INVESTMENTO'',''629'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''630 - BANCO INTERCAP S.A'',''630'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''633 - BANCO REDIMENTO S.A'',''633'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''634 - BANCO TRIANGULO S.A'',''634'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''635 - BANCO DO ESTADO DO AMAPA S.A'',''635'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''637 - BANCO SOFISA S.A'',''637'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''638 - BANCO PROSPER S.A'',''638'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''639 - BIG S.A. - BANCO IRMAOS GUIMARAES'',''639'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''640 - BANCO DE CREDITO METROPOLITANO S.A'',''640'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''641 - BANCO EXCEL ECONOMICO S/A'',''641'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''643 - BANCO SEGMENTO S.A'',''643'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''645 - BANCO DO ESTADO DE RORAIMA S.A'',''645'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''647 - BANCO MARKA S.A'',''647'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''648 - BANCO ATLANTIS S.A'',''648'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''649 - BANCO DIMENSAO S.A'',''649'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''650 - BANCO PEBB S.A'',''650'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''652 - ITAÚ UNIBANCO HOLDING S.A.'',''652'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''653 - BANCO INDUSVAL S.A'',''653'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''654 - BANCO A. J. RENNER S.A'',''654'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''655 - BANCO VOTORANTIM S.A.'',''655'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''656 - BANCO MATRIX S.A'',''656'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''657 - BANCO TECNICORP S.A'',''657'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''658 - BANCO PORTO REAL S.A'',''658'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''066 - BANCO MORGAN STANLEY S.A'',''66'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''007 - BANCO NAC DESENV. ECO. SOCIAL S.A'',''7'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''070 - BANCO DE BRASILIA S.A'',''70'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''702 - BANCO SANTOS S.A'',''702'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''705 - BANCO INVESTCORP S.A.'',''705'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''707 - BANCO DAYCOVAL S.A'',''707'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''711 - BANCO VETOR S.A.'',''711'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''713 - BANCO CINDAM S.A'',''713'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''715 - BANCO VEGA S.A'',''715'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''718 - BANCO OPERADOR S.A'',''718'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''719 - BANCO PRIMUS S.A'',''719'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''720 - BANCO MAXINVEST S.A'',''720'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''721 - BANCO CREDIBEL S.A'',''721'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''722 - BANCO INTERIOR DE SAO PAULO S.A'',''722'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''724 - BANCO PORTO SEGURO S.A'',''724'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''725 - BANCO FINABANCO S.A'',''725'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''726 - BANCO UNIVERSAL S.A'',''726'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''728 - BANCO FITAL S.A'',''728'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''729 - BANCO FONTE S.A'',''729'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''730 - BANCO COMERCIAL PARAGUAYO S.A'',''730'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''731 - BANCO GNPP S.A.'',''731'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''732 - BANCO PREMIER S.A.'',''732'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''733 - BANCO NACOES S.A.'',''733'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''734 - BANCO GERDAU S.A'',''734'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''735 - BACO POTENCIAL'',''735'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''736 - BANCO UNITED S.A'',''736'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''737 - THECA'',''737'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''738 - MARADA'',''738'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''739 - BGN'',''739'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''740 - BCN BARCLAYS'',''740'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''741 - BRP'',''741'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''742 - EQUATORIAL'',''742'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''743 - BANCO EMBLEMA S.A'',''743'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''744 - THE FIRST NATIONAL BANK OF BOSTON'',''744'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''745 - CITIBAN N.A.'',''745'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''746 - MODAL SA'',''746'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''747 - RAIBOBANK DO BRASIL'',''747'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''748 - SICREDI'',''748'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''749 - BRMSANTIL SA'',''749'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''750 - BANCO REPUBLIC NATIONAL OF NEW YORK (BRA'',''750'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''751 - DRESDNER BANK LATEINAMERIKA-BRASIL S/A'',''751'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''752 - BANCO BANQUE NATIONALE DE PARIS BRASIL S'',''752'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''753 - BANCO COMERCIAL URUGUAI S.A.'',''753'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''755 - BANCO MERRILL LYNCH S.A'',''755'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''756 - BANCO COOPERATIVO DO BRASIL S.A.'',''756'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''757 - BANCO KEB DO BRASIL S.A.'',''757'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''001 - BANCO DO BRASIL S/A'',''758'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''077 - BANCO DE INTER S.A'',''77'');');
  lStrList.Value.Add('INSERT INTO `bank` (`name`,`code`) VALUES (''008 - BANCO MERIDIONAL DO BRASIL'',''8'');');

  Result := lStrList.Value.Text;
end;

end.
