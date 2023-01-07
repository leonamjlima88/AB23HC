inherited ProductCreateUpdateView: TProductCreateUpdateView
  ClientWidth = 1024
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 1024
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBackground: TPanel
    Width = 1024
    ExplicitWidth = 1024
    inherited pnlBackground2: TPanel
      Width = 1022
      ExplicitWidth = 1022
      inherited imgNoSearch: TSkAnimatedImage
        Width = 922
        ExplicitWidth = 922
      end
      inherited pnlBottomButtons: TPanel
        Width = 1002
        ExplicitWidth = 1002
        inherited pnlSave: TPanel
          Left = 832
          ExplicitLeft = 832
          inherited pnlSave2: TPanel
            inherited btnSave: TSpeedButton
              OnClick = btnSaveClick
            end
            inherited pnlSave3: TPanel
              OnClick = btnSaveClick
              inherited imgSave: TImage
                OnClick = btnSaveClick
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
              OnClick = btnCancelClick
              ExplicitLeft = 38
            end
            inherited pnlCancel3: TPanel
              OnClick = btnCancelClick
              inherited imgCancel4: TImage
                OnClick = btnCancelClick
              end
            end
          end
        end
      end
      inherited pgc: TPageControl
        Width = 1002
        ExplicitWidth = 1002
        inherited tabMain: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 25
          ExplicitWidth = 994
          ExplicitHeight = 574
          inherited pnlMain: TPanel
            Width = 994
            ExplicitWidth = 994
            object Label22: TLabel
              Left = 10
              Top = 10
              Width = 99
              Height = 18
              Caption = 'Identifica'#231#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label1: TLabel
              Left = 167
              Top = 85
              Width = 32
              Height = 14
              Caption = 'Nome'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label2: TLabel
              Left = 157
              Top = 85
              Width = 8
              Height = 14
              Caption = '*'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label5: TLabel
              Left = 649
              Top = 85
              Width = 215
              Height = 14
              Caption = 'Nome Simplificado (M'#225'x: 25 caracteres)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label12: TLabel
              Left = 157
              Top = 131
              Width = 57
              Height = 14
              Caption = 'Refer'#234'ncia'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Image1: TImage
              Left = 296
              Top = 131
              Width = 14
              Height = 14
              Hint = 'Campo '#250'nico. O valor deste campo n'#227'o pode se repetir!'
              AutoSize = True
              Center = True
              ParentShowHint = False
              Picture.Data = {
                0954506E67496D61676589504E470D0A1A0A0000000D494844520000000E0000
                000E08060000001F482DD1000000017352474200AECE1CE90000000467414D41
                0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000000
                CF4944415478DA9591C10DC2300C45DB0D3242D9A0DD0026A06CD00D508E8833
                E2081B9411B201DD0036A02364847EA39FCA0A4D542C59B163BDF8DB298B95D6
                9E2E1D0EE7AE672F79F90778C3B185EF042E55E185C36458431FE18D063FBC7C
                2740E956C3EFE868635066B0CCBFDDC34C945A84FA2288585EEE4501F203EB35
                E2598D06458A9722E20AF1115E0530B6E456B9FEBDEE28CB413EFC805ACE0228
                33B6C837B1D49E52ADBA13A9631224D4F13B5CE63BCC0C72ED4FFE91A7A74C14
                35BA6380072D35677A46C3191E6BC0097F1A6F6D2AA1C08C0000000049454E44
                AE426082}
              ShowHint = True
            end
            object Label37: TLabel
              Left = 824
              Top = 131
              Width = 129
              Height = 14
              Caption = 'F1 - Unidade de Medida'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label9: TLabel
              Left = 320
              Top = 131
              Width = 79
              Height = 14
              Caption = 'C'#243'd. de Barras'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Image2: TImage
              Left = 460
              Top = 131
              Width = 14
              Height = 14
              Hint = 'Campo '#250'nico. O valor deste campo n'#227'o pode se repetir!'
              AutoSize = True
              Center = True
              ParentShowHint = False
              Picture.Data = {
                0954506E67496D61676589504E470D0A1A0A0000000D494844520000000E0000
                000E08060000001F482DD1000000017352474200AECE1CE90000000467414D41
                0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000000
                CF4944415478DA9591C10DC2300C45DB0D3242D9A0DD0026A06CD00D508E8833
                E2081B9411B201DD0036A02364847EA39FCA0A4D542C59B163BDF8DB298B95D6
                9E2E1D0EE7AE672F79F90778C3B185EF042E55E185C36458431FE18D063FBC7C
                2740E956C3EFE868635066B0CCBFDDC34C945A84FA2288585EEE4501F203EB35
                E2598D06458A9722E20AF1115E0530B6E456B9FEBDEE28CB413EFC805ACE0228
                33B6C837B1D49E52ADBA13A9631224D4F13B5CE63BCC0C72ED4FFE91A7A74C14
                35BA6380072D35677A46C3191E6BC0097F1A6F6D2AA1C08C0000000049454E44
                AE426082}
              ShowHint = True
            end
            object Label10: TLabel
              Left = 484
              Top = 131
              Width = 84
              Height = 14
              Caption = 'C'#243'd. de F'#225'brica'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Image3: TImage
              Left = 625
              Top = 131
              Width = 14
              Height = 14
              Hint = 'Campo '#250'nico. O valor deste campo n'#227'o pode se repetir!'
              AutoSize = True
              Center = True
              ParentShowHint = False
              Picture.Data = {
                0954506E67496D61676589504E470D0A1A0A0000000D494844520000000E0000
                000E08060000001F482DD1000000017352474200AECE1CE90000000467414D41
                0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000000
                CF4944415478DA9591C10DC2300C45DB0D3242D9A0DD0026A06CD00D508E8833
                E2081B9411B201DD0036A02364847EA39FCA0A4D542C59B163BDF8DB298B95D6
                9E2E1D0EE7AE672F79F90778C3B185EF042E55E185C36458431FE18D063FBC7C
                2740E956C3EFE868635066B0CCBFDDC34C945A84FA2288585EEE4501F203EB35
                E2598D06458A9722E20AF1115E0530B6E456B9FEBDEE28CB413EFC805ACE0228
                33B6C837B1D49E52ADBA13A9631224D4F13B5CE63BCC0C72ED4FFE91A7A74C14
                35BA6380072D35677A46C3191E6BC0097F1A6F6D2AA1C08C0000000049454E44
                AE426082}
              ShowHint = True
            end
            object Label11: TLabel
              Left = 649
              Top = 131
              Width = 69
              Height = 14
              Caption = 'Identifica'#231#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label3: TLabel
              Left = 157
              Top = 39
              Width = 12
              Height = 14
              Caption = 'ID'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label4: TLabel
              Left = 217
              Top = 39
              Width = 24
              Height = 14
              Caption = 'Tipo'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label7: TLabel
              Left = 10
              Top = 182
              Width = 175
              Height = 14
              Caption = 'Descri'#231#227'o Detalhada do Produto'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label8: TLabel
              Left = 484
              Top = 182
              Width = 299
              Height = 14
              Caption = 'Observa'#231#245'es Internas (elas ser'#227'o exibidas apenas aqui)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label23: TLabel
              Left = 10
              Top = 309
              Width = 99
              Height = 18
              Caption = 'Classifica'#231#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label35: TLabel
              Left = 338
              Top = 338
              Width = 56
              Height = 14
              Caption = 'F1 - Marca'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label36: TLabel
              Left = 10
              Top = 338
              Width = 76
              Height = 14
              Caption = 'F1 - Categoria'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label71: TLabel
              Left = 667
              Top = 338
              Width = 163
              Height = 14
              Caption = 'F1 - Local de Armazenamento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label34: TLabel
              Left = 10
              Top = 384
              Width = 76
              Height = 14
              Caption = 'F1 - Tamanho'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label24: TLabel
              Left = 10
              Top = 445
              Width = 43
              Height = 18
              Caption = 'Pre'#231'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label25: TLabel
              Left = 510
              Top = 445
              Width = 86
              Height = 18
              Caption = 'Quantidade'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label14: TLabel
              Left = 10
              Top = 474
              Width = 59
              Height = 14
              Caption = 'Custo (R$)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label15: TLabel
              Left = 173
              Top = 474
              Width = 56
              Height = 14
              Caption = 'Lucro (%)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label16: TLabel
              Left = 337
              Top = 474
              Width = 63
              Height = 14
              Caption = 'Venda (R$)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label17: TLabel
              Left = 510
              Top = 474
              Width = 66
              Height = 14
              Caption = 'Em Estoque'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label20: TLabel
              Left = 673
              Top = 474
              Width = 36
              Height = 14
              Caption = 'M'#237'nima'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label21: TLabel
              Left = 836
              Top = 474
              Width = 39
              Height = 14
              Caption = 'M'#225'xima'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label13: TLabel
              Left = 814
              Top = 131
              Width = 8
              Height = 14
              Caption = '*'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label18: TLabel
              Left = 348
              Top = 384
              Width = 49
              Height = 14
              Caption = 'F1 - NCM'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label19: TLabel
              Left = 338
              Top = 384
              Width = 8
              Height = 14
              Caption = '*'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Panel5: TPanel
              Left = 10
              Top = 28
              Width = 974
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 29
            end
            object pnlFotoCapa: TPanel
              Left = 10
              Top = 39
              Width = 137
              Height = 133
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 14209468
              ParentBackground = False
              TabOrder = 30
              object Panel46: TPanel
                Left = 1
                Top = 1
                Width = 135
                Height = 131
                Margins.Left = 0
                Margins.Top = 4
                Margins.Right = 0
                Margins.Bottom = 4
                Align = alClient
                BevelOuter = bvNone
                Caption = 'Imagem'
                Color = 16250354
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 13550254
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentBackground = False
                ParentFont = False
                TabOrder = 0
                object Label83: TLabel
                  AlignWithMargins = True
                  Left = 5
                  Top = 5
                  Width = 125
                  Height = 42
                  Alignment = taCenter
                  AutoSize = False
                  Caption = 'Extens'#227'o: .jpg    Carregue imagem c/ resolu'#231#227'o de 135x135px'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = 13550254
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  WordWrap = True
                end
                object imgFotoCapa: TImage
                  Tag = 1
                  Left = 0
                  Top = 0
                  Width = 135
                  Height = 131
                  Cursor = crHandPoint
                  Margins.Left = 0
                  Margins.Top = 1
                  Margins.Right = 0
                  Margins.Bottom = 1
                  Align = alClient
                  Center = True
                  Stretch = True
                  ExplicitLeft = 33
                  ExplicitTop = 92
                  ExplicitHeight = 135
                end
                object btnIncluirFotoCapa: TImage
                  Left = 105
                  Top = 101
                  Width = 25
                  Height = 25
                  Cursor = crHandPoint
                  AutoSize = True
                  Picture.Data = {
                    0954506E67496D61676589504E470D0A1A0A0000000D49484452000000190000
                    00190806000000C4E98563000000017352474200AECE1CE90000000467414D41
                    0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
                    A64944415478DAE596C151C3301045E50E9C0AB02F9C9D0E9C0AE25480DD417C
                    E18A73E542A88050014E057107C9990BA602D401FC3F598146042379325CD0CC
                    8E13ADFCDF6AA5951CA93F68D1FF815CDECE333C1E60F109B78655CFD7DBC368
                    88009E60C9C030826643A01F219E002F502482391E378E2FF104D8AD73C05B80
                    3711004BFCB90B140B6915212F23220E699A90F78054D05E6117B0D237385F48
                    0DDB20BFDAEEC4BB5CC7E61C9035C46BB75376DF156C790E480A48EF0028CC59
                    C49242E3CFC482200700A62700DC8DAC896FD52EE5C01322F185F410492D01BE
                    B897C867F61AC1178B78255D7B03F249D7C488612C454A01740E6027A9620053
                    F9BDF38534105C89186B4ADB297400A6712756A60683B630ECCD080C0038C305
                    670F3F7D79683172515B082C04A01CC8274082E0015B10C2E8624F9092744DAC
                    3A590948DB003BBD84703BFE5A504E336BC21DB416907200853A5E158D39EA09
                    992BBFB388637A01990C680790C8ECE84F83EF780894EA580F2CC27BDE178E3F
                    575FC5C8F4B5A33E249C3B8833E8246A5A267DB50960F4D78AA4840B5F58C24C
                    630B7BB4CFBB0F4D7BCEAE86D79EBA0000000049454E44AE426082}
                end
                object btnRemoverFotoCapa: TImage
                  Left = 5
                  Top = 101
                  Width = 25
                  Height = 25
                  Cursor = crHandPoint
                  AutoSize = True
                  Picture.Data = {
                    0954506E67496D61676589504E470D0A1A0A0000000D49484452000000190000
                    00190806000000C4E98563000000017352474200AECE1CE90000000467414D41
                    0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
                    ED4944415478DAB5964B4BC340108077F4A842BD584983B43E1011B5A248F1D9
                    D4B7F868F10FD88B57FD07B6BFC0B3A716FF80D52A7851D3FA404FE62A8806C9
                    463D8801F56A9CD8186B6DB409CDC030CB3EE6DB99ECCE06C81F2247465D6846
                    0881305A3FAA17D5A50F8BA83C216A86D93A48FEE5078A3A0F73E80856B0B98A
                    335CA41451498C491DC64B82C80B413FF626F49D5B15016151669B174C21F2FC
                    B00638CA4B891D5110146276B297BF20F2DC603900F9208E499F0806449EED77
                    E9003B29321391499FF90C089D0DACA1899511F02551CFEE7912E84C9F16C515
                    F2EA1C80289EBD8B5A84F4E21D802D0700463440A77B3440D84108A66BAAFB96
                    E46EB253F20474B2EB991439B6155535963CBDBFBD980D2940273AD4C2DE4A37
                    43DC9BFB96B7FCB03840DE5F7FC3808EB7178DE4339A6A8BD1BC168F06E858DB
                    35DA26CBDB2E5D04A0A3AD1BD858761082A72BD4B2848D84730C8800E59AF17B
                    A85AC5F43A405008802F57BB828D58BBD4980351C43CFC4DDC28F5D288578BA6
                    9C5558C09AC8B1BCA8E4411ABCF806DC962F4D08C8DC7DBF27066898F523E8D2
                    9EDF1F80289B955246D20A6748438C06B2FFC60389B0C7B298DF0966B3A5C1FA
                    5584AD5BD83DFEA940923DB9570A07E1BFD5D2801B9F01751A9B018476EAAB34
                    47624E611B6D8A3D7D54CC7C7C00D4279024106AC6270000000049454E44AE42
                    6082}
                end
              end
            end
            object edtName: TDBEdit
              Left = 157
              Top = 100
              Width = 482
              Height = 26
              DataField = 'name'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit5: TDBEdit
              Left = 649
              Top = 100
              Width = 335
              Height = 26
              DataField = 'simplified_name'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              MaxLength = 25
              ParentFont = False
              TabOrder = 3
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit10: TDBEdit
              Left = 157
              Top = 146
              Width = 153
              Height = 26
              DataField = 'sku_code'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtunit_name: TDBEdit
              Left = 892
              Top = 146
              Width = 92
              Height = 26
              Color = 16053492
              DataField = 'unit_name'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 9
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel41: TPanel
              Left = 814
              Top = 146
              Width = 26
              Height = 26
              Cursor = crHandPoint
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 5327153
              ParentBackground = False
              TabOrder = 31
              object Panel42: TPanel
                Left = 1
                Top = 1
                Width = 24
                Height = 24
                Cursor = crHandPoint
                Align = alClient
                BevelOuter = bvNone
                Color = 8747344
                ParentBackground = False
                TabOrder = 0
                object imgLocaUnit: TImage
                  Left = 0
                  Top = 0
                  Width = 24
                  Height = 24
                  Align = alClient
                  AutoSize = True
                  Center = True
                  Picture.Data = {
                    0954506E67496D61676589504E470D0A1A0A0000000D49484452000000120000
                    0012080600000056CE8E57000000017352474200AECE1CE90000000467414D41
                    0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
                    414944415478DAA5938171C2300C45ADCB00850DC2040D1B94094A2600262899
                    80D205B84E001B1426209DA0D9A0E904658284FF13B9C7E56C27477DF7CFC696
                    9E14498809ACBAAE47D85EA0391443FC5D4247E85D444A6B2B014882ED431D73
                    E8A44F043E434BE815B0AD1704088DCF1A790BE38BDE199B85063A5755F51645
                    D1CE07DAABD34A1D3650017DE22EEF64FD054DC401B18F53E802119A32AB6050
                    C7038BBB84E314676672C2B908D4928DD8BB40744EE09CE2BCC39EF574B6F982
                    20C80C5821509BAAC87820688D6DE1028DB4D86CFBA10742DB664CC4138105A7
                    D1ACA7D0EC58D2D87920ACCFC2B4D39B7533C310C6B8DBC09E81E60C260EC88A
                    436727D7B4B3C4EC72358D5585DA96BC946E26A4DFFCCF9A3A69031E15F84368
                    F793C593C91F6448E72CE8FBBF100BFA65D5A107E8700FC4829E6E8A9ADD03E1
                    BA02035FC005512468860000000049454E44AE426082}
                  OnClick = imgLocaUnitClick
                  ExplicitTop = 14
                  ExplicitWidth = 18
                  ExplicitHeight = 18
                end
              end
            end
            object edtunit_id: TDBEdit
              Left = 841
              Top = 146
              Width = 50
              Height = 26
              DataField = 'unit_id'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 8
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit7: TDBEdit
              Left = 320
              Top = 146
              Width = 154
              Height = 26
              DataField = 'ean_code'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 5
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit8: TDBEdit
              Left = 484
              Top = 146
              Width = 155
              Height = 26
              DataField = 'manufacturing_code'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit9: TDBEdit
              Left = 649
              Top = 146
              Width = 155
              Height = 26
              DataField = 'identification_code'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 7
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit3: TDBEdit
              Left = 157
              Top = 54
              Width = 50
              Height = 26
              TabStop = False
              Color = 16053492
              DataField = 'id'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              OnKeyDown = EdtFieldKeyDown
            end
            object JvDBComboBox1: TJvDBComboBox
              Left = 217
              Top = 54
              Width = 150
              Height = 26
              DataField = 'type'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              Items.Strings = (
                'Produto'
                'Servi'#231'o')
              ParentFont = False
              TabOrder = 1
              UpdateFieldImmediatelly = True
              Values.Strings = (
                '0'
                '1')
              ListSettings.OutfilteredValueFont.Charset = DEFAULT_CHARSET
              ListSettings.OutfilteredValueFont.Color = clRed
              ListSettings.OutfilteredValueFont.Height = -11
              ListSettings.OutfilteredValueFont.Name = 'Tahoma'
              ListSettings.OutfilteredValueFont.Style = []
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBCheckBox4: TDBCheckBox
              Left = 869
              Top = 11
              Width = 115
              Height = 17
              Cursor = crHandPoint
              TabStop = False
              Caption = 'Item descontinuado!'
              DataField = 'is_discontinued'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 32
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object DBMemo1: TDBMemo
              Left = 10
              Top = 197
              Width = 464
              Height = 92
              TabStop = False
              DataField = 'complement_note'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 10
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
            end
            object DBMemo2: TDBMemo
              Left = 484
              Top = 197
              Width = 500
              Height = 92
              TabStop = False
              DataField = 'internal_note'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 11
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
            end
            object Panel6: TPanel
              Left = 10
              Top = 327
              Width = 974
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 33
            end
            object edtbrand_name: TDBEdit
              Left = 416
              Top = 353
              Width = 241
              Height = 26
              Color = 16053492
              DataField = 'brand_name'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 15
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel37: TPanel
              Left = 338
              Top = 353
              Width = 26
              Height = 26
              Cursor = crHandPoint
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 5327153
              ParentBackground = False
              TabOrder = 34
              object Panel38: TPanel
                Left = 1
                Top = 1
                Width = 24
                Height = 24
                Cursor = crHandPoint
                Align = alClient
                BevelOuter = bvNone
                Color = 8747344
                ParentBackground = False
                TabOrder = 0
                object imgLocaBrand: TImage
                  Left = 0
                  Top = 0
                  Width = 24
                  Height = 24
                  Align = alClient
                  AutoSize = True
                  Center = True
                  Picture.Data = {
                    0954506E67496D61676589504E470D0A1A0A0000000D49484452000000120000
                    0012080600000056CE8E57000000017352474200AECE1CE90000000467414D41
                    0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
                    414944415478DAA5938171C2300C45ADCB00850DC2040D1B94094A2600262899
                    80D205B84E001B1426209DA0D9A0E904658284FF13B9C7E56C27477DF7CFC696
                    9E14498809ACBAAE47D85EA0391443FC5D4247E85D444A6B2B014882ED431D73
                    E8A44F043E434BE815B0AD1704088DCF1A790BE38BDE199B85063A5755F51645
                    D1CE07DAABD34A1D3650017DE22EEF64FD054DC401B18F53E802119A32AB6050
                    C7038BBB84E314676672C2B908D4928DD8BB40744EE09CE2BCC39EF574B6F982
                    20C80C5821509BAAC87820688D6DE1028DB4D86CFBA10742DB664CC4138105A7
                    D1ACA7D0EC58D2D87920ACCFC2B4D39B7533C310C6B8DBC09E81E60C260EC88A
                    436727D7B4B3C4EC72358D5585DA96BC946E26A4DFFCCF9A3A69031E15F84368
                    F793C593C91F6448E72CE8FBBF100BFA65D5A107E8700FC4829E6E8A9ADD03E1
                    BA02035FC005512468860000000049454E44AE426082}
                  OnClick = imgLocaBrandClick
                  ExplicitLeft = -4
                end
              end
            end
            object edtbrand_id: TDBEdit
              Left = 365
              Top = 353
              Width = 50
              Height = 26
              DataField = 'brand_id'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 14
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtcategory_name: TDBEdit
              Left = 88
              Top = 353
              Width = 240
              Height = 26
              Color = 16053492
              DataField = 'category_name'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 13
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel39: TPanel
              Left = 10
              Top = 353
              Width = 26
              Height = 26
              Cursor = crHandPoint
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 5327153
              ParentBackground = False
              TabOrder = 35
              object Panel40: TPanel
                Left = 1
                Top = 1
                Width = 24
                Height = 24
                Cursor = crHandPoint
                Align = alClient
                BevelOuter = bvNone
                Color = 8747344
                ParentBackground = False
                TabOrder = 0
                object imgLocaCategory: TImage
                  Left = 0
                  Top = 0
                  Width = 24
                  Height = 24
                  Align = alClient
                  AutoSize = True
                  Center = True
                  Picture.Data = {
                    0954506E67496D61676589504E470D0A1A0A0000000D49484452000000120000
                    0012080600000056CE8E57000000017352474200AECE1CE90000000467414D41
                    0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
                    414944415478DAA5938171C2300C45ADCB00850DC2040D1B94094A2600262899
                    80D205B84E001B1426209DA0D9A0E904658284FF13B9C7E56C27477DF7CFC696
                    9E14498809ACBAAE47D85EA0391443FC5D4247E85D444A6B2B014882ED431D73
                    E8A44F043E434BE815B0AD1704088DCF1A790BE38BDE199B85063A5755F51645
                    D1CE07DAABD34A1D3650017DE22EEF64FD054DC401B18F53E802119A32AB6050
                    C7038BBB84E314676672C2B908D4928DD8BB40744EE09CE2BCC39EF574B6F982
                    20C80C5821509BAAC87820688D6DE1028DB4D86CFBA10742DB664CC4138105A7
                    D1ACA7D0EC58D2D87920ACCFC2B4D39B7533C310C6B8DBC09E81E60C260EC88A
                    436727D7B4B3C4EC72358D5585DA96BC946E26A4DFFCCF9A3A69031E15F84368
                    F793C593C91F6448E72CE8FBBF100BFA65D5A107E8700FC4829E6E8A9ADD03E1
                    BA02035FC005512468860000000049454E44AE426082}
                  OnClick = imgLocaCategoryClick
                  ExplicitTop = 14
                  ExplicitWidth = 18
                  ExplicitHeight = 18
                end
              end
            end
            object edtcategory_id: TDBEdit
              Left = 37
              Top = 353
              Width = 50
              Height = 26
              DataField = 'category_id'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 12
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtstorage_location_name: TDBEdit
              Left = 745
              Top = 353
              Width = 239
              Height = 26
              Color = 16053492
              DataField = 'storage_location_name'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 17
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel43: TPanel
              Left = 667
              Top = 353
              Width = 26
              Height = 26
              Cursor = crHandPoint
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 5327153
              ParentBackground = False
              TabOrder = 36
              object Panel44: TPanel
                Left = 1
                Top = 1
                Width = 24
                Height = 24
                Cursor = crHandPoint
                Align = alClient
                BevelOuter = bvNone
                Color = 8747344
                ParentBackground = False
                TabOrder = 0
                object imgLocaStorageLocation: TImage
                  Left = 0
                  Top = 0
                  Width = 24
                  Height = 24
                  Align = alClient
                  AutoSize = True
                  Center = True
                  Picture.Data = {
                    0954506E67496D61676589504E470D0A1A0A0000000D49484452000000120000
                    0012080600000056CE8E57000000017352474200AECE1CE90000000467414D41
                    0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
                    414944415478DAA5938171C2300C45ADCB00850DC2040D1B94094A2600262899
                    80D205B84E001B1426209DA0D9A0E904658284FF13B9C7E56C27477DF7CFC696
                    9E14498809ACBAAE47D85EA0391443FC5D4247E85D444A6B2B014882ED431D73
                    E8A44F043E434BE815B0AD1704088DCF1A790BE38BDE199B85063A5755F51645
                    D1CE07DAABD34A1D3650017DE22EEF64FD054DC401B18F53E802119A32AB6050
                    C7038BBB84E314676672C2B908D4928DD8BB40744EE09CE2BCC39EF574B6F982
                    20C80C5821509BAAC87820688D6DE1028DB4D86CFBA10742DB664CC4138105A7
                    D1ACA7D0EC58D2D87920ACCFC2B4D39B7533C310C6B8DBC09E81E60C260EC88A
                    436727D7B4B3C4EC72358D5585DA96BC946E26A4DFFCCF9A3A69031E15F84368
                    F793C593C91F6448E72CE8FBBF100BFA65D5A107E8700FC4829E6E8A9ADD03E1
                    BA02035FC005512468860000000049454E44AE426082}
                  OnClick = imgLocaStorageLocationClick
                  ExplicitTop = 14
                  ExplicitWidth = 18
                  ExplicitHeight = 18
                end
              end
            end
            object edtstorage_location_id: TDBEdit
              Left = 694
              Top = 353
              Width = 50
              Height = 26
              DataField = 'storage_location_id'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 16
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtsize_name: TDBEdit
              Left = 88
              Top = 399
              Width = 240
              Height = 26
              Color = 16053492
              DataField = 'size_name'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 19
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel17: TPanel
              Left = 10
              Top = 399
              Width = 26
              Height = 26
              Cursor = crHandPoint
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 5327153
              ParentBackground = False
              TabOrder = 37
              object Panel19: TPanel
                Left = 1
                Top = 1
                Width = 24
                Height = 24
                Cursor = crHandPoint
                Align = alClient
                BevelOuter = bvNone
                Color = 8747344
                ParentBackground = False
                TabOrder = 0
                object imgLocaSize: TImage
                  Left = 0
                  Top = 0
                  Width = 24
                  Height = 24
                  Align = alClient
                  AutoSize = True
                  Center = True
                  Picture.Data = {
                    0954506E67496D61676589504E470D0A1A0A0000000D49484452000000120000
                    0012080600000056CE8E57000000017352474200AECE1CE90000000467414D41
                    0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
                    414944415478DAA5938171C2300C45ADCB00850DC2040D1B94094A2600262899
                    80D205B84E001B1426209DA0D9A0E904658284FF13B9C7E56C27477DF7CFC696
                    9E14498809ACBAAE47D85EA0391443FC5D4247E85D444A6B2B014882ED431D73
                    E8A44F043E434BE815B0AD1704088DCF1A790BE38BDE199B85063A5755F51645
                    D1CE07DAABD34A1D3650017DE22EEF64FD054DC401B18F53E802119A32AB6050
                    C7038BBB84E314676672C2B908D4928DD8BB40744EE09CE2BCC39EF574B6F982
                    20C80C5821509BAAC87820688D6DE1028DB4D86CFBA10742DB664CC4138105A7
                    D1ACA7D0EC58D2D87920ACCFC2B4D39B7533C310C6B8DBC09E81E60C260EC88A
                    436727D7B4B3C4EC72358D5585DA96BC946E26A4DFFCCF9A3A69031E15F84368
                    F793C593C91F6448E72CE8FBBF100BFA65D5A107E8700FC4829E6E8A9ADD03E1
                    BA02035FC005512468860000000049454E44AE426082}
                  OnClick = imgLocaSizeClick
                  ExplicitTop = 14
                  ExplicitWidth = 18
                  ExplicitHeight = 18
                end
              end
            end
            object edtsize_id: TDBEdit
              Left = 37
              Top = 399
              Width = 50
              Height = 26
              DataField = 'size_id'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 18
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel7: TPanel
              Left = 10
              Top = 463
              Width = 480
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 38
            end
            object Panel8: TPanel
              Left = 510
              Top = 463
              Width = 474
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 39
            end
            object DBEdit11: TDBEdit
              Left = 10
              Top = 489
              Width = 153
              Height = 26
              DataField = 'cost'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 23
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit12: TDBEdit
              Left = 173
              Top = 489
              Width = 153
              Height = 26
              DataField = 'marketup'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 24
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit13: TDBEdit
              Left = 337
              Top = 489
              Width = 153
              Height = 26
              DataField = 'price'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 25
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBCheckBox1: TDBCheckBox
              Left = 673
              Top = 445
              Width = 116
              Height = 17
              Cursor = crHandPoint
              TabStop = False
              Caption = 'Controle de estoque'
              DataField = 'is_to_move_the_stock'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 40
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object DBCheckBox3: TDBCheckBox
              Left = 836
              Top = 445
              Width = 127
              Height = 17
              Cursor = crHandPoint
              TabStop = False
              Caption = 'Produto para pesagem'
              DataField = 'is_product_for_scales'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 41
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object DBEdit14: TDBEdit
              Left = 510
              Top = 489
              Width = 153
              Height = 26
              DataField = 'current_quantity'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 26
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit15: TDBEdit
              Left = 673
              Top = 489
              Width = 153
              Height = 26
              DataField = 'minimum_quantity'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 27
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit16: TDBEdit
              Left = 836
              Top = 489
              Width = 148
              Height = 26
              DataField = 'maximum_quantity'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 28
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtncm_ncm: TDBEdit
              Left = 416
              Top = 399
              Width = 100
              Height = 26
              Color = 16053492
              DataField = 'ncm_ncm'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 21
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel1: TPanel
              Left = 338
              Top = 399
              Width = 26
              Height = 26
              Cursor = crHandPoint
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 5327153
              ParentBackground = False
              TabOrder = 42
              object Panel2: TPanel
                Left = 1
                Top = 1
                Width = 24
                Height = 24
                Cursor = crHandPoint
                Align = alClient
                BevelOuter = bvNone
                Color = 8747344
                ParentBackground = False
                TabOrder = 0
                object imgLocaNCM: TImage
                  Left = 0
                  Top = 0
                  Width = 24
                  Height = 24
                  Align = alClient
                  AutoSize = True
                  Center = True
                  Picture.Data = {
                    0954506E67496D61676589504E470D0A1A0A0000000D49484452000000120000
                    0012080600000056CE8E57000000017352474200AECE1CE90000000467414D41
                    0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
                    414944415478DAA5938171C2300C45ADCB00850DC2040D1B94094A2600262899
                    80D205B84E001B1426209DA0D9A0E904658284FF13B9C7E56C27477DF7CFC696
                    9E14498809ACBAAE47D85EA0391443FC5D4247E85D444A6B2B014882ED431D73
                    E8A44F043E434BE815B0AD1704088DCF1A790BE38BDE199B85063A5755F51645
                    D1CE07DAABD34A1D3650017DE22EEF64FD054DC401B18F53E802119A32AB6050
                    C7038BBB84E314676672C2B908D4928DD8BB40744EE09CE2BCC39EF574B6F982
                    20C80C5821509BAAC87820688D6DE1028DB4D86CFBA10742DB664CC4138105A7
                    D1ACA7D0EC58D2D87920ACCFC2B4D39B7533C310C6B8DBC09E81E60C260EC88A
                    436727D7B4B3C4EC72358D5585DA96BC946E26A4DFFCCF9A3A69031E15F84368
                    F793C593C91F6448E72CE8FBBF100BFA65D5A107E8700FC4829E6E8A9ADD03E1
                    BA02035FC005512468860000000049454E44AE426082}
                  OnClick = imgLocaNCMClick
                  ExplicitLeft = -1
                end
              end
            end
            object edtncm_id: TDBEdit
              Left = 365
              Top = 399
              Width = 50
              Height = 26
              DataField = 'ncm_id'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 20
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtncm_name: TDBEdit
              Left = 517
              Top = 399
              Width = 467
              Height = 26
              Color = 16053492
              DataField = 'ncm_name'
              DataSource = dtsProduct
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 22
              OnKeyDown = EdtFieldKeyDown
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
        Width = 87
        Height = 40
        Caption = 'Produto'
        ExplicitLeft = 45
        ExplicitWidth = 87
      end
      inherited imgCloseTitle: TImage
        Left = 987
        OnClick = btnCancelClick
        ExplicitLeft = 563
      end
      inherited imgMinimizeTitle: TImage
        Left = 952
        ExplicitLeft = 528
      end
    end
  end
  object dtsProduct: TDataSource
    Left = 851
    Top = 1
  end
end
