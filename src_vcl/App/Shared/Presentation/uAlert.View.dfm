object AlertView: TAlertView
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 477
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFundoBorda: TPanel
    Left = 0
    Top = 0
    Width = 718
    Height = 477
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 2
    Color = 3021669
    ParentBackground = False
    TabOrder = 0
    object pnl02Conteudo: TPanel
      Left = 2
      Top = 69
      Width = 714
      Height = 351
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 10
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object memInfo: TMemo
        Left = 10
        Top = 10
        Width = 694
        Height = 331
        TabStop = False
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvRaised
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -17
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object pnl01Topo: TPanel
      AlignWithMargins = True
      Left = 2
      Top = 2
      Width = 714
      Height = 67
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Color = 4269713
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      DesignSize = (
        714
        67)
      object lblTitulo: TLabel
        AlignWithMargins = True
        Left = 75
        Top = 12
        Width = 629
        Height = 43
        Margins.Left = 0
        Margins.Top = 12
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alClient
        Caption = 'Aten'#231#227'o'
        Color = 47103
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 47103
        Font.Height = -33
        Font.Name = 'Segoe UI Light'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ExplicitLeft = 55
        ExplicitTop = 10
        ExplicitWidth = 122
        ExplicitHeight = 45
      end
      object btnExportText: TJvTransparentButton
        Left = 534
        Top = 10
        Width = 170
        Height = 45
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = '&Exportar Texto'
        Color = 3744384
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -15
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = []
        FrameStyle = fsNone
        ParentFont = False
        Transparent = False
        OnClick = btnExportTextClick
        ExplicitLeft = 616
      end
      object Panel1: TPanel
        Left = 0
        Top = 65
        Width = 714
        Height = 2
        Align = alBottom
        BevelOuter = bvNone
        Color = 3021669
        ParentBackground = False
        TabOrder = 0
      end
      object SkAnimatedImage1: TSkAnimatedImage
        AlignWithMargins = True
        Left = 10
        Top = 0
        Width = 55
        Height = 65
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alLeft
        ExplicitHeight = 55
        Data = {
          7B2276223A22342E382E30222C226D657461223A7B2267223A224C6F74746965
          46696C657320414520312E302E30222C2261223A22222C226B223A22222C2264
          223A22222C227463223A22227D2C226672223A36302C226970223A302C226F70
          223A3138342C2277223A313038302C2268223A313038302C226E6D223A22436F
          6D702032222C22646464223A302C22617373657473223A5B5D2C226C61796572
          73223A5B7B22646464223A302C22696E64223A312C227479223A342C226E6D22
          3A225368617065204C617965722031222C227372223A312C226B73223A7B226F
          223A7B2261223A302C226B223A3130302C226978223A31317D2C2272223A7B22
          61223A302C226B223A302C226978223A31307D2C2270223A7B2261223A302C22
          6B223A5B3534302C3534302C305D2C226978223A327D2C2261223A7B2261223A
          302C226B223A5B2D302E3132352C2D38362C305D2C226978223A317D2C227322
          3A7B2261223A302C226B223A5B3130302C3130302C3130305D2C226978223A36
          7D7D2C22616F223A302C22736861706573223A5B7B227479223A226772222C22
          6974223A5B7B2264223A312C227479223A22656C222C2273223A7B2261223A30
          2C226B223A5B34382C34385D2C226978223A327D2C2270223A7B2261223A302C
          226B223A5B302C305D2C226978223A337D2C226E6D223A22456C6C6970736520
          506174682031222C226D6E223A224144424520566563746F7220536861706520
          2D20456C6C69707365222C226864223A66616C73657D2C7B227479223A227374
          222C2263223A7B2261223A302C226B223A5B312C302E37313736343730353838
          32342C302C315D2C226978223A337D2C226F223A7B2261223A302C226B223A31
          30302C226978223A347D2C2277223A7B2261223A302C226B223A35312C226978
          223A357D2C226C63223A312C226C6A223A312C226D6C223A342C22626D223A30
          2C226E6D223A225374726F6B652031222C226D6E223A22414442452056656374
          6F722047726170686963202D205374726F6B65222C226864223A66616C73657D
          2C7B227479223A227472222C2270223A7B2261223A302C226B223A5B2D302E31
          32352C3134385D2C226978223A327D2C2261223A7B2261223A302C226B223A5B
          302C305D2C226978223A317D2C2273223A7B2261223A312C226B223A5B7B2269
          223A7B2278223A5B302E3833332C302E3833335D2C2279223A5B302E3833332C
          302E3833335D7D2C226F223A7B2278223A5B302E3136372C302E3136375D2C22
          79223A5B302E3136372C302E3136375D7D2C2274223A31362C2273223A5B302C
          305D7D2C7B2269223A7B2278223A5B302E3833332C302E3833335D2C2279223A
          5B302E3833332C302E3833335D7D2C226F223A7B2278223A5B302E3136372C30
          2E3136375D2C2279223A5B302E3136372C302E3136375D7D2C2274223A32342C
          2273223A5B3133302E30332C3133302E30335D7D2C7B2274223A33312C227322
          3A5B37352E30332C37352E30335D7D5D2C226978223A337D2C2272223A7B2261
          223A302C226B223A302C226978223A367D2C226F223A7B2261223A302C226B22
          3A3130302C226978223A377D2C22736B223A7B2261223A302C226B223A302C22
          6978223A347D2C227361223A7B2261223A302C226B223A302C226978223A357D
          2C226E6D223A225472616E73666F726D227D5D2C226E6D223A22456C6C697073
          652031222C226E70223A332C22636978223A322C22626D223A302C226978223A
          312C226D6E223A224144424520566563746F722047726F7570222C226864223A
          66616C73657D2C7B227479223A226772222C226974223A5B7B22696E64223A30
          2C227479223A227368222C226978223A312C226B73223A7B2261223A302C226B
          223A7B2269223A5B5B302C305D2C5B302C305D5D2C226F223A5B5B302C305D2C
          5B302C305D5D2C2276223A5B5B302C2D3231362E3632355D2C5B302C37382E33
          37355D5D2C2263223A66616C73657D2C226978223A327D2C226E6D223A225061
          74682031222C226D6E223A224144424520566563746F72205368617065202D20
          47726F7570222C226864223A66616C73657D2C7B227479223A22746D222C2273
          223A7B2261223A302C226B223A302C226978223A317D2C2265223A7B2261223A
          312C226B223A5B7B2269223A7B2278223A5B302E3432315D2C2279223A5B315D
          7D2C226F223A7B2278223A5B302E3636355D2C2279223A5B302E3034315D7D2C
          2274223A362C2273223A5B305D7D2C7B2274223A32332C2273223A5B3130305D
          7D5D2C226978223A327D2C226F223A7B2261223A302C226B223A302C22697822
          3A337D2C226D223A312C226978223A322C226E6D223A225472696D2050617468
          732031222C226D6E223A224144424520566563746F722046696C746572202D20
          5472696D222C226864223A66616C73657D2C7B227479223A227374222C226322
          3A7B2261223A302C226B223A5B312C302E3731373634373035383832342C302C
          315D2C226978223A337D2C226F223A7B2261223A302C226B223A3130302C2269
          78223A347D2C2277223A7B2261223A302C226B223A35312C226978223A357D2C
          226C63223A322C226C6A223A312C226D6C223A342C22626D223A302C226E6D22
          3A225374726F6B652031222C226D6E223A224144424520566563746F72204772
          6170686963202D205374726F6B65222C226864223A66616C73657D2C7B227479
          223A227472222C2270223A7B2261223A302C226B223A5B302C2D31335D2C2269
          78223A327D2C2261223A7B2261223A302C226B223A5B302C305D2C226978223A
          317D2C2273223A7B2261223A302C226B223A5B3130302C38342E3937375D2C22
          6978223A337D2C2272223A7B2261223A302C226B223A302C226978223A367D2C
          226F223A7B2261223A302C226B223A3130302C226978223A377D2C22736B223A
          7B2261223A302C226B223A302C226978223A347D2C227361223A7B2261223A30
          2C226B223A302C226978223A357D2C226E6D223A225472616E73666F726D227D
          5D2C226E6D223A2253686170652032222C226E70223A342C22636978223A322C
          22626D223A302C226978223A322C226D6E223A224144424520566563746F7220
          47726F7570222C226864223A66616C73657D2C7B227479223A226772222C2269
          74223A5B7B22696E64223A302C227479223A227368222C226978223A312C226B
          73223A7B2261223A302C226B223A7B2269223A5B5B302C305D2C5B302C305D2C
          5B302C305D5D2C226F223A5B5B302C305D2C5B302C305D2C5B302C305D5D2C22
          76223A5B5B302C2D3433345D2C5B2D3431322C3236325D2C5B3431312E37352C
          3236325D5D2C2263223A747275657D2C226978223A327D2C226E6D223A225061
          74682031222C226D6E223A224144424520566563746F72205368617065202D20
          47726F7570222C226864223A66616C73657D2C7B227479223A22746D222C2273
          223A7B2261223A302C226B223A302C226978223A317D2C2265223A7B2261223A
          302C226B223A3130302C226978223A327D2C226F223A7B2261223A302C226B22
          3A302C226978223A337D2C226D223A312C226978223A322C226E6D223A225472
          696D2050617468732031222C226D6E223A224144424520566563746F72204669
          6C746572202D205472696D222C226864223A66616C73657D2C7B227479223A22
          746D222C2273223A7B2261223A302C226B223A302C226978223A317D2C226522
          3A7B2261223A312C226B223A5B7B2269223A7B2278223A5B302E3537365D2C22
          79223A5B315D7D2C226F223A7B2278223A5B302E3435395D2C2279223A5B305D
          7D2C2274223A302C2273223A5B305D7D2C7B2274223A35382C2273223A5B3130
          305D7D5D2C226978223A327D2C226F223A7B2261223A312C226B223A5B7B2269
          223A7B2278223A5B302E3630315D2C2279223A5B315D7D2C226F223A7B227822
          3A5B302E3430365D2C2279223A5B305D7D2C2274223A302C2273223A5B305D7D
          2C7B2274223A35382C2273223A5B3232355D7D5D2C226978223A337D2C226D22
          3A312C226978223A332C226E6D223A225472696D2050617468732032222C226D
          6E223A224144424520566563746F722046696C746572202D205472696D222C22
          6864223A66616C73657D2C7B227479223A227374222C2263223A7B2261223A30
          2C226B223A5B312C302E3731373634373037353635332C302C315D2C22697822
          3A337D2C226F223A7B2261223A302C226B223A3130302C226978223A347D2C22
          77223A7B2261223A302C226B223A33342C226978223A357D2C226C63223A322C
          226C6A223A322C22626D223A302C226E6D223A225374726F6B652031222C226D
          6E223A224144424520566563746F722047726170686963202D205374726F6B65
          222C226864223A66616C73657D2C7B227479223A227472222C2270223A7B2261
          223A302C226B223A5B302C305D2C226978223A327D2C2261223A7B2261223A30
          2C226B223A5B302C305D2C226978223A317D2C2273223A7B2261223A302C226B
          223A5B3130302C3130305D2C226978223A337D2C2272223A7B2261223A302C22
          6B223A302C226978223A367D2C226F223A7B2261223A302C226B223A3130302C
          226978223A377D2C22736B223A7B2261223A302C226B223A302C226978223A34
          7D2C227361223A7B2261223A302C226B223A302C226978223A357D2C226E6D22
          3A225472616E73666F726D227D5D2C226E6D223A2253686170652031222C226E
          70223A352C22636978223A322C22626D223A302C226978223A332C226D6E223A
          224144424520566563746F722047726F7570222C226864223A66616C73657D5D
          2C226970223A302C226F70223A3138342C227374223A302C22626D223A307D5D
          2C226D61726B657273223A5B5D7D}
      end
    end
    object pnl03Botoes: TPanel
      Left = 2
      Top = 420
      Width = 714
      Height = 55
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        714
        55)
      object btnOk: TJvTransparentButton
        Left = 534
        Top = 0
        Width = 170
        Height = 45
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        Caption = '&OK (Shift + Enter)'
        Color = 4269713
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -15
        HotTrackFont.Name = 'Tahoma'
        HotTrackFont.Style = []
        FrameStyle = fsNone
        ParentFont = False
        Transparent = False
        OnClick = btnOkClick
        ExplicitLeft = 616
      end
    end
  end
end
