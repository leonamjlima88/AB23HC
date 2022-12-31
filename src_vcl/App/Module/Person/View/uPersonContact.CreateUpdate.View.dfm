inherited PersonContactCreateUpdateView: TPersonContactCreateUpdateView
  ClientHeight = 596
  ClientWidth = 623
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 623
  ExplicitHeight = 596
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBackground: TPanel
    Width = 623
    Height = 596
    ExplicitWidth = 623
    ExplicitHeight = 596
    inherited pnlBackground2: TPanel
      Width = 621
      Height = 549
      ExplicitWidth = 621
      ExplicitHeight = 549
      inherited imgNoSearch: TSkAnimatedImage
        Width = 521
        Height = 399
        ExplicitWidth = 521
        ExplicitHeight = 399
      end
      inherited pnlBottomButtons: TPanel
        Top = 499
        Width = 601
        ExplicitTop = 499
        ExplicitWidth = 601
        inherited pnlSave: TPanel
          Left = 431
          ExplicitLeft = 431
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
          Left = 251
          ExplicitLeft = 251
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
        Width = 601
        Height = 479
        ExplicitLeft = 10
        ExplicitTop = 10
        ExplicitWidth = 601
        ExplicitHeight = 479
        inherited tabMain: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 25
          ExplicitWidth = 593
          ExplicitHeight = 450
          inherited pnlMain: TPanel
            Width = 593
            Height = 450
            ExplicitWidth = 593
            ExplicitHeight = 450
            object Label22: TLabel
              Left = 10
              Top = 10
              Width = 46
              Height = 18
              Caption = 'Dados'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label2: TLabel
              Left = 27
              Top = 34
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
            object Label10: TLabel
              Left = 10
              Top = 34
              Width = 15
              Height = 14
              Caption = '*|'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label15: TLabel
              Left = 390
              Top = 85
              Width = 52
              Height = 14
              Caption = 'CPF/CNPJ'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label27: TLabel
              Left = 246
              Top = 85
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
            object Label31: TLabel
              Left = 26
              Top = 136
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
            object Label6: TLabel
              Left = 10
              Top = 85
              Width = 89
              Height = 14
              Caption = 'Tipo de contato'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label1: TLabel
              Left = 10
              Top = 197
              Width = 89
              Height = 18
              Caption = 'Observa'#231#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label3: TLabel
              Left = 230
              Top = 85
              Width = 15
              Height = 14
              Caption = '*|'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clRed
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label4: TLabel
              Left = 10
              Top = 136
              Width = 15
              Height = 14
              Caption = '*|'
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
              Width = 570
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 6
            end
            object edtname: TDBEdit
              Left = 10
              Top = 49
              Width = 570
              Height = 26
              DataField = 'name'
              DataSource = dtsPersonContact
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
            end
            object edtein: TDBEdit
              Left = 390
              Top = 100
              Width = 190
              Height = 26
              DataField = 'legal_entity_number'
              DataSource = dtsPersonContact
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 3
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
            end
            object edtphone: TDBEdit
              Left = 230
              Top = 100
              Width = 150
              Height = 26
              DataField = 'phone'
              DataSource = dtsPersonContact
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
            end
            object edtemail: TDBEdit
              Left = 10
              Top = 151
              Width = 570
              Height = 26
              DataField = 'email'
              DataSource = dtsPersonContact
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
            end
            object cbxtype: TDBComboBox
              Left = 10
              Top = 100
              Width = 210
              Height = 26
              AutoDropDown = True
              DataField = 'type'
              DataSource = dtsPersonContact
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              Items.Strings = (
                'Celular'
                'Telefone Fixo'
                'Fax'
                'Outros')
              ParentFont = False
              TabOrder = 1
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
            end
            object Panel1: TPanel
              Left = 10
              Top = 215
              Width = 570
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 7
            end
            object memNote: TDBMemo
              Left = 10
              Top = 226
              Width = 570
              Height = 211
              DataField = 'note'
              DataSource = dtsPersonContact
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 5
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
            end
          end
        end
      end
    end
    inherited pnlTitle: TPanel
      Width = 621
      ExplicitWidth = 621
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
        Width = 193
        Height = 40
        Caption = 'Pessoa > Contato'
        ExplicitLeft = 45
        ExplicitWidth = 193
      end
      inherited imgCloseTitle: TImage
        Left = 586
        ExplicitLeft = 563
      end
      inherited imgMinimizeTitle: TImage
        Left = 551
        ExplicitLeft = 528
      end
    end
  end
  object dtsPersonContact: TDataSource
    Left = 440
    Top = 1
  end
end
