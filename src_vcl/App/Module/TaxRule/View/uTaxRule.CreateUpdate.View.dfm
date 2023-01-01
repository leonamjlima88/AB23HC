inherited TaxRuleCreateUpdateView: TTaxRuleCreateUpdateView
  ClientWidth = 603
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  ExplicitWidth = 603
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBackground: TPanel
    Width = 603
    ExplicitWidth = 603
    inherited pnlBackground2: TPanel
      Width = 601
      ExplicitWidth = 601
      inherited imgNoSearch: TSkAnimatedImage
        Width = 501
        ExplicitWidth = 501
      end
      inherited pnlBottomButtons: TPanel
        Width = 581
        ExplicitWidth = 581
        inherited pnlSave: TPanel
          Left = 411
          ExplicitLeft = 411
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
          Left = 231
          ExplicitLeft = 231
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
        Width = 581
        ExplicitWidth = 581
        inherited tabMain: TTabSheet
          ExplicitLeft = 4
          ExplicitTop = 25
          ExplicitWidth = 573
          ExplicitHeight = 574
          inherited pnlMain: TPanel
            Width = 573
            ExplicitWidth = 573
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
            object Label3: TLabel
              Left = 20
              Top = 80
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
            object Label5: TLabel
              Left = 10
              Top = 80
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
            object Label23: TLabel
              Left = 10
              Top = 126
              Width = 123
              Height = 14
              Caption = 'F1 - Tipo de Opera'#231#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label1: TLabel
              Left = 10
              Top = 211
              Width = 58
              Height = 18
              Caption = 'Estados'
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
              Width = 550
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 0
            end
            object edtId: TDBEdit
              Left = 10
              Top = 49
              Width = 50
              Height = 26
              TabStop = False
              Color = 16053492
              DataField = 'id'
              DataSource = dtsTaxRule
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
              OnClick = EdtFieldClick
              OnKeyDown = EdtFieldKeyDown
            end
            object edtname: TDBEdit
              Left = 10
              Top = 95
              Width = 550
              Height = 26
              DataField = 'name'
              DataSource = dtsTaxRule
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
            object edtoperation_type_id: TDBEdit
              Left = 37
              Top = 141
              Width = 50
              Height = 26
              DataField = 'operation_type_id'
              DataSource = dtsTaxRule
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
            object Panel10: TPanel
              Left = 10
              Top = 141
              Width = 26
              Height = 26
              Cursor = crHandPoint
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 5327153
              ParentBackground = False
              TabOrder = 4
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
                object imgLocaOperationType: TImage
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
                  OnClick = imgLocaOperationTypeClick
                  ExplicitTop = 14
                  ExplicitWidth = 18
                  ExplicitHeight = 18
                end
              end
            end
            object edtoperation_type_name: TDBEdit
              Left = 88
              Top = 141
              Width = 472
              Height = 26
              Color = 16053492
              DataField = 'operation_type_name'
              DataSource = dtsTaxRule
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 5
              OnKeyDown = EdtFieldKeyDown
            end
            object chkis_final_customer: TDBCheckBox
              Tag = 1
              Left = 10
              Top = 173
              Width = 108
              Height = 20
              Cursor = crHandPoint
              TabStop = False
              Caption = 'Consumidor Final'
              DataField = 'is_final_customer'
              DataSource = dtsTaxRule
              TabOrder = 6
              ValueChecked = '1'
              ValueUnchecked = '0'
            end
            object Panel1: TPanel
              Left = 10
              Top = 229
              Width = 550
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 7
            end
            object pnlContact: TPanel
              Left = 10
              Top = 236
              Width = 550
              Height = 327
              BevelOuter = bvNone
              Color = 16579576
              ParentBackground = False
              TabOrder = 8
              object dbgTaxRuleStateList: TJvDBGrid
                Left = 0
                Top = 30
                Width = 550
                Height = 297
                Cursor = crHandPoint
                Align = alClient
                Color = clWhite
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
                OnCellClick = dbgTaxRuleStateListCellClick
                OnDrawColumnCell = dbgTaxRuleStateListDrawColumnCell
                OnDblClick = btnTaxRuleStateListEditClick
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
                    FieldName = 'target_state'
                    Title.Caption = 'UF de Destino'
                    Width = 156
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'cfop_code'
                    Title.Caption = 'CFOP'
                    Width = 69
                    Visible = True
                  end>
              end
              object Panel29: TPanel
                Left = 0
                Top = 0
                Width = 550
                Height = 30
                Align = alTop
                BevelOuter = bvNone
                Color = 16579576
                ParentBackground = False
                TabOrder = 1
                object imgPersonContactAppend: TImage
                  AlignWithMargins = True
                  Left = 0
                  Top = 0
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
                  OnClick = imgPersonContactAppendClick
                end
              end
            end
          end
        end
      end
    end
    inherited pnlTitle: TPanel
      Width = 601
      ExplicitWidth = 601
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
        Width = 130
        Height = 40
        Caption = 'Regra Fiscal'
        ExplicitLeft = 45
        ExplicitWidth = 130
      end
      inherited imgCloseTitle: TImage
        Left = 566
        OnClick = btnCancelClick
        ExplicitLeft = 563
      end
      inherited imgMinimizeTitle: TImage
        Left = 531
        ExplicitLeft = 528
      end
    end
  end
  object dtsTaxRule: TDataSource
    Left = 459
    Top = 1
  end
  object dtsTaxRuleStateList: TDataSource
    Left = 488
    Top = 1
  end
end
