inherited TaxRuleStateCreateUpdateView: TTaxRuleStateCreateUpdateView
  ClientHeight = 588
  ClientWidth = 1024
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 1024
  ExplicitHeight = 588
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBackground: TPanel
    Width = 1024
    Height = 588
    ExplicitWidth = 1024
    ExplicitHeight = 588
    inherited pnlBackground2: TPanel
      Width = 1022
      Height = 541
      ExplicitWidth = 1022
      ExplicitHeight = 541
      inherited imgNoSearch: TSkAnimatedImage
        Width = 922
        Height = 391
        ExplicitWidth = 922
        ExplicitHeight = 391
      end
      inherited pnlBottomButtons: TPanel
        Top = 491
        Width = 1002
        ExplicitTop = 491
        ExplicitWidth = 1002
        inherited pnlSave: TPanel
          Left = 832
          ExplicitLeft = 832
          inherited pnlSave2: TPanel
            inherited btnSave: TSpeedButton
              Caption = 'Confirmar (F6)'
              OnClick = btnSaveClick
            end
            inherited pnlSave3: TPanel
              inherited imgSave: TImage
                ExplicitLeft = -7
                ExplicitTop = 4
              end
              inherited IndicatorLoadButtonSave: TActivityIndicator
                ExplicitWidth = 24
                ExplicitHeight = 24
              end
            end
          end
        end
        inherited pnlCancel: TPanel
          Left = 652
          ExplicitLeft = 652
          inherited pnlCancel2: TPanel
            inherited btnCancel: TSpeedButton
              Caption = 'Voltar (Esc)'
              OnClick = btnCancelClick
              ExplicitLeft = 38
            end
          end
        end
      end
      inherited pgc: TPageControl
        Width = 1002
        Height = 471
        ExplicitWidth = 1002
        ExplicitHeight = 471
        inherited tabMain: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 25
          ExplicitWidth = 994
          ExplicitHeight = 442
          inherited pnlMain: TPanel
            Width = 994
            Height = 442
            ExplicitWidth = 994
            ExplicitHeight = 442
            object Panel5: TPanel
              Left = 0
              Top = 0
              Width = 994
              Height = 45
              Align = alTop
              BevelOuter = bvNone
              Color = 16579576
              ParentBackground = False
              TabOrder = 0
              object Label1: TLabel
                Left = 10
                Top = 13
                Width = 55
                Height = 18
                Caption = 'Estado:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 8747344
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Label3: TLabel
                Left = 430
                Top = 13
                Width = 79
                Height = 18
                Caption = 'F1 - CFOP:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 8747344
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object btnLocaCFOP: TImage
                Left = 513
                Top = 9
                Width = 26
                Height = 26
                Cursor = crHandPoint
                AutoSize = True
                ParentShowHint = False
                Picture.Data = {
                  0954506E67496D61676589504E470D0A1A0A0000000D494844520000001A0000
                  001A0806000000A94A4CCE000000017352474200AECE1CE90000000467414D41
                  0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000003
                  994944415478DAB595594C53511086FF5A45101559B5AC820822828A0A06EA4E
                  1AA5B821AE10E14151134DDC42823EF9AA6F1A9790E01E97A046101010151115
                  F72094562594B2238B96CD425BEA9C1325C1B214B1939CA4F7DE73FBCD99FF9F
                  B9828843C7C300DCA0E50EF3849A568C80402A3342FA600C64303384C7884063
                  85424CB5B3C50C1711DCA63A4248D7ED9D5D78AFF88ADAA666E87B7B470F72B0
                  990C49C802448406C376F224A3E76F640A24A765A1BEB9F5DF419ECED3102F95
                  60A19F0F7AB43A34B67E47794D2DBA34DDF0A2D379398B30DE621CEA9A5B7039
                  33176F659FD1A3D38D0C24B2B743EC9A702C0F0A84AAE11BEE3C2E40914CCE21
                  93265841A7D7C3DBCD05B1AB57C16FBA3BD41D1D3876FE12AA1B9B4C07098563
                  101A301B87B66D420D697033F7295E9594F167FE5E1E3C011169763DFB31CA94
                  2A1CDE118D5904CB2C2CC2D5AC3C746A34A681D869B6842FC3927901487FFE12
                  B71EE5F3D2B1986865C9EF47AD10C38E34BB702F031D5D3F111F29813DE9B9EF
                  E469347D579B06F2F570C59E8D91B0B2B0C095AC47282A951BED611AED8F5E07
                  8D568B8B0FB291B0410A7F4F0F249E49864255D3E7C42141F37DBC7124261A55
                  A44DF2FD4C54D6370EB86FF7FA08F8B8BBE0FCDD0C2AE74A2CF2F3C5A9EBA93C
                  B13FA6181214E8ED89835BA3F083044E49CF864CA91AD43496E43AAD4ECF130B
                  0BF4C7B93BE9C8FFF009DD74D261412C4B560A1B6B6B5C23C10B3E7E1ACAA070
                  B29B82A49DDBE83DD79195CED1D60651CBC5BC49738ADEE1DAC33CB493E08385
                  343484CCB3149A1E2D92CEA5A0B5ADDD3433709D7CBD9118BB99DCA647EA9302
                  649075078A45B37DB08BB4727174A05E7B86DB7905F8D9DD6D1A88D97B33D95B
                  121C04814040CDD889C2E2523C7CF516CABA06BE8759593C770E22C5211039D8
                  E39DFC0BCEA6A6A1E987BADF7F0D0A62B36D0775FB1FC8DFC1A06C3AD84CB486
                  95E578B01D2F28895B79F9DC9DBDBD86E1410C12BD6A29D68A17F36BB6415159
                  05B9B20A73677A6186AB73DF5E83C1C047131BAA192F5EA345DD3660758C402C
                  C3ED9215FD20B28A4A6EEF2F5535BF4D32056E4E0E040199A38B3E112DFDF418
                  16644D63252E4202695830BFD6D3C064166513B96C881E3225FA40ECA3C61AF4
                  44421CC69026EC6679752D2E3DC8417179C5A820FD404C700F9113CE1E3DC09B
                  ACA2B61E2934BB4ACA95A38618958E9D8A8DF99924B69CC457A8AAFF0BC40864
                  CE602036C002CCCC2964203FFA718A96D40C00D654C5B4F6FE02AF7E9CB877DE
                  498A0000000049454E44AE426082}
                ShowHint = False
                OnClick = btnLocaCFOPClick
              end
              object edtcfop_id: TDBEdit
                Tag = 1
                Left = 540
                Top = 9
                Width = 40
                Height = 26
                CharCase = ecUpperCase
                Color = clWhite
                DataField = 'cfop_id'
                DataSource = dtsTaxRuleState
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                TabOrder = 1
                OnClick = EdtFieldClick
                OnEnter = EdtFieldEnter
                OnExit = EdtFieldExit
                OnKeyDown = EdtFieldKeyDown
              end
              object edtcfop_code: TDBEdit
                Tag = 1
                Left = 581
                Top = 9
                Width = 60
                Height = 26
                Color = clWhite
                DataField = 'cfop_code'
                DataSource = dtsTaxRuleState
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGray
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 2
                OnExit = EdtFieldExit
                OnKeyDown = EdtFieldKeyDown
              end
              object cbxtarget_state: TDBComboBox
                Left = 69
                Top = 10
                Width = 352
                Height = 26
                CharCase = ecUpperCase
                DataField = 'target_state'
                DataSource = dtsTaxRuleState
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnEnter = EdtFieldEnter
                OnExit = EdtFieldExit
                OnKeyDown = EdtFieldKeyDown
              end
              object edtcfop_name: TDBEdit
                Tag = 1
                Left = 642
                Top = 9
                Width = 342
                Height = 26
                Color = clWhite
                DataField = 'cfop_name'
                DataSource = dtsTaxRuleState
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clGray
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = []
                ParentFont = False
                ReadOnly = True
                TabOrder = 3
                OnExit = EdtFieldExit
                OnKeyDown = EdtFieldKeyDown
              end
            end
            object pgc2: TPageControl
              Tag = 1
              Left = 0
              Top = 45
              Width = 994
              Height = 397
              ActivePage = TabSheet3
              Align = alClient
              TabOrder = 1
              object TabSheet3: TTabSheet
                Caption = '     ICMS     '
                object pnlICMSConteudo: TPanel
                  Left = 0
                  Top = 0
                  Width = 986
                  Height = 368
                  Align = alClient
                  BevelOuter = bvNone
                  Color = 16579576
                  ParentBackground = False
                  TabOrder = 0
                  object lblICMS_ALIQ_APLIC_CALC_CREDITO: TLabel
                    Tag = 2
                    Left = 9
                    Top = 109
                    Width = 184
                    Height = 13
                    Caption = 'Al'#237'quota aplic'#225'vel de c'#225'lculo do cr'#233'dito'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lblICMS_CRED_APROVEITADO_XPERC: TLabel
                    Tag = 2
                    Left = 9
                    Top = 135
                    Width = 227
                    Height = 13
                    Caption = 'Cr'#233'dito do ICMS que pode ser aproveitado (%)'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    Visible = False
                  end
                  object lblicms_pst: TLabel
                    Tag = 2
                    Left = 509
                    Top = 107
                    Width = 194
                    Height = 13
                    Caption = 'Al'#237'quota suportada pelo consumidor final'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lblicms_aliqcfiscal: TLabel
                    Tag = 2
                    Left = 509
                    Top = 133
                    Width = 113
                    Height = 13
                    Caption = 'Al'#237'q. ICMS do ECF/SAT:'
                    Color = clBlack
                    Font.Charset = ANSI_CHARSET
                    Font.Color = clBlack
                    Font.Height = -11
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentColor = False
                    ParentFont = False
                    Transparent = True
                  end
                  object pnlICMSTopo: TPanel
                    Left = 0
                    Top = 0
                    Width = 986
                    Height = 98
                    Align = alTop
                    BevelOuter = bvNone
                    Color = 16579576
                    ParentBackground = False
                    TabOrder = 4
                    object Label41: TLabel
                      Left = 243
                      Top = 5
                      Width = 117
                      Height = 16
                      Caption = '*Situa'#231#227'o Tribut'#225'ria'
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -13
                      Font.Name = 'Tahoma'
                      Font.Style = []
                      ParentFont = False
                    end
                    object Label42: TLabel
                      Left = 9
                      Top = 51
                      Width = 50
                      Height = 16
                      Caption = '*Origem'
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -13
                      Font.Name = 'Tahoma'
                      Font.Style = []
                      ParentFont = False
                    end
                    object Label43: TLabel
                      Left = 9
                      Top = 5
                      Width = 51
                      Height = 16
                      Caption = '*Regime'
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -13
                      Font.Name = 'Tahoma'
                      Font.Style = []
                      ParentFont = False
                    end
                    object cbxicms_situation: TJvDBComboBox
                      Tag = 1
                      Left = 243
                      Top = 21
                      Width = 738
                      Height = 24
                      DataField = 'icms_situation'
                      DataSource = dtsTaxRuleState
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -13
                      Font.Name = 'Tahoma'
                      Font.Style = []
                      Items.Strings = (
                        'cst00'
                        'cst10'
                        'cst20'
                        'cst30'
                        'cst40'
                        'cst41'
                        'cst45'
                        'cst50'
                        'cst51'
                        'cst60'
                        'cst70'
                        'cst80'
                        'cst81'
                        'cst90'
                        'cstPart10'
                        'cstPart90'
                        'cstRep41'
                        'cstVazio'
                        'cstICMSOutraUF'
                        'cstICMSSN'
                        'cstRep60'
                        'csosnVazio'
                        'csosn101'
                        'csosn102'
                        'csosn103'
                        'csosn201'
                        'csosn202'
                        'csosn203'
                        'csosn300'
                        'csosn400'
                        'csosn500'
                        'csosn900')
                      ParentFont = False
                      TabOrder = 1
                      Values.Strings = (
                        '0'
                        '1'
                        '2'
                        '3'
                        '4'
                        '5'
                        '6'
                        '7'
                        '8'
                        '9'
                        '10'
                        '11'
                        '12'
                        '13'
                        '14'
                        '15'
                        '16'
                        '17'
                        '18'
                        '19'
                        '20'
                        '21'
                        '22'
                        '23'
                        '24'
                        '25'
                        '26'
                        '27'
                        '28'
                        '29'
                        '30'
                        '31')
                      ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
                      ListSettings.OutfilteredValueFont.Color = clRed
                      ListSettings.OutfilteredValueFont.Height = -11
                      ListSettings.OutfilteredValueFont.Name = 'Tahoma'
                      ListSettings.OutfilteredValueFont.Style = []
                      OnEnter = EdtFieldEnter
                      OnExit = EdtFieldExit
                      OnKeyDown = EdtFieldKeyDown
                    end
                    object cbxicms_origin: TJvDBComboBox
                      Tag = 1
                      Left = 9
                      Top = 67
                      Width = 972
                      Height = 24
                      DataField = 'icms_origin'
                      DataSource = dtsTaxRuleState
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -13
                      Font.Name = 'Tahoma'
                      Font.Style = []
                      Items.Strings = (
                        'Nacional'
                        'EstrangeiraImportacaoDireta'
                        'EstrangeiraAdquiridaBrasil'
                        'NacionalConteudoImportacaoSuperior40'
                        'NacionalProcessosBasicos'
                        'NacionalConteudoImportacaoInferiorIgual40'
                        'EstrangeiraImportacaoDiretaSemSimilar'
                        'EstrangeiraAdquiridaBrasilSemSimilar'
                        'NacionalConteudoImportacaoSuperior70'
                        'ReservadoParaUsoFuturo'
                        'Vazio')
                      ParentFont = False
                      TabOrder = 2
                      Values.Strings = (
                        '0'
                        '1'
                        '2'
                        '3'
                        '4'
                        '5'
                        '6'
                        '7'
                        '8'
                        '9'
                        '10')
                      ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
                      ListSettings.OutfilteredValueFont.Color = clRed
                      ListSettings.OutfilteredValueFont.Height = -11
                      ListSettings.OutfilteredValueFont.Name = 'Tahoma'
                      ListSettings.OutfilteredValueFont.Style = []
                      OnEnter = EdtFieldEnter
                      OnExit = EdtFieldExit
                      OnKeyDown = EdtFieldKeyDown
                    end
                    object cbxicms_regime: TJvDBComboBox
                      Tag = 1
                      Left = 9
                      Top = 21
                      Width = 224
                      Height = 24
                      DataField = 'icms_regime'
                      DataSource = dtsTaxRuleState
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = clWindowText
                      Font.Height = -13
                      Font.Name = 'Tahoma'
                      Font.Style = []
                      Items.Strings = (
                        'Simples Nacional'
                        'Simples Excesso Receita'
                        'Regime Normal')
                      ParentFont = False
                      TabOrder = 0
                      Values.Strings = (
                        '0'
                        '1'
                        '2')
                      ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
                      ListSettings.OutfilteredValueFont.Color = clRed
                      ListSettings.OutfilteredValueFont.Height = -11
                      ListSettings.OutfilteredValueFont.Name = 'Tahoma'
                      ListSettings.OutfilteredValueFont.Style = []
                      OnEnter = EdtFieldEnter
                      OnExit = EdtFieldExit
                      OnKeyDown = EdtFieldKeyDown
                    end
                  end
                  object edticms_applicable_credit_calc_rate: TDBEdit
                    Tag = 2
                    Left = 248
                    Top = 104
                    Width = 251
                    Height = 24
                    DataField = 'icms_applicable_credit_calc_rate'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                    OnClick = EdtFieldClick
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                    OnKeyDown = EdtFieldKeyDown
                  end
                  object edticms_perc_of_used_credit: TDBEdit
                    Tag = 2
                    Left = 248
                    Top = 130
                    Width = 251
                    Height = 24
                    DataField = 'icms_perc_of_used_credit'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                    Visible = False
                    OnClick = EdtFieldClick
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                    OnKeyDown = EdtFieldKeyDown
                  end
                  object edticms_pst: TDBEdit
                    Tag = 2
                    Left = 730
                    Top = 104
                    Width = 251
                    Height = 24
                    DataField = 'icms_pst'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 2
                    OnClick = EdtFieldClick
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                    OnKeyDown = EdtFieldKeyDown
                  end
                  object Panel72: TPanel
                    Left = 9
                    Top = 164
                    Width = 490
                    Height = 196
                    BevelOuter = bvNone
                    BorderWidth = 2
                    Color = 14209726
                    ParentBackground = False
                    TabOrder = 5
                    object Panel73: TPanel
                      Left = 2
                      Top = 2
                      Width = 486
                      Height = 20
                      Align = alTop
                      Alignment = taLeftJustify
                      BevelOuter = bvNone
                      Caption = ' ICMS'
                      Color = 14209726
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = 8747344
                      Font.Height = -13
                      Font.Name = 'Tahoma'
                      Font.Style = [fsBold]
                      ParentBackground = False
                      ParentFont = False
                      TabOrder = 0
                    end
                    object Panel74: TPanel
                      Left = 2
                      Top = 22
                      Width = 486
                      Height = 172
                      Align = alClient
                      BevelOuter = bvNone
                      Color = 16250354
                      ParentBackground = False
                      TabOrder = 1
                      object lblICMS_MODBC: TLabel
                        Tag = 2
                        Left = 10
                        Top = 10
                        Width = 155
                        Height = 13
                        Caption = 'Modalid. de determ. da BC ICMS'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                      end
                      object lblicms_perc_red_bc: TLabel
                        Tag = 2
                        Left = 10
                        Top = 36
                        Width = 115
                        Height = 13
                        Caption = '% Redu'#231#227'o da BC ICMS'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                      end
                      object lblicms_aliq: TLabel
                        Tag = 2
                        Left = 10
                        Top = 91
                        Width = 96
                        Height = 13
                        Caption = '% Al'#237'quota do ICMS'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                      end
                      object lblicms_perc_bc_oper_propria: TLabel
                        Tag = 2
                        Left = 10
                        Top = 117
                        Width = 127
                        Height = 13
                        Caption = '% BC da opera'#231#227'o pr'#243'pria'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                      end
                      object lblicms_bc_add: TLabel
                        Tag = 2
                        Left = 10
                        Top = 63
                        Width = 177
                        Height = 13
                        Caption = 'Adicionar valores em Base de C'#225'lculo'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                      end
                      object lblicms_diferimento_perc: TLabel
                        Tag = 2
                        Left = 10
                        Top = 143
                        Width = 84
                        Height = 13
                        Caption = '% do Diferimento'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                      end
                      object cbxicms_calc_base_mode: TJvDBComboBox
                        Tag = 2
                        Left = 237
                        Top = 5
                        Width = 244
                        Height = 24
                        DataField = 'icms_calc_base_mode'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -13
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        Items.Strings = (
                          'MargemValorAgregado'
                          'Pauta'
                          'PrecoTabelado'
                          'ValorOperacao'
                          'Nenhum')
                        ParentFont = False
                        TabOrder = 0
                        Values.Strings = (
                          '0'
                          '1'
                          '2'
                          '3'
                          '4')
                        ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
                        ListSettings.OutfilteredValueFont.Color = clRed
                        ListSettings.OutfilteredValueFont.Height = -11
                        ListSettings.OutfilteredValueFont.Name = 'Tahoma'
                        ListSettings.OutfilteredValueFont.Style = []
                        OnEnter = EdtFieldEnter
                        OnExit = EdtFieldExit
                        OnKeyDown = EdtFieldKeyDown
                      end
                      object edticms_perc_of_calc_base_reduction: TDBEdit
                        Tag = 2
                        Left = 237
                        Top = 31
                        Width = 244
                        Height = 24
                        DataField = 'icms_perc_of_calc_base_reduction'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -13
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 1
                        OnClick = EdtFieldClick
                        OnEnter = EdtFieldEnter
                        OnExit = EdtFieldExit
                        OnKeyDown = EdtFieldKeyDown
                      end
                      object edticms_rate: TDBEdit
                        Tag = 2
                        Left = 237
                        Top = 86
                        Width = 244
                        Height = 24
                        DataField = 'icms_rate'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -13
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 6
                        OnClick = EdtFieldClick
                        OnEnter = EdtFieldEnter
                        OnExit = EdtFieldExit
                        OnKeyDown = EdtFieldKeyDown
                      end
                      object edticms_perc_of_own_operation_calc_base: TDBEdit
                        Tag = 2
                        Left = 237
                        Top = 112
                        Width = 244
                        Height = 24
                        DataField = 'icms_perc_of_own_operation_calc_base'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -13
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 7
                        OnClick = EdtFieldClick
                        OnEnter = EdtFieldEnter
                        OnExit = EdtFieldExit
                        OnKeyDown = EdtFieldKeyDown
                      end
                      object chkicms_is_calc_base_with_insurance: TDBCheckBox
                        Tag = 2
                        Left = 237
                        Top = 62
                        Width = 49
                        Height = 17
                        TabStop = False
                        Caption = 'Seguro'
                        DataField = 'icms_is_calc_base_with_insurance'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 2
                        ValueChecked = '1'
                        ValueUnchecked = '0'
                      end
                      object chkicms_is_calc_base_with_freight: TDBCheckBox
                        Tag = 2
                        Left = 300
                        Top = 62
                        Width = 41
                        Height = 17
                        TabStop = False
                        Caption = 'Frete'
                        DataField = 'icms_is_calc_base_with_freight'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 3
                        ValueChecked = '1'
                        ValueUnchecked = '0'
                      end
                      object chkicms_is_calc_base_with_other_expenses: TDBCheckBox
                        Tag = 2
                        Left = 358
                        Top = 62
                        Width = 78
                        Height = 17
                        TabStop = False
                        Caption = 'Outras Desp.'
                        DataField = 'icms_is_calc_base_with_other_expenses'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 4
                        ValueChecked = '1'
                        ValueUnchecked = '0'
                      end
                      object chkicms_is_calc_base_with_ipi: TDBCheckBox
                        Tag = 2
                        Left = 449
                        Top = 62
                        Width = 32
                        Height = 17
                        TabStop = False
                        Caption = 'IPI'
                        DataField = 'icms_is_calc_base_with_ipi'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 5
                        ValueChecked = '1'
                        ValueUnchecked = '0'
                      end
                      object edticms_deferral_perc: TDBEdit
                        Tag = 2
                        Left = 237
                        Top = 138
                        Width = 244
                        Height = 24
                        DataField = 'icms_deferral_perc'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -13
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 8
                        OnClick = EdtFieldClick
                        OnEnter = EdtFieldEnter
                        OnExit = EdtFieldExit
                        OnKeyDown = EdtFieldKeyDown
                      end
                    end
                  end
                  object Panel39: TPanel
                    Left = 509
                    Top = 164
                    Width = 472
                    Height = 196
                    BevelOuter = bvNone
                    BorderWidth = 2
                    Color = 14209726
                    ParentBackground = False
                    TabOrder = 6
                    object Panel40: TPanel
                      Left = 2
                      Top = 2
                      Width = 468
                      Height = 20
                      Align = alTop
                      Alignment = taLeftJustify
                      BevelOuter = bvNone
                      Caption = ' ICMS ST'
                      Color = 14209726
                      Font.Charset = DEFAULT_CHARSET
                      Font.Color = 8747344
                      Font.Height = -13
                      Font.Name = 'Tahoma'
                      Font.Style = [fsBold]
                      ParentBackground = False
                      ParentFont = False
                      TabOrder = 0
                    end
                    object Panel41: TPanel
                      Left = 2
                      Top = 22
                      Width = 468
                      Height = 172
                      Align = alClient
                      BevelOuter = bvNone
                      Color = 16250354
                      ParentBackground = False
                      TabOrder = 1
                      object lblicmsst_modbc: TLabel
                        Tag = 2
                        Left = 8
                        Top = 10
                        Width = 179
                        Height = 13
                        Caption = '* Modalid. de determ. da BC ICMS ST'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                      end
                      object lblicmsst_perc_red_bc: TLabel
                        Tag = 2
                        Left = 8
                        Top = 36
                        Width = 130
                        Height = 13
                        Caption = '% Redu'#231#227'o da BC ICMS ST'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                      end
                      object lblicmsst_aliq: TLabel
                        Tag = 2
                        Left = 8
                        Top = 91
                        Width = 189
                        Height = 13
                        Caption = '% Al'#237'quota INTRA estadual do ICMS ST'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                      end
                      object lblicmsst_bc_add: TLabel
                        Tag = 2
                        Left = 8
                        Top = 63
                        Width = 177
                        Height = 13
                        Caption = 'Adicionar valores em Base de C'#225'lculo'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                      end
                      object lblicmsst_aliq_inter: TLabel
                        Tag = 2
                        Left = 8
                        Top = 117
                        Width = 188
                        Height = 13
                        Caption = '% Al'#237'quota INTER estadual do ICMS ST'
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                      end
                      object cbxicmsst_calc_base_mode: TJvDBComboBox
                        Tag = 2
                        Left = 219
                        Top = 5
                        Width = 244
                        Height = 24
                        DataField = 'icmsst_calc_base_mode'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -13
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        Items.Strings = (
                          'PrecoTabelado'
                          'ListaNegativa'
                          'ListaPositiva'
                          'ListaNeutra'
                          'MargemValorAgregado'
                          'Pauta'
                          'ValordaOperacao')
                        ParentFont = False
                        TabOrder = 0
                        Values.Strings = (
                          '0'
                          '1'
                          '2'
                          '3'
                          '4'
                          '5'
                          '6')
                        ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
                        ListSettings.OutfilteredValueFont.Color = clRed
                        ListSettings.OutfilteredValueFont.Height = -11
                        ListSettings.OutfilteredValueFont.Name = 'Tahoma'
                        ListSettings.OutfilteredValueFont.Style = []
                        OnEnter = EdtFieldEnter
                        OnExit = EdtFieldExit
                        OnKeyDown = EdtFieldKeyDown
                      end
                      object edticmsst_perc_of_calc_base_reduction: TDBEdit
                        Tag = 2
                        Left = 219
                        Top = 31
                        Width = 244
                        Height = 24
                        DataField = 'icmsst_perc_of_calc_base_reduction'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -13
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 1
                        OnClick = EdtFieldClick
                        OnEnter = EdtFieldEnter
                        OnExit = EdtFieldExit
                        OnKeyDown = EdtFieldKeyDown
                      end
                      object edticmsst_rate: TDBEdit
                        Tag = 2
                        Left = 219
                        Top = 86
                        Width = 244
                        Height = 24
                        DataField = 'icmsst_rate'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -13
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 6
                        OnClick = EdtFieldClick
                        OnEnter = EdtFieldEnter
                        OnExit = EdtFieldExit
                        OnKeyDown = EdtFieldKeyDown
                      end
                      object chkicmsst_is_calc_base_with_insurance: TDBCheckBox
                        Tag = 2
                        Left = 219
                        Top = 62
                        Width = 49
                        Height = 17
                        TabStop = False
                        Caption = 'Seguro'
                        DataField = 'icmsst_is_calc_base_with_insurance'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 2
                        ValueChecked = '1'
                        ValueUnchecked = '0'
                      end
                      object chkicmsst_is_calc_base_with_freight: TDBCheckBox
                        Tag = 2
                        Left = 282
                        Top = 62
                        Width = 41
                        Height = 17
                        TabStop = False
                        Caption = 'Frete'
                        DataField = 'icmsst_is_calc_base_with_freight'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 3
                        ValueChecked = '1'
                        ValueUnchecked = '0'
                      end
                      object chkicmsst_is_calc_base_with_other_expenses: TDBCheckBox
                        Tag = 2
                        Left = 338
                        Top = 62
                        Width = 78
                        Height = 17
                        TabStop = False
                        Caption = 'Outras Desp.'
                        DataField = 'icmsst_is_calc_base_with_other_expenses'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 4
                        ValueChecked = '1'
                        ValueUnchecked = '0'
                      end
                      object chkicmsst_is_calc_base_with_ipi: TDBCheckBox
                        Tag = 2
                        Left = 431
                        Top = 62
                        Width = 32
                        Height = 17
                        TabStop = False
                        Caption = 'IPI'
                        DataField = 'icmsst_is_calc_base_with_ipi'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -11
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 5
                        ValueChecked = '1'
                        ValueUnchecked = '0'
                      end
                      object edticmsst_interstate_rate: TDBEdit
                        Tag = 2
                        Left = 219
                        Top = 112
                        Width = 244
                        Height = 24
                        DataField = 'icmsst_interstate_rate'
                        DataSource = dtsTaxRuleState
                        Font.Charset = DEFAULT_CHARSET
                        Font.Color = clWindowText
                        Font.Height = -13
                        Font.Name = 'Tahoma'
                        Font.Style = []
                        ParentFont = False
                        TabOrder = 7
                        OnClick = EdtFieldClick
                        OnEnter = EdtFieldEnter
                        OnExit = EdtFieldExit
                        OnKeyDown = EdtFieldKeyDown
                      end
                    end
                  end
                  object cbxicms_coupon_rate: TJvDBComboBox
                    Tag = 2
                    Left = 730
                    Top = 130
                    Width = 251
                    Height = 24
                    Color = clWhite
                    DataField = 'icms_coupon_rate'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    Items.Strings = (
                      'II   = ISENTO'
                      'NN   = NAO INCIDENCIA'
                      'FF   = SUBST. TRIBUTARIA'
                      '1,25'
                      '1,86'
                      '4,00'
                      '7,00'
                      '12,00'
                      '18,00'
                      '25,00')
                    ParentFont = False
                    TabOrder = 3
                    ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
                    ListSettings.OutfilteredValueFont.Color = clRed
                    ListSettings.OutfilteredValueFont.Height = -11
                    ListSettings.OutfilteredValueFont.Name = 'Tahoma'
                    ListSettings.OutfilteredValueFont.Style = []
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                    OnKeyDown = EdtFieldKeyDown
                  end
                end
              end
              object TabSheet4: TTabSheet
                Caption = '     IPI     '
                ImageIndex = 1
                object pnlIPI: TPanel
                  Left = 0
                  Top = 0
                  Width = 986
                  Height = 368
                  Align = alClient
                  BevelOuter = bvNone
                  BorderWidth = 10
                  Color = 16579576
                  ParentBackground = False
                  TabOrder = 0
                  object Label48: TLabel
                    Left = 9
                    Top = 10
                    Width = 113
                    Height = 16
                    Caption = '*Situa'#231#227'o Tribut'#225'ria'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Arial'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lblipi_aliq_perc: TLabel
                    Left = 9
                    Top = 66
                    Width = 62
                    Height = 16
                    Caption = '% Al'#237'quota'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                  end
                  object cbxipi_situation: TJvDBComboBox
                    Tag = 1
                    Left = 9
                    Top = 27
                    Width = 967
                    Height = 26
                    DataField = 'ipi_situation'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    Items.Strings = (
                      'ipi00'
                      'ipi49'
                      'ipi50'
                      'ipi99'
                      'ipi01 '
                      'ipi02 '
                      'ipi03 '
                      'ipi04 '
                      'ipi05 '
                      'ipi51'
                      'ipi52 '
                      'ipi53 '
                      'ipi54 '
                      'ipi55')
                    ParentFont = False
                    TabOrder = 0
                    Values.Strings = (
                      '0'
                      '1'
                      '2'
                      '3'
                      '4'
                      '5'
                      '6'
                      '7'
                      '8'
                      '9'
                      '10'
                      '11'
                      '12'
                      '13')
                    ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
                    ListSettings.OutfilteredValueFont.Color = clRed
                    ListSettings.OutfilteredValueFont.Height = -11
                    ListSettings.OutfilteredValueFont.Name = 'Tahoma'
                    ListSettings.OutfilteredValueFont.Style = []
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                    OnKeyDown = EdtFieldKeyDown
                  end
                  object edtipi_rate: TDBEdit
                    Left = 81
                    Top = 63
                    Width = 242
                    Height = 24
                    DataField = 'ipi_rate'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 1
                    OnClick = EdtFieldClick
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                    OnKeyDown = EdtFieldKeyDown
                  end
                end
              end
              object TabSheet5: TTabSheet
                Caption = '     PIS     '
                ImageIndex = 2
                object pnlPIS: TPanel
                  Left = 0
                  Top = 0
                  Width = 986
                  Height = 368
                  Align = alClient
                  BevelOuter = bvNone
                  BorderWidth = 10
                  Color = 16579576
                  ParentBackground = False
                  TabOrder = 0
                  object Label52: TLabel
                    Left = 9
                    Top = 35
                    Width = 117
                    Height = 16
                    Caption = '*Situa'#231#227'o Tribut'#225'ria'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lblpis_aliq_perc: TLabel
                    Left = 9
                    Top = 86
                    Width = 62
                    Height = 16
                    Caption = '% Al'#237'quota'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lblpisst_aliq_perc: TLabel
                    Left = 9
                    Top = 155
                    Width = 62
                    Height = 16
                    Caption = '% Al'#237'quota'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                  end
                  object cbxpis_situation: TJvDBComboBox
                    Tag = 1
                    Left = 9
                    Top = 52
                    Width = 967
                    Height = 26
                    DataField = 'pis_situation'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    Items.Strings = (
                      'pis01'
                      'pis02'
                      'pis03'
                      'pis04'
                      'pis05'
                      'pis06'
                      'pis07'
                      'pis08'
                      'pis09'
                      'pis49'
                      'pis50'
                      'pis51'
                      'pis52'
                      'pis53'
                      'pis54'
                      'pis55'
                      'pis56'
                      'pis60'
                      'pis61'
                      'pis62'
                      'pis63'
                      'pis64'
                      'pis65'
                      'pis66'
                      'pis67'
                      'pis70'
                      'pis71'
                      'pis72'
                      'pis73'
                      'pis74'
                      'pis75'
                      'pis98'
                      'pis99')
                    ParentFont = False
                    TabOrder = 0
                    Values.Strings = (
                      '0'
                      '1'
                      '2'
                      '3'
                      '4'
                      '5'
                      '6'
                      '7'
                      '8'
                      '9'
                      '10'
                      '11'
                      '12'
                      '13'
                      '14'
                      '15'
                      '16'
                      '17'
                      '18'
                      '19'
                      '20'
                      '21'
                      '22'
                      '23'
                      '24'
                      '25'
                      '26'
                      '27'
                      '28'
                      '29'
                      '30'
                      '31'
                      '32')
                    ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
                    ListSettings.OutfilteredValueFont.Color = clRed
                    ListSettings.OutfilteredValueFont.Height = -11
                    ListSettings.OutfilteredValueFont.Name = 'Tahoma'
                    ListSettings.OutfilteredValueFont.Style = []
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                    OnKeyDown = EdtFieldKeyDown
                  end
                  object Panel7: TPanel
                    Left = 9
                    Top = 10
                    Width = 967
                    Height = 20
                    Alignment = taLeftJustify
                    BevelOuter = bvNone
                    Caption = ' PIS'
                    Color = 8747344
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWhite
                    Font.Height = -13
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentBackground = False
                    ParentFont = False
                    TabOrder = 1
                  end
                  object Panel19: TPanel
                    Left = 9
                    Top = 127
                    Width = 967
                    Height = 20
                    Alignment = taLeftJustify
                    BevelOuter = bvNone
                    Caption = ' PIS ST'
                    Color = 8747344
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWhite
                    Font.Height = -13
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentBackground = False
                    ParentFont = False
                    TabOrder = 2
                  end
                  object edtpis_rate: TDBEdit
                    Left = 80
                    Top = 83
                    Width = 242
                    Height = 24
                    DataField = 'pis_rate'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 3
                    OnClick = EdtFieldClick
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                    OnKeyDown = EdtFieldKeyDown
                  end
                  object edtpisst_rate: TDBEdit
                    Left = 80
                    Top = 152
                    Width = 242
                    Height = 24
                    DataField = 'pisst_rate'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 4
                    OnClick = EdtFieldClick
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                    OnKeyDown = EdtFieldKeyDown
                  end
                end
              end
              object TabSheet6: TTabSheet
                Caption = '     COFINS     '
                ImageIndex = 3
                object pnlCofins: TPanel
                  Left = 0
                  Top = 0
                  Width = 986
                  Height = 368
                  Align = alClient
                  BevelOuter = bvNone
                  BorderWidth = 10
                  Color = 16579576
                  ParentBackground = False
                  TabOrder = 0
                  object Label54: TLabel
                    Left = 9
                    Top = 35
                    Width = 117
                    Height = 16
                    Caption = '*Situa'#231#227'o Tribut'#225'ria'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lblcofins_aliq_perc: TLabel
                    Left = 9
                    Top = 86
                    Width = 62
                    Height = 16
                    Caption = '% Al'#237'quota'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                  end
                  object lblcofinsst_aliq_perc: TLabel
                    Left = 9
                    Top = 155
                    Width = 62
                    Height = 16
                    Caption = '% Al'#237'quota'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                  end
                  object cbxcofins_situation: TJvDBComboBox
                    Tag = 1
                    Left = 9
                    Top = 52
                    Width = 967
                    Height = 26
                    DataField = 'cofins_situation'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -15
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    Items.Strings = (
                      'cof01'
                      'cof02'
                      'cof03'
                      'cof04'
                      'cof05'
                      'cof06'
                      'cof07'
                      'cof08'
                      'cof09'
                      'cof49'
                      'cof50'
                      'cof51'
                      'cof52'
                      'cof53'
                      'cof54'
                      'cof55'
                      'cof56'
                      'cof60'
                      'cof61'
                      'cof62'
                      'cof63'
                      'cof64'
                      'cof65'
                      'cof66'
                      'cof67'
                      'cof70'
                      'cof71'
                      'cof72'
                      'cof73'
                      'cof74'
                      'cof75'
                      'cof98'
                      'cof99')
                    ParentFont = False
                    TabOrder = 0
                    Values.Strings = (
                      '0'
                      '1'
                      '2'
                      '3'
                      '4'
                      '5'
                      '6'
                      '7'
                      '8'
                      '9'
                      '10'
                      '11'
                      '12'
                      '13'
                      '14'
                      '15'
                      '16'
                      '17'
                      '18'
                      '19'
                      '20'
                      '21'
                      '22'
                      '23'
                      '24'
                      '25'
                      '26'
                      '27'
                      '28'
                      '29'
                      '30'
                      '31'
                      '32'
                      '')
                    ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
                    ListSettings.OutfilteredValueFont.Color = clRed
                    ListSettings.OutfilteredValueFont.Height = -11
                    ListSettings.OutfilteredValueFont.Name = 'Tahoma'
                    ListSettings.OutfilteredValueFont.Style = []
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                    OnKeyDown = EdtFieldKeyDown
                  end
                  object Panel20: TPanel
                    Left = 9
                    Top = 10
                    Width = 967
                    Height = 20
                    Alignment = taLeftJustify
                    BevelOuter = bvNone
                    Caption = ' COFINS'
                    Color = 8747344
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWhite
                    Font.Height = -13
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentBackground = False
                    ParentFont = False
                    TabOrder = 1
                  end
                  object Panel21: TPanel
                    Left = 9
                    Top = 127
                    Width = 967
                    Height = 20
                    Alignment = taLeftJustify
                    BevelOuter = bvNone
                    Caption = ' COFINS ST'
                    Color = 8747344
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWhite
                    Font.Height = -13
                    Font.Name = 'Arial'
                    Font.Style = [fsBold]
                    ParentBackground = False
                    ParentFont = False
                    TabOrder = 2
                  end
                  object edtcofins_rate: TDBEdit
                    Left = 81
                    Top = 83
                    Width = 242
                    Height = 24
                    DataField = 'cofins_rate'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 3
                    OnClick = EdtFieldClick
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                    OnKeyDown = EdtFieldKeyDown
                  end
                  object edtcofinsst_rate: TDBEdit
                    Left = 81
                    Top = 152
                    Width = 242
                    Height = 24
                    DataField = 'cofinsst_rate'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 4
                    OnClick = EdtFieldClick
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                    OnKeyDown = EdtFieldKeyDown
                  end
                end
              end
              object TabSheet1: TTabSheet
                Caption = 
                  '     Informa'#231#245'es Complementares de Interesse do Contribuinte    ' +
                  ' '
                ImageIndex = 4
                object Panel6: TPanel
                  Left = 0
                  Top = 0
                  Width = 986
                  Height = 368
                  Align = alClient
                  BevelOuter = bvNone
                  BorderWidth = 10
                  Color = 16579576
                  ParentBackground = False
                  TabOrder = 0
                  object memtaxpayer_note: TDBMemo
                    Left = 10
                    Top = 10
                    Width = 966
                    Height = 348
                    Align = alClient
                    DataField = 'taxpayer_note'
                    DataSource = dtsTaxRuleState
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clWindowText
                    Font.Height = -13
                    Font.Name = 'Tahoma'
                    Font.Style = []
                    ParentFont = False
                    TabOrder = 0
                    OnEnter = EdtFieldEnter
                    OnExit = EdtFieldExit
                  end
                end
              end
            end
          end
        end
      end
    end
    inherited pnlTitle: TPanel
      Width = 1022
      ExplicitWidth = 1022
      inherited imgTitle: TImage
        Width = 25
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000190000
          00190806000000C4E98563000000017352474200AECE1CE90000000467414D41
          0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
          6E4944415478DAB5968D51C3300C85EDCB008409081B9409683768364827A04C
          4098806C4037A04CD032016C403B011E2097A0D79339135CFF1EBAF3B9499EFC
          45B2A5548EE3580A21EE686076D99B94723BBDC9FE331E17348EA4DB981A49A2
          35CD4F22CCAE69818301C0C2CF0C985AAD5F0A1000D681901B72FC604045D3BB
          270327500E0411341EBD22FD651284F7E153F8F711B64A85CC385521D6E644F2
          15E8D3E5EC09D25505F8D4399007A4C2A3DF937E910C61D08EA6F919ADA2B180
          1E90255DBC0400E0846254E64D4B31E3395E64A50B57B2B00CC8EF610A98C0E0
          5FDA7432304D59F6076244A5CC3EE5D079A3FF81F47D5F1545816EDC88DF95FC
          48C2D60208ADF85AEF092A78E7703A1D45031253F19D86B88EA2B67B02754990
          98238C8E9A0A89FE68A540FEBB0BC7A58B23512990D0B6BD25408D1FA9A7CB19
          0D3DC73F90B92ECE24086C1886252D6203ED85D1EC1812F3D16A6D6DA5A1E98A
          2F5FC599C6C82F75EB011C696CBE016BDCF402CC34BF930000000049454E44AE
          426082}
        ExplicitLeft = 10
        ExplicitTop = 10
        ExplicitWidth = 25
        ExplicitHeight = 25
      end
      inherited lblTitle: TLabel
        Left = 45
        Width = 192
        Height = 40
        Caption = 'Regra Fiscal > UF'
        ExplicitLeft = 45
        ExplicitWidth = 192
      end
      inherited imgCloseTitle: TImage
        Left = 987
        ExplicitLeft = 563
      end
      inherited imgMinimizeTitle: TImage
        Left = 952
        ExplicitLeft = 528
      end
    end
  end
  object dtsTaxRuleState: TDataSource
    Left = 891
    Top = 1
  end
end
