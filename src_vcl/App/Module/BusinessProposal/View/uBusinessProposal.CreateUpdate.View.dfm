inherited BusinessProposalCreateUpdateView: TBusinessProposalCreateUpdateView
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
              Width = 96
              Height = 18
              Caption = 'Proposta N'#186':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object Label1: TLabel
              Left = 362
              Top = 126
              Width = 95
              Height = 14
              Caption = 'Validade da Prop.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label3: TLabel
              Left = 352
              Top = 126
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
            object Label37: TLabel
              Left = 10
              Top = 80
              Width = 62
              Height = 14
              Caption = 'F1 - Cliente'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label5: TLabel
              Left = 352
              Top = 172
              Width = 118
              Height = 14
              Caption = 'Status da Negocia'#231#227'o'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label11: TLabel
              Left = 10
              Top = 172
              Width = 109
              Height = 14
              Caption = 'Previs'#227'o de entrega'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label12: TLabel
              Left = 10
              Top = 126
              Width = 56
              Height = 14
              Caption = 'Solicitante'
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
            object Label4: TLabel
              Left = 20
              Top = 34
              Width = 158
              Height = 14
              Caption = 'F1 - Vendedor / Respons'#225'vel'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object Label2: TLabel
              Left = 10
              Top = 233
              Width = 149
              Height = 18
              Caption = 'Produtos / Servi'#231'os'
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
              Width = 974
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 8
            end
            object edtId: TDBEdit
              Left = 111
              Top = 10
              Width = 58
              Height = 18
              TabStop = False
              BorderStyle = bsNone
              Color = 16579576
              DataField = 'id'
              DataSource = dtsBusinessProposal
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Calibri'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 9
              OnClick = EdtFieldClick
              OnKeyDown = EdtFieldKeyDown
            end
            object JvDBDateEdit1: TJvDBDateEdit
              Left = 352
              Top = 141
              Width = 130
              Height = 26
              DataField = 'expiration_date'
              DataSource = dtsBusinessProposal
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ShowNullDate = False
              TabOrder = 5
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object edtperson_name: TDBEdit
              Left = 88
              Top = 95
              Width = 394
              Height = 26
              Color = 16053492
              DataField = 'person_name'
              DataSource = dtsBusinessProposal
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 3
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel41: TPanel
              Left = 10
              Top = 95
              Width = 26
              Height = 26
              Cursor = crHandPoint
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 5327153
              ParentBackground = False
              TabOrder = 10
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
                object imgLocaPerson: TImage
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
                  OnClick = imgLocaPersonClick
                  ExplicitTop = 14
                  ExplicitWidth = 18
                  ExplicitHeight = 18
                end
              end
            end
            object edtperson_id: TDBEdit
              Left = 37
              Top = 95
              Width = 50
              Height = 26
              DataField = 'person_id'
              DataSource = dtsBusinessProposal
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
            object JvDBComboBox1: TJvDBComboBox
              Left = 352
              Top = 187
              Width = 130
              Height = 26
              DataField = 'status'
              DataSource = dtsBusinessProposal
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              Items.Strings = (
                'Pendente'
                'Conclu'#237'do'
                'Cancelado')
              ParentFont = False
              TabOrder = 7
              TabStop = False
              UpdateFieldImmediatelly = True
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
            object DBEdit1: TDBEdit
              Left = 10
              Top = 187
              Width = 332
              Height = 26
              DataField = 'delivery_forecast'
              DataSource = dtsBusinessProposal
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
            end
            object DBEdit4: TDBEdit
              Left = 10
              Top = 141
              Width = 332
              Height = 26
              DataField = 'requester'
              DataSource = dtsBusinessProposal
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
            object edtseller_name: TDBEdit
              Left = 88
              Top = 49
              Width = 394
              Height = 26
              Color = 16053492
              DataField = 'seller_name'
              DataSource = dtsBusinessProposal
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clGray
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
              OnKeyDown = EdtFieldKeyDown
            end
            object Panel4: TPanel
              Left = 10
              Top = 49
              Width = 26
              Height = 26
              Cursor = crHandPoint
              BevelOuter = bvNone
              BorderWidth = 1
              Color = 5327153
              ParentBackground = False
              TabOrder = 11
              object Panel1: TPanel
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
                object imgLocaSeller: TImage
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
                  OnClick = imgLocaSellerClick
                  ExplicitTop = 14
                  ExplicitWidth = 18
                  ExplicitHeight = 18
                end
              end
            end
            object edtseller_id: TDBEdit
              Left = 37
              Top = 49
              Width = 50
              Height = 26
              DataField = 'seller_id'
              DataSource = dtsBusinessProposal
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
              OnClick = EdtFieldClick
              OnEnter = EdtFieldEnter
              OnExit = EdtFieldExit
              OnKeyDown = EdtFieldKeyDown
            end
            object pgcNote: TPageControl
              Left = 492
              Top = 36
              Width = 492
              Height = 177
              ActivePage = TabSheet1
              TabOrder = 12
              TabStop = False
              object TabSheet1: TTabSheet
                Caption = '   Observa'#231#227'o Impressa   '
                object Panel12: TPanel
                  Left = 0
                  Top = 0
                  Width = 484
                  Height = 148
                  Align = alClient
                  BevelOuter = bvNone
                  BorderWidth = 1
                  Color = clSilver
                  ParentBackground = False
                  TabOrder = 0
                  object DBMemo1: TDBMemo
                    Left = 1
                    Top = 1
                    Width = 482
                    Height = 146
                    TabStop = False
                    Align = alClient
                    BorderStyle = bsNone
                    DataField = 'note'
                    DataSource = dtsBusinessProposal
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
                end
              end
              object TabSheet2: TTabSheet
                Caption = '   Observa'#231#227'o Interna   '
                ImageIndex = 1
                object Panel13: TPanel
                  Left = 0
                  Top = 0
                  Width = 484
                  Height = 148
                  Align = alClient
                  BevelOuter = bvNone
                  BorderWidth = 1
                  Color = clSilver
                  ParentBackground = False
                  TabOrder = 0
                  object DBMemo2: TDBMemo
                    Left = 1
                    Top = 1
                    Width = 482
                    Height = 146
                    TabStop = False
                    Align = alClient
                    BorderStyle = bsNone
                    DataField = 'internal_note'
                    DataSource = dtsBusinessProposal
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
                end
              end
              object TabSheet3: TTabSheet
                Caption = '   Condi'#231#245'es de Pagamento   '
                ImageIndex = 2
                object Panel14: TPanel
                  Left = 0
                  Top = 0
                  Width = 484
                  Height = 148
                  Align = alClient
                  BevelOuter = bvNone
                  BorderWidth = 1
                  Color = clSilver
                  ParentBackground = False
                  TabOrder = 0
                  object DBMemo3: TDBMemo
                    Left = 1
                    Top = 1
                    Width = 482
                    Height = 146
                    TabStop = False
                    Align = alClient
                    BorderStyle = bsNone
                    DataField = 'payment_term_note'
                    DataSource = dtsBusinessProposal
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
                end
              end
            end
            object Panel2: TPanel
              Left = 10
              Top = 251
              Width = 974
              Height = 1
              BevelOuter = bvNone
              Color = 14209468
              ParentBackground = False
              TabOrder = 13
            end
            object Panel6: TPanel
              AlignWithMargins = True
              Left = 10
              Top = 257
              Width = 974
              Height = 307
              Margins.Left = 10
              Margins.Top = 0
              Margins.Right = 10
              Margins.Bottom = 10
              Anchors = [akLeft, akTop, akRight, akBottom]
              BevelOuter = bvNone
              Color = 16579576
              ParentBackground = False
              TabOrder = 14
              object dbgBusinessProposalItemList: TJvDBGrid
                Left = 0
                Top = 51
                Width = 974
                Height = 226
                Cursor = crHandPoint
                Align = alClient
                Color = clWhite
                DrawingStyle = gdsGradient
                FixedColor = 15131349
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
                OnCellClick = dbgBusinessProposalItemListCellClick
                OnDrawColumnCell = dbgBusinessProposalItemListDrawColumnCell
                OnDblClick = btnBusinessProposalItemListEditClick
                AlternateRowColor = 16579576
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
                    FieldName = 'product_name'
                    Title.Caption = 'Item'
                    Width = 316
                    Visible = True
                  end
                  item
                    Alignment = taRightJustify
                    Expanded = False
                    FieldName = 'quantity'
                    Title.Alignment = taRightJustify
                    Title.Caption = 'Qde'
                    Width = 60
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'product_unit_name'
                    Title.Caption = 'Unid.'
                    Width = 50
                    Visible = True
                  end
                  item
                    Alignment = taRightJustify
                    Expanded = False
                    FieldName = 'price'
                    Title.Alignment = taRightJustify
                    Title.Caption = 'Pre'#231'o Unit.'
                    Width = 80
                    Visible = True
                  end
                  item
                    Alignment = taRightJustify
                    Expanded = False
                    FieldName = 'unit_discount'
                    Title.Alignment = taRightJustify
                    Title.Caption = 'Desc. Unit.'
                    Width = 80
                    Visible = True
                  end
                  item
                    Alignment = taRightJustify
                    Expanded = False
                    FieldName = 'subtotal'
                    Title.Alignment = taRightJustify
                    Title.Caption = 'Subtotal'
                    Width = 90
                    Visible = True
                  end
                  item
                    Alignment = taRightJustify
                    Expanded = False
                    FieldName = 'total'
                    Font.Charset = DEFAULT_CHARSET
                    Font.Color = clGreen
                    Font.Height = -15
                    Font.Name = 'Tahoma'
                    Font.Style = [fsBold]
                    Title.Alignment = taRightJustify
                    Title.Caption = 'Total'
                    Width = 120
                    Visible = True
                  end
                  item
                    Expanded = False
                    FieldName = 'note'
                    Title.Caption = 'Detalhes'
                    Width = 300
                    Visible = True
                  end>
              end
              object Panel9: TPanel
                Left = 0
                Top = 0
                Width = 974
                Height = 51
                Align = alTop
                BevelOuter = bvNone
                Color = 16579576
                ParentBackground = False
                TabOrder = 1
                DesignSize = (
                  974
                  51)
                object Label8: TLabel
                  Left = 0
                  Top = 35
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
                object Label15: TLabel
                  Left = 177
                  Top = 8
                  Width = 51
                  Height = 14
                  Caption = 'Descri'#231#227'o'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  Transparent = True
                end
                object Label23: TLabel
                  Left = 734
                  Top = 8
                  Width = 61
                  Height = 14
                  Anchors = [akTop, akRight]
                  Caption = 'Pre'#231'o Unit.'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  Transparent = True
                end
                object Label24: TLabel
                  Left = 651
                  Top = 8
                  Width = 63
                  Height = 14
                  Anchors = [akTop, akRight]
                  Caption = 'Quantidade'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  Transparent = True
                end
                object Label25: TLabel
                  Left = 857
                  Top = 8
                  Width = 72
                  Height = 14
                  Anchors = [akTop, akRight]
                  Caption = 'Total (Enter)'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  Transparent = True
                end
                object Label27: TLabel
                  Left = 719
                  Top = 27
                  Width = 10
                  Height = 18
                  Alignment = taRightJustify
                  Anchors = [akTop, akRight]
                  Caption = 'X'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -15
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  Transparent = True
                end
                object Label28: TLabel
                  Left = 843
                  Top = 27
                  Width = 9
                  Height = 18
                  Alignment = taRightJustify
                  Anchors = [akTop, akRight]
                  Caption = '='
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -15
                  Font.Name = 'Arial'
                  Font.Style = [fsBold]
                  ParentFont = False
                  Transparent = True
                end
                object imgbusiness_proposal_item_append: TImage
                  Left = 948
                  Top = 23
                  Width = 26
                  Height = 26
                  Cursor = crHandPoint
                  Anchors = [akTop, akRight]
                  AutoSize = True
                  ParentShowHint = False
                  Picture.Data = {
                    0954506E67496D61676589504E470D0A1A0A0000000D494844520000001A0000
                    001A0806000000A94A4CCE000000017352474200AECE1CE90000000467414D41
                    0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
                    8C4944415478DA6354EBF237606060980FC4BA40CCCC407D700E8893198116DD
                    02325469600132780DB2E83F8D2D0183C165111F3B3783BDB23183388F308AF8
                    F69B47199E7E7C453D8B0A6D6318322C4230C43FFDFCCA6035259EE1F7BF3FD4
                    B16856702D83BD92315639F739590C0FDE3F1BB568385A044ACA813A4E0CACCC
                    2C70310F752B065D09EC85C7C2B39B195E7D7907E71FB87786E1CE9BC7842DB2
                    5630609817DA40D085B8C0C17B6719D2D636131774F8820A1F00E5ABA4550D0C
                    975FDC26CE2250F02D8FEE6050119625C9A2DA9DD318565DDA85550E67625010
                    9462D899328D684B4071D5B66F2E4E79BCA90E147CA06024048E3EB8C050B0A9
                    1B1C7464590402F52EE90C51869E38E541856AC892528677DF3EE2750C51F968
                    7954078391B40686F8F7DF3F194AB6F631ECB97D92A0AF89AE2636C4F73348F3
                    8BA188771F5CC830E7D47A8296106D1108A888C8326C4D9C0CE7138A7CB22D02
                    0150E228734800C747F6FA76BC914F91459400BA5A741F482BD0D89E7B208B1C
                    800C50B9C14A234BDE02710A0023AABC32C07C1C6D0000000049454E44AE4260
                    82}
                  ShowHint = False
                  OnClick = imgbusiness_proposal_item_appendClick
                end
                object Label9: TLabel
                  Left = 0
                  Top = 8
                  Width = 75
                  Height = 14
                  Caption = 'F2 - Ref./EAN'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -12
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  Transparent = True
                end
                object Panel10: TPanel
                  Left = 0
                  Top = 23
                  Width = 26
                  Height = 26
                  Cursor = crHandPoint
                  BevelOuter = bvNone
                  BorderWidth = 1
                  Color = 5327153
                  ParentBackground = False
                  TabOrder = 5
                  object Panel11: TPanel
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
                    object imgbusiness_proposal_item_loca_product: TImage
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
                      OnClick = imgbusiness_proposal_item_loca_productClick
                      ExplicitTop = 14
                      ExplicitWidth = 18
                      ExplicitHeight = 18
                    end
                  end
                end
                object edtbusiness_proposal_item_id: TJvValidateEdit
                  Tag = 1
                  Left = 27
                  Top = 23
                  Width = 140
                  Height = 26
                  Alignment = taLeftJustify
                  CheckChars = '01234567890'
                  Color = clWhite
                  CriticalPoints.MaxValueIncluded = False
                  CriticalPoints.MinValueIncluded = False
                  DisplayFormat = dfNone
                  Font.Charset = ANSI_CHARSET
                  Font.Color = 7754764
                  Font.Height = -15
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = False
                  TabOrder = 0
                  OnClick = EdtFieldClick
                  OnEnter = EdtFieldEnter
                  OnExit = EdtFieldExit
                  OnKeyDown = EdtFieldKeyDown
                end
                object edtbusiness_proposal_item_name: TEdit
                  Tag = 1
                  Left = 177
                  Top = 23
                  Width = 464
                  Height = 26
                  Anchors = [akLeft, akTop, akRight]
                  Color = 16053492
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clGray
                  Font.Height = -15
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  MaxLength = 85
                  ParentFont = False
                  ReadOnly = True
                  TabOrder = 1
                  OnKeyDown = EdtFieldKeyDown
                end
                object edtbusiness_proposal_item_price: TJvValidateEdit
                  Tag = 1
                  Left = 734
                  Top = 23
                  Width = 104
                  Height = 26
                  Anchors = [akTop, akRight]
                  Color = clWhite
                  CriticalPoints.MaxValueIncluded = False
                  CriticalPoints.MinValueIncluded = False
                  DisplayFormat = dfFloat
                  DecimalPlaces = 2
                  Font.Charset = ANSI_CHARSET
                  Font.Color = 7754764
                  Font.Height = -15
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = False
                  TabOrder = 3
                  OnClick = EdtFieldClick
                  OnEnter = EdtFieldEnter
                  OnExit = EdtFieldExit
                  OnKeyDown = EdtFieldKeyDown
                end
                object edtbusiness_proposal_item_quantity: TJvValidateEdit
                  Tag = 1
                  Left = 651
                  Top = 23
                  Width = 64
                  Height = 26
                  Anchors = [akTop, akRight]
                  Color = clWhite
                  CriticalPoints.MaxValueIncluded = False
                  CriticalPoints.MinValueIncluded = False
                  DisplayFormat = dfFloat
                  DecimalPlaces = 2
                  Font.Charset = ANSI_CHARSET
                  Font.Color = 7754764
                  Font.Height = -15
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = False
                  TabOrder = 2
                  OnClick = EdtFieldClick
                  OnEnter = EdtFieldEnter
                  OnExit = EdtFieldExit
                  OnKeyDown = EdtFieldKeyDown
                end
                object edtbusiness_proposal_item_total: TJvValidateEdit
                  Tag = 1
                  Left = 857
                  Top = 23
                  Width = 90
                  Height = 26
                  Anchors = [akTop, akRight]
                  Color = 16053492
                  CriticalPoints.MaxValueIncluded = False
                  CriticalPoints.MinValueIncluded = False
                  DisplayFormat = dfFloat
                  DecimalPlaces = 2
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clGreen
                  Font.Height = -15
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  ParentShowHint = False
                  ReadOnly = True
                  ShowHint = True
                  TabOrder = 4
                  OnClick = EdtFieldClick
                  OnKeyDown = EdtFieldKeyDown
                  OnKeyPress = edtbusiness_proposal_item_totalKeyPress
                end
                object chkItemReadAndInsert: TCheckBox
                  Left = 92
                  Top = 5
                  Width = 75
                  Height = 17
                  TabStop = False
                  Caption = 'Ler e Lan'#231'ar'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Height = -11
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  TabOrder = 6
                end
              end
              object Panel15: TPanel
                AlignWithMargins = True
                Left = 0
                Top = 282
                Width = 974
                Height = 25
                Margins.Left = 0
                Margins.Top = 5
                Margins.Right = 0
                Margins.Bottom = 0
                Align = alBottom
                BevelOuter = bvNone
                Color = 16579576
                Enabled = False
                ParentBackground = False
                TabOrder = 2
                object Label6: TLabel
                  AlignWithMargins = True
                  Left = 756
                  Top = 0
                  Width = 53
                  Height = 25
                  Margins.Left = 10
                  Margins.Top = 0
                  Margins.Right = 0
                  Margins.Bottom = 0
                  Align = alRight
                  Caption = 'Total:'
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clBlack
                  Font.Height = -21
                  Font.Name = 'Tahoma'
                  Font.Style = []
                  ParentFont = False
                  Transparent = True
                  ExplicitLeft = 787
                end
                object edtsum_business_proposal_item_total: TDBEdit
                  Tag = 1
                  AlignWithMargins = True
                  Left = 819
                  Top = 0
                  Width = 155
                  Height = 25
                  Margins.Left = 10
                  Margins.Top = 0
                  Margins.Right = 0
                  Margins.Bottom = 0
                  Align = alRight
                  BorderStyle = bsNone
                  Color = 16579576
                  DataField = 'sum_business_proposal_item_total'
                  DataSource = dtsBusinessProposal
                  Font.Charset = ANSI_CHARSET
                  Font.Color = clGreen
                  Font.Height = -21
                  Font.Name = 'Tahoma'
                  Font.Style = [fsBold]
                  ParentFont = False
                  ParentShowHint = False
                  ShowHint = False
                  TabOrder = 0
                  OnClick = EdtFieldClick
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
        Width = 214
        Height = 40
        Caption = 'Proposta Comercial'
        ExplicitLeft = 45
        ExplicitWidth = 214
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
  object dtsBusinessProposal: TDataSource
    Left = 851
    Top = 1
  end
  object dtsBusinessProposalItemList: TDataSource
    Left = 880
    Top = 1
  end
end
