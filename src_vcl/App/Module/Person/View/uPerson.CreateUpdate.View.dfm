inherited PersonCreateUpdateView: TPersonCreateUpdateView
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
        ActivePage = TabSheet2
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
              Width = 111
              Height = 18
              Caption = 'Tipo de Pessoa'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label35: TLabel
              Left = 10
              Top = 93
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
            object Label1: TLabel
              Left = 10
              Top = 69
              Width = 116
              Height = 18
              Caption = 'Ficha Cadastral'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label15: TLabel
              Left = 66
              Top = 93
              Width = 77
              Height = 14
              Caption = 'F1 - CPF/CNPJ'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label4: TLabel
              Left = 492
              Top = 93
              Width = 39
              Height = 14
              Caption = 'RG / IE'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label16: TLabel
              Left = 672
              Top = 93
              Width = 99
              Height = 14
              Caption = 'Inscri'#231#227'o Municipal'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label3: TLabel
              Left = 20
              Top = 139
              Width = 110
              Height = 14
              Caption = 'Nome / Raz'#227'o Social'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label5: TLabel
              Left = 10
              Top = 139
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
            object Label6: TLabel
              Left = 492
              Top = 139
              Width = 96
              Height = 14
              Caption = 'Apelido / Fantasia'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label2: TLabel
              Left = 10
              Top = 200
              Width = 69
              Height = 18
              Caption = 'Endere'#231'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label21: TLabel
              Left = 10
              Top = 225
              Width = 46
              Height = 14
              Caption = 'F1 - Cep'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label7: TLabel
              Left = 146
              Top = 225
              Width = 62
              Height = 14
              Caption = 'Logradouro'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label18: TLabel
              Left = 672
              Top = 225
              Width = 43
              Height = 14
              Caption = 'N'#250'mero'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label19: TLabel
              Left = 752
              Top = 225
              Width = 76
              Height = 14
              Caption = 'Complemento'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label20: TLabel
              Left = 10
              Top = 271
              Width = 30
              Height = 14
              Caption = 'Bairro'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label23: TLabel
              Left = 323
              Top = 271
              Width = 61
              Height = 14
              Caption = 'F1 - Cidade'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label24: TLabel
              Left = 672
              Top = 271
              Width = 112
              Height = 14
              Caption = 'Ponto de Refer'#234'ncia'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label25: TLabel
              Left = 632
              Top = 271
              Width = 14
              Height = 14
              Caption = 'UF'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label8: TLabel
              Left = 10
              Top = 332
              Width = 58
              Height = 18
              Caption = 'Contato'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label27: TLabel
              Left = 10
              Top = 356
              Width = 49
              Height = 14
              Caption = 'Telefone'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label28: TLabel
              Left = 170
              Top = 356
              Width = 60
              Height = 14
              Caption = 'Telefone 2'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label29: TLabel
              Left = 330
              Top = 356
              Width = 60
              Height = 14
              Caption = 'Telefone 3'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label30: TLabel
              Left = 492
              Top = 356
              Width = 103
              Height = 14
              Caption = 'P'#225'gina de Internet'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label31: TLabel
              Left = 10
              Top = 402
              Width = 31
              Height = 14
              Caption = 'E-mail'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label32: TLabel
              Left = 492
              Top = 402
              Width = 90
              Height = 14
              Caption = 'E-mail (Finan'#231'as)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
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
              TabOrder = 21
            end
            object edtId: TDBEdit
              Left = 10
              Top = 108
              Width = 50
              Height = 26
              TabStop = False
              Color = 16053492
              DataField = 'id'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              OnClick = EdtFieldClick
              OnKeyDown = EdtFieldKeyDown
            end
            object chkis_seller: TDBCheckBox
              Tag = 1
              Left = 86
              Top = 34
              Width = 71
              Height = 20
              Cursor = crHandPoint
              TabStop = False
              Caption = 'Vendedor'
              DataField = 'is_seller'
              DataSource = dtsPerson
              TabOrder = 22
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object chkis_supplier: TDBCheckBox
              Tag = 1
              Left = 187
              Top = 34
              Width = 79
              Height = 20
              Cursor = crHandPoint
              TabStop = False
              Caption = 'Fornecedor'
              DataField = 'is_supplier'
              DataSource = dtsPerson
              TabOrder = 23
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object chkis_carrier: TDBCheckBox
              Tag = 1
              Left = 296
              Top = 34
              Width = 97
              Height = 20
              Cursor = crHandPoint
              TabStop = False
              Caption = 'Transportador'
              DataField = 'is_carrier'
              DataSource = dtsPerson
              TabOrder = 24
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object chkis_technician: TDBCheckBox
              Tag = 1
              Left = 423
              Top = 34
              Width = 60
              Height = 20
              Cursor = crHandPoint
              TabStop = False
              Caption = 'T'#233'cnico'
              DataField = 'is_technician'
              DataSource = dtsPerson
              TabOrder = 25
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object chkis_employee: TDBCheckBox
              Tag = 1
              Left = 513
              Top = 34
              Width = 79
              Height = 20
              Cursor = crHandPoint
              TabStop = False
              Caption = 'Funcion'#225'rio'
              DataField = 'is_employee'
              DataSource = dtsPerson
              TabOrder = 26
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object chkis_other: TDBCheckBox
              Tag = 1
              Left = 622
              Top = 34
              Width = 55
              Height = 20
              Cursor = crHandPoint
              TabStop = False
              Caption = 'Outros'
              DataField = 'is_other'
              DataSource = dtsPerson
              TabOrder = 27
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object chkis_customer: TDBCheckBox
              Tag = 1
              Left = 10
              Top = 34
              Width = 54
              Height = 20
              Cursor = crHandPoint
              TabStop = False
              Caption = 'Cliente'
              DataField = 'is_customer'
              DataSource = dtsPerson
              TabOrder = 28
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object chkis_final_customer: TDBCheckBox
              Tag = 1
              Left = 707
              Top = 34
              Width = 108
              Height = 20
              Cursor = crHandPoint
              TabStop = False
              Caption = 'Consumidor Final'
              DataField = 'is_final_customer'
              DataSource = dtsPerson
              TabOrder = 29
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object Panel1: TPanel
              Left = 10
              Top = 87
              Width = 974
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 30
            end
            object edtlegal_entity_number: TDBEdit
              Left = 66
              Top = 107
              Width = 170
              Height = 26
              DataField = 'legal_entity_number'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtstate_registration: TDBEdit
              Left = 492
              Top = 108
              Width = 170
              Height = 26
              DataField = 'state_registration'
              DataSource = dtsPerson
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
            object edtmunicipal_registration: TDBEdit
              Left = 672
              Top = 108
              Width = 170
              Height = 26
              DataField = 'municipal_registration'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel26: TPanel
              Left = 237
              Top = 107
              Width = 26
              Height = 26
              Cursor = crHandPoint
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 5327153
              ParentBackground = False
              TabOrder = 31
              object Panel27: TPanel
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
                object imgLocaLegalNumberEntity: TImage
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
                  OnClick = imgLocaLegalNumberEntityClick
                  ExplicitLeft = 4
                  ExplicitTop = 16
                  ExplicitWidth = 18
                  ExplicitHeight = 18
                end
              end
            end
            object loadLegalEntityNumber: TActivityIndicator
              Left = 211
              Top = 108
              IndicatorSize = aisSmall
              IndicatorType = aitRotatingSector
            end
            object rdgicms_taxpayer: TDBRadioGroup
              Left = 277
              Top = 93
              Width = 205
              Height = 41
              Caption = '  Contribuinte de ICMS?  '
              Columns = 3
              DataField = 'icms_taxpayer'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Items.Strings = (
                'N'#227'o'
                'Sim'
                'Isento')
              ParentFont = False
              TabOrder = 33
              Values.Strings = (
                '0'
                '1'
                '2')
            end
            object edtname: TDBEdit
              Left = 10
              Top = 154
              Width = 472
              Height = 26
              DataField = 'name'
              DataSource = dtsPerson
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
            object edtalias_name: TDBEdit
              Left = 492
              Top = 154
              Width = 492
              Height = 26
              DataField = 'alias_name'
              DataSource = dtsPerson
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
            object Panel2: TPanel
              Left = 10
              Top = 218
              Width = 974
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 34
            end
            object edtzipcode: TDBEdit
              Left = 10
              Top = 240
              Width = 99
              Height = 26
              DataField = 'zipcode'
              DataSource = dtsPerson
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
            object edtaddress: TDBEdit
              Left = 146
              Top = 240
              Width = 516
              Height = 26
              DataField = 'address'
              DataSource = dtsPerson
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
            object Panel7: TPanel
              Left = 110
              Top = 240
              Width = 26
              Height = 26
              Cursor = crHandPoint
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 5327153
              ParentBackground = False
              TabOrder = 35
              object Panel9: TPanel
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
                object imgLocaZipcode: TImage
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
                  OnClick = imgLocaZipcodeClick
                  ExplicitLeft = 4
                  ExplicitTop = 16
                  ExplicitWidth = 18
                  ExplicitHeight = 18
                end
              end
            end
            object edtaddress_number: TDBEdit
              Left = 672
              Top = 240
              Width = 70
              Height = 26
              DataField = 'address_number'
              DataSource = dtsPerson
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
            object edtcomplement: TDBEdit
              Left = 752
              Top = 240
              Width = 232
              Height = 26
              DataField = 'complement'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 9
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtdistrict: TDBEdit
              Left = 10
              Top = 286
              Width = 303
              Height = 26
              DataField = 'district'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 10
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtcity_id: TDBEdit
              Left = 350
              Top = 286
              Width = 50
              Height = 26
              DataField = 'city_id'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 11
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel10: TPanel
              Left = 323
              Top = 286
              Width = 26
              Height = 26
              Cursor = crHandPoint
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 5327153
              ParentBackground = False
              TabOrder = 36
              object Panel12: TPanel
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
                object imgLocaCity: TImage
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
                  OnClick = imgLocaCityClick
                  ExplicitTop = 14
                  ExplicitWidth = 18
                  ExplicitHeight = 18
                end
              end
            end
            object edtcity_name: TDBEdit
              Left = 401
              Top = 286
              Width = 230
              Height = 26
              Color = 16053492
              DataField = 'city_name'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 12
              OnKeyDown = EdtFieldKeyDown
            end
            object edtcity_state: TDBEdit
              Left = 632
              Top = 286
              Width = 30
              Height = 26
              Color = 16053492
              DataField = 'city_state'
              DataSource = dtsPerson
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
            object edtreference_point: TDBEdit
              Left = 672
              Top = 286
              Width = 312
              Height = 26
              DataField = 'reference_point'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 14
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel3: TPanel
              Left = 10
              Top = 350
              Width = 974
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 37
            end
            object edtphone_1: TDBEdit
              Left = 10
              Top = 371
              Width = 150
              Height = 26
              DataField = 'phone_1'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 15
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtphone_2: TDBEdit
              Left = 170
              Top = 371
              Width = 150
              Height = 26
              DataField = 'phone_2'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 16
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtphone_3: TDBEdit
              Left = 330
              Top = 371
              Width = 152
              Height = 26
              DataField = 'phone_3'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 17
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtinternet_page: TDBEdit
              Left = 492
              Top = 371
              Width = 492
              Height = 26
              DataField = 'internet_page'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 18
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtcompany_email: TDBEdit
              Left = 10
              Top = 417
              Width = 472
              Height = 26
              DataField = 'company_email'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 19
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtfinancial_email: TDBEdit
              Left = 492
              Top = 417
              Width = 492
              Height = 26
              DataField = 'financial_email'
              DataSource = dtsPerson
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 20
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object loadZipCode: TActivityIndicator
              Left = 85
              Top = 241
              IndicatorSize = aisSmall
              IndicatorType = aitRotatingSector
            end
          end
        end
        object TabSheet1: TTabSheet
          Caption = '     Observa'#231#245'es     '
          ImageIndex = 1
          object Panel16: TPanel
            Left = 0
            Top = 0
            Width = 994
            Height = 574
            Align = alClient
            BevelOuter = bvNone
            Color = 16579576
            ParentBackground = False
            TabOrder = 0
            object Panel20: TPanel
              AlignWithMargins = True
              Left = 5
              Top = 10
              Width = 984
              Height = 25
              Margins.Left = 5
              Margins.Top = 10
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alTop
              BevelOuter = bvNone
              BorderWidth = 5
              Color = 16579576
              ParentBackground = False
              TabOrder = 0
              object Label42: TLabel
                Left = 5
                Top = 1
                Width = 134
                Height = 18
                Caption = 'Observa'#231#227'o Geral'
                Color = 16513782
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 8747344
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
              end
              object Panel21: TPanel
                Left = 5
                Top = 19
                Width = 974
                Height = 1
                Align = alBottom
                BevelOuter = bvNone
                Color = 14209468
                ParentBackground = False
                TabOrder = 0
              end
            end
            object Panel22: TPanel
              AlignWithMargins = True
              Left = 10
              Top = 40
              Width = 974
              Height = 125
              Margins.Left = 10
              Margins.Top = 0
              Margins.Right = 10
              Margins.Bottom = 10
              Align = alTop
              BevelOuter = bvNone
              Color = 16579576
              ParentBackground = False
              TabOrder = 1
              object memNote: TDBMemo
                Left = 0
                Top = 0
                Width = 974
                Height = 125
                Align = alClient
                DataField = 'note'
                DataSource = dtsPerson
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnEnter = EdtFieldEnter
                OnExit = EdtFieldExit
              end
            end
            object Panel17: TPanel
              AlignWithMargins = True
              Left = 5
              Top = 185
              Width = 984
              Height = 25
              Margins.Left = 5
              Margins.Top = 10
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alTop
              BevelOuter = bvNone
              BorderWidth = 5
              Color = 16579576
              ParentBackground = False
              TabOrder = 2
              object Label33: TLabel
                Left = 5
                Top = 1
                Width = 159
                Height = 18
                Caption = 'Observa'#231#227'o Banc'#225'ria'
                Color = 16513782
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 8747344
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
              end
              object Panel18: TPanel
                Left = 5
                Top = 19
                Width = 974
                Height = 1
                Align = alBottom
                BevelOuter = bvNone
                Color = 14209468
                ParentBackground = False
                TabOrder = 0
              end
            end
            object Panel19: TPanel
              AlignWithMargins = True
              Left = 10
              Top = 215
              Width = 974
              Height = 125
              Margins.Left = 10
              Margins.Top = 0
              Margins.Right = 10
              Margins.Bottom = 10
              Align = alTop
              BevelOuter = bvNone
              Color = 16579576
              ParentBackground = False
              TabOrder = 3
              object membank_note: TDBMemo
                Left = 0
                Top = 0
                Width = 974
                Height = 125
                Align = alClient
                DataField = 'bank_note'
                DataSource = dtsPerson
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnEnter = EdtFieldEnter
                OnExit = EdtFieldExit
              end
            end
            object Panel23: TPanel
              AlignWithMargins = True
              Left = 5
              Top = 360
              Width = 984
              Height = 25
              Margins.Left = 5
              Margins.Top = 10
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alTop
              BevelOuter = bvNone
              BorderWidth = 5
              Color = 16579576
              ParentBackground = False
              TabOrder = 4
              object Label34: TLabel
                Left = 5
                Top = 1
                Width = 168
                Height = 18
                Caption = 'Observa'#231#227'o Comercial'
                Color = 16513782
                Font.Charset = DEFAULT_CHARSET
                Font.Color = 8747344
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentColor = False
                ParentFont = False
              end
              object Panel24: TPanel
                Left = 5
                Top = 19
                Width = 974
                Height = 1
                Align = alBottom
                BevelOuter = bvNone
                Color = 14209468
                ParentBackground = False
                TabOrder = 0
              end
            end
            object Panel25: TPanel
              AlignWithMargins = True
              Left = 10
              Top = 390
              Width = 974
              Height = 125
              Margins.Left = 10
              Margins.Top = 0
              Margins.Right = 10
              Margins.Bottom = 10
              Align = alTop
              BevelOuter = bvNone
              Color = 16579576
              ParentBackground = False
              TabOrder = 5
              object memcommercial_note: TDBMemo
                Left = 0
                Top = 0
                Width = 974
                Height = 125
                Align = alClient
                DataField = 'commercial_note'
                DataSource = dtsPerson
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -15
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                TabOrder = 0
                OnEnter = EdtFieldEnter
                OnExit = EdtFieldExit
              end
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = '     Contatos     '
          ImageIndex = 2
          object pnlContact: TPanel
            Left = 0
            Top = 0
            Width = 994
            Height = 574
            Align = alClient
            BevelOuter = bvNone
            Color = 16579576
            ParentBackground = False
            TabOrder = 0
            object dbgPersonContactList: TJvDBGrid
              Left = 0
              Top = 45
              Width = 994
              Height = 529
              Cursor = crHandPoint
              Align = alClient
              Color = clWhite
              DataSource = dtsPersonContactList
              DrawingStyle = gdsGradient
              FixedColor = 16579576
              GradientEndColor = 16381936
              GradientStartColor = 15920607
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = []
              Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgTitleClick, dgTitleHotTrack]
              ParentFont = False
              TabOrder = 0
              TitleFont.Charset = DEFAULT_CHARSET
              TitleFont.Color = 8747344
              TitleFont.Height = -13
              TitleFont.Name = 'Tahoma'
              TitleFont.Style = [fsBold]
              OnCellClick = dbgPersonContactListCellClick
              OnDrawColumnCell = dbgPersonContactListDrawColumnCell
              OnDblClick = btnPersonContactListEditClick
              AlternateRowColor = 16381936
              SelectColumnsDialogStrings.Caption = 'Select columns'
              SelectColumnsDialogStrings.OK = '&OK'
              SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
              EditControls = <>
              RowsHeight = 22
              TitleRowHeight = 20
              Columns = <
                item
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'action_edit'
                  Title.Alignment = taCenter
                  Title.Caption = ' '
                  Width = 25
                  Visible = True
                end
                item
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'action_delete'
                  Title.Alignment = taCenter
                  Title.Caption = ' '
                  Width = 25
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'name'
                  Title.Caption = 'Nome'
                  Width = 346
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'phone'
                  Title.Caption = 'Telefone'
                  Width = 138
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'email'
                  Title.Caption = 'E-mail'
                  Width = 381
                  Visible = True
                end>
            end
            object Panel29: TPanel
              Left = 0
              Top = 0
              Width = 994
              Height = 45
              Align = alTop
              BevelOuter = bvNone
              Color = 16579576
              ParentBackground = False
              TabOrder = 1
              object imgPersonContactListAdd: TImage
                AlignWithMargins = True
                Left = 10
                Top = 10
                Width = 25
                Height = 25
                Cursor = crHandPoint
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                AutoSize = True
                Center = True
                Picture.Data = {
                  0954506E67496D61676589504E470D0A1A0A0000000D49484452000000190000
                  00190806000000C4E98563000000017352474200AECE1CE90000000467414D41
                  0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
                  F44944415478DA6364C003D4BAFC05181818BD1818FEC703B98A402C0AC40250
                  E907407C018837DC2ADBB8109F398CB80D67A807E204244309810940CB0A89B2
                  04688101909A0FC406441A8E0C2E303032C6DD2ADD7019A725500BF693E07A6C
                  E01F101B037D7501C3122A5900031F80D811661123D40201A8057883A8DBBB90
                  41825798E1F69B470C4D7B6611B2E801D01245644B4091DC4048D796C4490CAA
                  2272604B7CE6E711E3A306A0458D8C505FDC272698C8B0E403D0124190253140
                  CE6262749061090824822C590F6404D0D0920D204B4041A540434BDE802CF90D
                  64B0208BC61BFB3284EAB962A81607A62C3E766E301B64113A38FBF43A43FDAE
                  E9E8C21F4096FC47174D360D6028734820D6A52896442DABC410C7EA134F756B
                  866CAB700CC5A0A002814F3FBF32BCFCFC1643FED69B870C459B7BD185FF822C
                  B90D64A810E35232E3E436C892B94046120D2D590DB2240EC858488C6A322D09
                  84E5F81740CC4E034B4005A5227DCA2EB0253D417C0CFFFE828A65457C3A3A3C
                  F318E40425199E7D7ACD50B2A58F900520F340C5FD07E4FA4481015250520360
                  D627088B02EC818D860354B0201168C1069800AE3A1E54682A9061C179A091F1
                  B7CAF0D4F168961500A93E7C6AD05CDF08C40B4071802E49D000A065A036971D
                  103B21F90E6410A85C01B9782303A4EDF501971900C505DBD800F5C9E2000000
                  0049454E44AE426082}
                OnClick = btnPersonContactListAddClick
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
        Width = 73
        Height = 40
        Caption = 'Pessoa'
        ExplicitLeft = 45
        ExplicitWidth = 73
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
  object dtsPerson: TDataSource
    Left = 851
    Top = 1
  end
  object dtsPersonContactList: TDataSource
    Left = 880
    Top = 1
  end
end
