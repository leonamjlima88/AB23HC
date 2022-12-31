inherited ChartOfAccountCreateUpdateView: TChartOfAccountCreateUpdateView
  ClientHeight = 600
  ClientWidth = 600
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 600
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBackground: TPanel
    Width = 600
    Height = 600
    ExplicitWidth = 600
    ExplicitHeight = 600
    inherited pnlBackground2: TPanel
      Width = 598
      Height = 553
      ExplicitWidth = 598
      ExplicitHeight = 553
      inherited imgNoSearch: TSkAnimatedImage
        Width = 498
        Height = 403
        ExplicitWidth = 498
        ExplicitHeight = 403
      end
      inherited pnlBottomButtons: TPanel
        Top = 503
        Width = 578
        ExplicitTop = 503
        ExplicitWidth = 578
        inherited pnlSave: TPanel
          Left = 408
          ExplicitLeft = 408
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
          Left = 228
          ExplicitLeft = 228
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
        Width = 578
        Height = 483
        ExplicitWidth = 578
        ExplicitHeight = 483
        inherited tabMain: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 25
          ExplicitWidth = 570
          ExplicitHeight = 454
          inherited pnlMain: TPanel
            Width = 570
            Height = 454
            ExplicitWidth = 570
            ExplicitHeight = 454
            object Label35: TLabel
              Left = 10
              Top = 34
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
              Left = 20
              Top = 182
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
              Top = 182
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
            object Label3: TLabel
              Left = 20
              Top = 136
              Width = 112
              Height = 14
              Caption = 'C'#243'digo de Hierarquia'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label4: TLabel
              Left = 10
              Top = 136
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
              Left = 10
              Top = 228
              Width = 63
              Height = 14
              Caption = 'Observa'#231#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object edtId: TDBEdit
              Left = 10
              Top = 49
              Width = 50
              Height = 26
              TabStop = False
              Color = 16053492
              DataField = 'id'
              DataSource = dtsChartOfAccount
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 4
              OnClick = EdtFieldClick
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel1: TPanel
              Left = 10
              Top = 28
              Width = 550
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 5
            end
            object edtname: TDBEdit
              Left = 10
              Top = 197
              Width = 550
              Height = 26
              DataField = 'name'
              DataSource = dtsChartOfAccount
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
            object edthierarchy_code: TDBEdit
              Left = 10
              Top = 151
              Width = 179
              Height = 26
              DataField = 'hierarchy_code'
              DataSource = dtsChartOfAccount
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
            object DBRadioGroup1: TDBRadioGroup
              Left = 10
              Top = 85
              Width = 179
              Height = 41
              Caption = ' Tipo de Conta '
              Columns = 2
              DataField = 'is_analytical'
              DataSource = dtsChartOfAccount
              Items.Strings = (
                'Sint'#233'tico'
                'Anal'#237'tico')
              TabOrder = 0
              Values.Strings = (
                '0'
                '1')
            end
            object DBMemo1: TDBMemo
              Left = 10
              Top = 243
              Width = 550
              Height = 150
              DataField = 'note'
              DataSource = dtsChartOfAccount
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
          end
        end
      end
    end
    inherited pnlTitle: TPanel
      Width = 598
      ExplicitWidth = 598
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
        Width = 169
        Height = 40
        Caption = 'Plano de Conta'
        ExplicitLeft = 45
        ExplicitWidth = 169
      end
      inherited imgCloseTitle: TImage
        Left = 563
        OnClick = btnCancelClick
        ExplicitLeft = 563
      end
      inherited imgMinimizeTitle: TImage
        Left = 528
        ExplicitLeft = 528
      end
    end
  end
  object dtsChartOfAccount: TDataSource
    Left = 851
    Top = 1
  end
end
