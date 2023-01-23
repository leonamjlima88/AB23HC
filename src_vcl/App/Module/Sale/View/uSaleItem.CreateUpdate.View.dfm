inherited SaleItemCreateUpdateView: TSaleItemCreateUpdateView
  ClientHeight = 486
  ClientWidth = 623
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 623
  ExplicitHeight = 486
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBackground: TPanel
    Width = 623
    Height = 486
    ExplicitWidth = 623
    ExplicitHeight = 486
    inherited pnlBackground2: TPanel
      Width = 621
      Height = 439
      ExplicitWidth = 621
      ExplicitHeight = 439
      inherited imgNoSearch: TSkAnimatedImage
        Width = 521
        Height = 289
        ExplicitWidth = 521
        ExplicitHeight = 289
      end
      inherited pnlBottomButtons: TPanel
        Top = 389
        Width = 601
        ExplicitTop = 389
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
        Height = 369
        ExplicitWidth = 601
        ExplicitHeight = 369
        inherited tabMain: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 25
          ExplicitWidth = 593
          ExplicitHeight = 340
          inherited pnlMain: TPanel
            Width = 593
            Height = 340
            ExplicitWidth = 593
            ExplicitHeight = 340
            object Label22: TLabel
              Left = 10
              Top = 10
              Width = 133
              Height = 18
              Caption = 'Produto / Servi'#231'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label3: TLabel
              Left = 10
              Top = 93
              Width = 63
              Height = 14
              Caption = 'Quantidade'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label1: TLabel
              Left = 150
              Top = 93
              Width = 31
              Height = 14
              Caption = 'Pre'#231'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label2: TLabel
              Left = 370
              Top = 93
              Width = 82
              Height = 14
              Caption = 'Desconto Unit.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label5: TLabel
              Left = 480
              Top = 93
              Width = 28
              Height = 14
              Caption = 'Total'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label4: TLabel
              Left = 260
              Top = 93
              Width = 46
              Height = 14
              Caption = 'Subtotal'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label6: TLabel
              Left = 10
              Top = 69
              Width = 57
              Height = 18
              Caption = 'Valores'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label7: TLabel
              Left = 10
              Top = 154
              Width = 66
              Height = 18
              Caption = 'Detalhes'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
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
            object edtproduct_name: TDBEdit
              Left = 10
              Top = 33
              Width = 570
              Height = 26
              TabStop = False
              BorderStyle = bsNone
              CharCase = ecUpperCase
              Color = 16579576
              DataField = 'product_name'
              DataSource = dtsSaleItem
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 7
              OnKeyDown = FormKeyDown
            end
            object edtquantity: TDBEdit
              Left = 10
              Top = 108
              Width = 79
              Height = 26
              DataField = 'quantity'
              DataSource = dtsSaleItem
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit1: TDBEdit
              Left = 150
              Top = 108
              Width = 100
              Height = 26
              DataField = 'price'
              DataSource = dtsSaleItem
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit2: TDBEdit
              Left = 370
              Top = 108
              Width = 100
              Height = 26
              DataField = 'unit_discount'
              DataSource = dtsSaleItem
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clOlive
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit5: TDBEdit
              Left = 480
              Top = 108
              Width = 100
              Height = 26
              Color = 16579576
              DataField = 'total'
              DataSource = dtsSaleItem
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGreen
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 5
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
              OnKeyPress = DBEdit5KeyPress
            end
            object DBEdit6: TDBEdit
              Left = 90
              Top = 108
              Width = 50
              Height = 26
              TabStop = False
              Color = 16579576
              DataField = 'product_unit_name'
              DataSource = dtsSaleItem
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
              OnKeyDown = EdtFieldKeyDown
            end
            object DBEdit3: TDBEdit
              Left = 260
              Top = 108
              Width = 100
              Height = 26
              TabStop = False
              Color = 16579576
              DataField = 'subtotal'
              DataSource = dtsSaleItem
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel1: TPanel
              Left = 10
              Top = 87
              Width = 570
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 8
            end
            object memNote: TDBMemo
              Left = 10
              Top = 178
              Width = 570
              Height = 146
              DataField = 'note'
              DataSource = dtsSaleItem
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 9
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
            end
            object Panel2: TPanel
              Left = 10
              Top = 172
              Width = 570
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 10
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
        Width = 177
        Height = 40
        Caption = 'Proposta > Item'
        ExplicitLeft = 45
        ExplicitWidth = 177
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
  object dtsSaleItem: TDataSource
    Left = 440
    Top = 1
  end
end
