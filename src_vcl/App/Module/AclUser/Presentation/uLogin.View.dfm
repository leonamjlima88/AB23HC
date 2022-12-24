object LoginView: TLoginView
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 393
  ClientWidth = 506
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
  object pnlBackground: TPanel
    Left = 0
    Top = 0
    Width = 506
    Height = 393
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 2
    Color = 3680005
    ParentBackground = False
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 2
      Width = 502
      Height = 389
      Align = alClient
      BevelOuter = bvNone
      Color = 7754764
      ParentBackground = False
      TabOrder = 0
      object Image1: TImage
        AlignWithMargins = True
        Left = 20
        Top = 20
        Width = 462
        Height = 64
        Margins.Left = 20
        Margins.Top = 20
        Margins.Right = 20
        Margins.Bottom = 0
        Align = alTop
        AutoSize = True
        Center = True
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000400000
          00400806000000AA6971DE000000017352474200AECE1CE90000000467414D41
          0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000003
          554944415478DAED9BEB71DB300C80A9C700CE06F606F504B526683341E4091A
          4F507B8224134459A04917A89509EA0DEA0DAAFFB2E402259D537C22A9074989
          0E7187D35D1413C0478A0F90F48801391E8F13787C02FD0CBA009D32AD4A069A
          82EE415F3DCF7B31E19B6720F0EFA031E8A4E5CF114802FA0030F65601E81978
          9D6C00C2DA0A0010FC021E7784367995B2035D0288DD68011C0E872808821F44
          4DADD74A5114511886E9E80040CDC784D6BCB6E02B72ADAA93540220CFF339D4
          CAAF06C163C7868EFF24B4B7CFD8DFABA344DCD06C0410D2C101B00EEF8F2478
          0C74039A80D35983326F09ED446565CE9A94A71BC02311D75A4A68936DED2894
          BD2574DEC01304BA1C0C4059960B70602B0800C7F0759F5A82329EE1F155F03E
          F27D3F1D0480A48612D055DF26DA0042AF56D01900FBF6FF725E2BF93ECF6C89
          FA9959D7D9621F00D851DD715E63B3DFA808BE622F86C723E735B6B47BD30078
          CD5269ED9FD93C725EBD80BD6BD300B0494E553AD3C0266FC4C9C0E6956900BC
          DA50364BABB189C1D77E0660B3532C9D7E048E4C09ED94EAA47387D4D3EE5597
          CFEE920074B2EB008CC51107C00170001C0007C00170001C000760CC005866E6
          A4BF39FF16119AF2D62152BB6D214801B0A0BF119AFC50BDDDA54B1002E62556
          BD00E4793E09C3706B51E0E782FB88916899CC05C06ADEE6E0DF200080791700
          B833B31EDA7B45C24D9A8A00F0727E360A3767580B4092F3B7527839431E8029
          E18FB7B64AED3CC1011808400AFA40E8308582230DCE35161F01C03D6F82D260
          ABDD7A00D25D23D976B8ED00A4BB46924D50EB0148576CA66D3B00869DC0838E
          8904007EFFCF970A200527220900D9C128AB01A08886413C7172ABC9EE6800A0
          BC5BA21A5A7A8F0AC03B874CDB73001C000900E6D491E815D3006A8FD0880060
          4244E7D1F7B73981C6E9EF49DA65849853BAC6E3AA208009B3A313367711F651
          92A2DC93ABB2B4F825E405F1BB9FF3D620C28D11CD090A53223C4D2E03607B2B
          C8CAB29C0541D07E67E82450400C0475F6D0DA042A70E9FB7E22FA9F46BBC345
          512450D0CDD001B514BCAD225D5835DE1EB7AC3FC08C73A3AB3A6DCF07882E49
          8C41FEDF4E6B7379A2F509118070CAE1C743477B16780ABEADE053DDB7F961DF
          3B4308E10BA1EB78133746AB8281EE983E753D96F30F42A2295F3A9DDBEF0000
          000049454E44AE426082}
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 64
      end
      object LbUsuario: TLabel
        AlignWithMargins = True
        Left = 77
        Top = 159
        Width = 348
        Height = 18
        Margins.Left = 77
        Margins.Top = 20
        Margins.Right = 77
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Login'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 41
      end
      object LbSenha: TLabel
        AlignWithMargins = True
        Left = 77
        Top = 224
        Width = 348
        Height = 18
        Margins.Left = 77
        Margins.Top = 20
        Margins.Right = 77
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Senha'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 46
      end
      object Panel3: TPanel
        AlignWithMargins = True
        Left = 20
        Top = 84
        Width = 462
        Height = 35
        Margins.Left = 20
        Margins.Top = 0
        Margins.Right = 20
        Margins.Bottom = 20
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Login de acesso'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -27
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object edtLogin: TEdit
        AlignWithMargins = True
        Left = 77
        Top = 178
        Width = 348
        Height = 26
        Margins.Left = 77
        Margins.Top = 1
        Margins.Right = 77
        Margins.Bottom = 0
        Align = alTop
        BorderStyle = bsNone
        CharCase = ecUpperCase
        Color = 5717513
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        MaxLength = 15
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 1
        OnKeyDown = edtLoginKeyDown
      end
      object edtLoginPassword: TEdit
        AlignWithMargins = True
        Left = 77
        Top = 243
        Width = 348
        Height = 26
        Margins.Left = 77
        Margins.Top = 1
        Margins.Right = 77
        Margins.Bottom = 0
        Align = alTop
        BorderStyle = bsNone
        Color = 5717513
        Ctl3D = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        MaxLength = 10
        ParentCtl3D = False
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 2
        OnKeyDown = edtLoginKeyDown
        OnKeyPress = edtLoginPasswordKeyPress
      end
      object pnlLogin3: TPanel
        Left = 255
        Top = 309
        Width = 170
        Height = 40
        Cursor = crHandPoint
        BevelOuter = bvNone
        BorderWidth = 1
        Color = 5717513
        ParentBackground = False
        TabOrder = 3
        object pnlLogin2: TPanel
          Left = 1
          Top = 1
          Width = 168
          Height = 38
          Cursor = crHandPoint
          Align = alClient
          BevelOuter = bvNone
          Color = 4403207
          ParentBackground = False
          TabOrder = 0
          object btnLogin: TSpeedButton
            Left = 38
            Top = 0
            Width = 130
            Height = 38
            Cursor = crHandPoint
            Align = alClient
            Caption = 'Entrar (Enter)'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = btnLoginClick
            ExplicitLeft = 62
            ExplicitTop = 2
          end
          object pnlLogin: TPanel
            Left = 0
            Top = 0
            Width = 38
            Height = 38
            Align = alLeft
            BevelOuter = bvNone
            Color = 5717513
            ParentBackground = False
            TabOrder = 0
            object imgLogin: TImage
              AlignWithMargins = True
              Left = 5
              Top = 5
              Width = 25
              Height = 28
              Cursor = crHandPoint
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alLeft
              Center = True
              Picture.Data = {
                0954506E67496D61676589504E470D0A1A0A0000000D49484452000000190000
                00190806000000C4E98563000000017352474200AECE1CE90000000467414D41
                0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
                E44944415478DAAD95EF71824010C5EFC606B003AC20A403AD205A41B402A582
                48056A059A0AD40AA4034D030925F0259F320ED9973CF4BC4159127766E7E0FE
                FD76DFED81350DAD288A409ABEF8583C140F38948A1FC417D6DACC5D631B02BA
                D22CB9F92D8B05346F0C11C0509A1923CFC5B1C996CFC6CB0EB611D0400D1140
                24CD0E0079DECAE2A1787E65EE84C19C32D24200E852F7810BA0846586883EF6
                409D5A08B3D853969E6C7270C6428E25E299F80B0221E883D24D359032AA93C6
                DE393D4B7F8FEF389799BC77388622C934104CC4823922F4C6B0E952FADB7C47
                2611826196C826D740D6E6B7722ECAD23BAF9072863CB3D481D457974C865493
                AA4CBC8C029E47E69DA54AAE52DBBC944563946EFA03AE991810D06717A4D828
                0001A5423BB20A00B445D90E4D4519D70406E91EAD0280B2C5B974CDF9938222
                5855AC8B28D113E78D90B95502B000170E9516712AB249CDE5B72B74021995D2
                5A25202E3F254EB55DB394F34F925A0D80D1A3DF1C8FC741ABD57A97C737F107
                73BE23D07F5B755EF606008B1264C00B19B10F7721310DCC2A32C0F89851CE9B
                6CEE42D63732D899F3EF755155515A48216DC7CB20E438FA5EFFBAB90F695392
                0533D83BA0F86E10D9E853DA2F741292683E214DE572FFD97B667057886F2BE3
                5CC0FFDA3779F32588ACDAD4B00000000049454E44AE426082}
              ExplicitLeft = 13
              ExplicitTop = 10
            end
          end
        end
      end
      object pnlCancel: TPanel
        Left = 77
        Top = 309
        Width = 170
        Height = 40
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        BevelOuter = bvNone
        BorderWidth = 1
        Color = 8871950
        ParentBackground = False
        TabOrder = 4
        object pnlCancel2: TPanel
          Left = 1
          Top = 1
          Width = 168
          Height = 38
          Cursor = crHandPoint
          Align = alClient
          BevelOuter = bvNone
          Color = 8871950
          ParentBackground = False
          TabOrder = 0
          object btnCancel: TSpeedButton
            Left = 38
            Top = 0
            Width = 130
            Height = 38
            Cursor = crHandPoint
            Align = alClient
            Caption = 'Sair (Esc)'
            Flat = True
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWhite
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            OnClick = btnCancelClick
            ExplicitLeft = 79
            ExplicitTop = 2
          end
          object pnlCancel3: TPanel
            Left = 0
            Top = 0
            Width = 38
            Height = 38
            Align = alLeft
            BevelOuter = bvNone
            Color = 7754764
            ParentBackground = False
            TabOrder = 0
            object imgCancel4: TImage
              AlignWithMargins = True
              Left = 5
              Top = 5
              Width = 25
              Height = 28
              Cursor = crHandPoint
              Margins.Left = 5
              Margins.Top = 5
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alLeft
              Center = True
              Picture.Data = {
                0954506E67496D61676589504E470D0A1A0A0000000D49484452000000190000
                00190806000000C4E98563000000017352474200AECE1CE90000000467414D41
                0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000002
                444944415478DA9D56ED71E23010956018FE3A1D980A2EAE2050C1C515042A08
                54704905975400A9E09C0A920E7007A883E837C3C0BD3D9EB88DB08513CDEC08
                4BBBFBF65B58935887C321C3760BBA03E5A08C24CB816AD0ABB57695D26313CA
                7F81A64AE9A5F504B0452710005C635B82AE95C595580CF224C3FB1FA0B93244
                3C9B01AC6E0521C01B8544D9236805216F120B72737A1EC00A0D645B0084A104
                A3EB18AA10E2377A28464D02906D60A8C9E0BB0244606BEA71D031D220E2EA03
                2D187D174019FCC1CF07E87AB43CDC304C335D8EB89B62FBB9DFEF17FD7EFF2C
                7438CFC1FF1B3F9FB1BF4772523C1EE757561D3826CC2BE63FE6D8276EBBDD16
                C3E150DF4948E43E0755902B238F36BC9B59A5E8ACCE71973357B23B583E118F
                E841386F2C12C88A87F37F06284461ACE290EC76BB0C8A2514D2131E0065AFD7
                5BA60008724B4FBD801C783E6A2BD9C8A3B092654E994D67102679CC1085EF02
                1ED66DFC0AC46890221E074AA1CE4158A71CB5804861AC034832271180037FC9
                320F392A9A80544E9C804812A7A6A1BADAAA88C5B03651D545209FAA4B004E8D
                13319EFAC41C47CD495154759FFA840D1E8C286D3406E28E1F63BB072D9A8A82
                404BF0BDA0AC2B25271E8827C731C5433DBB8AAF4CDF865CE4F4428C3FCEAE06
                F76A5C14DF04C898ECB151D35CBF2702B0E1678D504C068341E7694C80257378
                FE9E4439080DE7998B5507E553F3FF6514B9996E87B6373E4CD7002640F2C63B
                9E65BCBFA1E581F7F21B1F81850AE9B292FF07EC2569F691583C8EBCF3B45C3C
                AC52AFE95F7BCB7BE4EEF30F0A0000000049454E44AE426082}
              ExplicitTop = 4
            end
          end
        end
      end
    end
  end
end
