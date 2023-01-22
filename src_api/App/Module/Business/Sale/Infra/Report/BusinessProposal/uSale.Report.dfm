inherited SaleReport: TSaleReport
  Caption = ''
  PixelsPerInch = 96
  TextHeight = 13
  inherited RLReport1: TRLReport
    DataSource = dtsSaleItem
    inherited bndHeader: TRLBand
      inherited memCompanyAliasName: TRLMemo
        Width = 459
        WordWrap = False
        ExplicitWidth = 459
      end
    end
    inherited bndFooter: TRLBand
      Top = 600
      ExplicitTop = 600
    end
    object RLBand1: TRLBand
      Left = 38
      Top = 207
      Width = 718
      Height = 128
      AutoExpand = False
      BandType = btHeader
      object RLPanel1: TRLPanel
        Left = 498
        Top = 0
        Width = 220
        Height = 128
        Align = faRight
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.Color = clSilver
        object RLLabel5: TRLLabel
          Left = 1
          Top = 1
          Width = 218
          Height = 19
          Align = faTop
          AutoSize = False
          Behavior = [beSiteExpander]
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Borders.Color = clSilver
          Caption = ' Contato'
          Color = 16382457
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object memPersonContact: TRLMemo
          Left = 11
          Top = 25
          Width = 198
          Height = 96
          Behavior = [beSiteExpander]
          Lines.Strings = (
            '(00) 0 0000-0000'
            '(00) 0 0000-0000'
            '(00) 0 0000-0000'
            ''
            'email@dominio.com.br'
            'email@dominio.com.br')
        end
      end
      object RLPanel2: TRLPanel
        Left = 0
        Top = 0
        Width = 498
        Height = 128
        Align = faClient
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = False
        Borders.DrawBottom = True
        Borders.Color = clSilver
        object memPersonInfo: TRLMemo
          Left = 8
          Top = 42
          Width = 478
          Height = 80
          Behavior = [beSiteExpander]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Lines.Strings = (
            'CPF/CNPJ: 00.000.000/0000-00 | RG/IE: 000.000.000.000'
            ''
            'Nome Fantasia'
            'Nome da Rua, N'#250'mero, Complemento, Bairro'
            'Cidade - Estado - Cep')
          ParentFont = False
        end
        object RLLabel4: TRLLabel
          Left = 1
          Top = 1
          Width = 497
          Height = 19
          Align = faTop
          AutoSize = False
          Behavior = [beSiteExpander]
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Borders.Color = clSilver
          Caption = ' Dados do Cliente'
          Color = 16382457
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object RLDBText1: TRLDBText
          Left = 6
          Top = 25
          Width = 478
          Height = 16
          AutoSize = False
          DataField = 'person_name'
          DataSource = dtsSale
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Text = ''
        end
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 187
      Width = 718
      Height = 20
      BandType = btHeader
      object RLPanel3: TRLPanel
        Left = 498
        Top = 0
        Width = 220
        Height = 20
        Align = faRightTop
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = False
        Borders.Color = clSilver
        object lblData: TRLLabel
          Left = 1
          Top = 1
          Width = 85
          Height = 19
          Align = faLeft
          AutoSize = False
          Behavior = [beSiteExpander]
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = True
          Borders.DrawBottom = False
          Borders.Color = clSilver
          Caption = ' Emiss'#227'o'
          Color = 16382457
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object RLDBText2: TRLDBText
          Left = 86
          Top = 1
          Width = 133
          Height = 19
          Align = faClient
          Alignment = taCenter
          DataField = 'created_at'
          DataSource = dtsSale
          Text = ''
        end
      end
      object lblReportTitle: TRLLabel
        Left = 0
        Top = 0
        Width = 158
        Height = 20
        Align = faLeft
        Behavior = [beSiteExpander]
        Borders.Sides = sdCustom
        Borders.DrawLeft = False
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        Borders.Color = clSilver
        Caption = 'PROPOSTA COMERCIAL'
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 335
      Width = 718
      Height = 45
      BandType = btHeader
      object RLPanel4: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 45
        Align = faClient
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.Color = clSilver
        object RLLabel2: TRLLabel
          Left = 7
          Top = 24
          Width = 150
          Height = 16
          AutoSize = False
          Caption = 'Proposta V'#225'lida at'#233':'
          Color = 16382457
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object RLLabel7: TRLLabel
          Left = 247
          Top = 24
          Width = 136
          Height = 16
          Caption = 'Previs'#227'o de Entrega:'
          Color = 16382457
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object RLLabel9: TRLLabel
          Left = 7
          Top = 6
          Width = 150
          Height = 16
          AutoSize = False
          Caption = 'Vendedor/Repons'#225'vel:'
          Color = 16382457
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object RLDBText3: TRLDBText
          Left = 159
          Top = 6
          Width = 74
          Height = 16
          DataField = 'seller_name'
          DataSource = dtsSale
          Text = ''
        end
        object RLDBText4: TRLDBText
          Left = 159
          Top = 24
          Width = 78
          Height = 16
          DataField = 'expiration_date'
          DataSource = dtsSale
          Text = ''
        end
        object RLDBText5: TRLDBText
          Left = 385
          Top = 24
          Width = 320
          Height = 16
          AutoSize = False
          DataField = 'delivery_forecast'
          DataSource = dtsSale
          Text = ''
        end
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 390
      Width = 718
      Height = 22
      BandType = btColumnHeader
      object RLPanel5: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 22
        Align = faClient
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = False
        Borders.Color = clSilver
        Color = 16382457
        ParentColor = False
        Transparent = False
        object RLLabel11: TRLLabel
          Left = 1
          Top = 3
          Width = 100
          Height = 16
          AutoSize = False
          Caption = 'Refer'#234'ncia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel12: TRLLabel
          Left = 103
          Top = 3
          Width = 295
          Height = 16
          AutoSize = False
          Caption = 'Descri'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel13: TRLLabel
          Left = 400
          Top = 3
          Width = 70
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Qde'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel15: TRLLabel
          Left = 509
          Top = 3
          Width = 70
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Valor Un.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel16: TRLLabel
          Left = 581
          Top = 3
          Width = 65
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Desc. Un.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel17: TRLLabel
          Left = 648
          Top = 3
          Width = 69
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLLabel14: TRLLabel
          Left = 472
          Top = 3
          Width = 35
          Height = 16
          Alignment = taJustify
          AutoSize = False
          Caption = 'UN'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
      end
    end
    object RLBand5: TRLBand
      Left = 38
      Top = 380
      Width = 718
      Height = 10
      BandType = btHeader
    end
    object RLBand6: TRLBand
      Left = 38
      Top = 412
      Width = 718
      Height = 20
      AfterPrint = RLBand6AfterPrint
      object RLDBText6: TRLDBText
        Left = 1
        Top = 2
        Width = 100
        Height = 16
        AutoSize = False
        DataField = 'product_sku_code'
        DataSource = dtsSaleItem
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText8: TRLDBText
        Left = 400
        Top = 2
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'quantity'
        DataSource = dtsSaleItem
        DisplayMask = '#,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText9: TRLDBText
        Left = 472
        Top = 2
        Width = 35
        Height = 16
        AutoSize = False
        DataField = 'product_unit_name'
        DataSource = dtsSaleItem
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText10: TRLDBText
        Left = 581
        Top = 2
        Width = 65
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'unit_discount'
        DataSource = dtsSaleItem
        DisplayMask = '#,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText11: TRLDBText
        Left = 648
        Top = 2
        Width = 69
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'total'
        DataSource = dtsSaleItem
        DisplayMask = '#,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText12: TRLDBText
        Left = 509
        Top = 2
        Width = 70
        Height = 16
        Alignment = taRightJustify
        AutoSize = False
        DataField = 'price'
        DataSource = dtsSaleItem
        DisplayMask = '#,###,##0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBMemo1: TRLDBMemo
        Left = 105
        Top = 2
        Width = 293
        Height = 16
        Behavior = [beSiteExpander]
        DataField = 'product_name'
        DataSource = dtsSaleItem
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RLPanel6: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 1
        Align = faTop
        Color = clSilver
        ParentColor = False
        Transparent = False
      end
    end
    object RLBand7: TRLBand
      Left = 38
      Top = 449
      Width = 718
      Height = 35
      BandType = btColumnFooter
      object RLPanel7: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 35
        Align = faClient
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.Color = clSilver
        Color = 16382457
        ParentColor = False
        Transparent = False
        object RLLabel1: TRLLabel
          Left = 504
          Top = 11
          Width = 69
          Height = 16
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Total:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = False
        end
        object RLDBText7: TRLDBText
          Left = 575
          Top = 11
          Width = 135
          Height = 15
          Alignment = taRightJustify
          AutoSize = False
          DataField = 'sum_sale_item_total'
          DataSource = dtsSale
          DisplayMask = '#,###,##0.00'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Text = ''
          Transparent = False
        end
      end
    end
    object RLBand8: TRLBand
      Left = 38
      Top = 484
      Width = 718
      Height = 10
      BandType = btSummary
    end
    object bndPaymentTermNote: TRLBand
      Left = 38
      Top = 494
      Width = 718
      Height = 48
      BandType = btSummary
      object RLPanel15: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 48
        Align = faClient
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.Color = clSilver
        object RLLabel8: TRLLabel
          Left = 1
          Top = 1
          Width = 716
          Height = 19
          Align = faTop
          AutoSize = False
          Behavior = [beSiteExpander]
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Borders.Color = clSilver
          Caption = ' Condi'#231#245'es de Pagamento'
          Color = 16382457
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object RLDBMemo2: TRLDBMemo
          Left = 8
          Top = 26
          Width = 703
          Height = 16
          Behavior = [beSiteExpander]
          DataField = 'payment_term_note'
          DataSource = dtsSale
        end
      end
    end
    object bndNote: TRLBand
      Left = 38
      Top = 552
      Width = 718
      Height = 48
      BandType = btSummary
      object RLPanel16: TRLPanel
        Left = 0
        Top = 0
        Width = 718
        Height = 48
        Align = faClient
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = True
        Borders.DrawRight = True
        Borders.DrawBottom = True
        Borders.Color = clSilver
        object RLLabel10: TRLLabel
          Left = 1
          Top = 1
          Width = 716
          Height = 19
          Align = faTop
          AutoSize = False
          Behavior = [beSiteExpander]
          Borders.Sides = sdCustom
          Borders.DrawLeft = False
          Borders.DrawTop = False
          Borders.DrawRight = False
          Borders.DrawBottom = False
          Borders.Color = clSilver
          Caption = ' Observa'#231#245'es'
          Color = 16382457
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
        end
        object RLDBMemo3: TRLDBMemo
          Left = 8
          Top = 26
          Width = 703
          Height = 16
          Behavior = [beSiteExpander]
          DataField = 'note'
          DataSource = dtsSale
        end
      end
    end
    object RLBand11: TRLBand
      Left = 38
      Top = 542
      Width = 718
      Height = 10
      BandType = btSummary
    end
    object bndProductNote: TRLBand
      Left = 38
      Top = 432
      Width = 718
      Height = 17
      object RLDBMemo4: TRLDBMemo
        Left = 105
        Top = 1
        Width = 612
        Height = 15
        Behavior = [beSiteExpander]
        DataField = 'note'
        DataSource = dtsSaleItem
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object dtsSale: TDataSource [2]
    Left = 616
    Top = 792
  end
  object dtsSaleItem: TDataSource [3]
    Left = 736
    Top = 792
  end
  inherited RLPreviewSetup1: TRLPreviewSetup
    EnabledButtons = [pbPrint, pbSave]
  end
end
