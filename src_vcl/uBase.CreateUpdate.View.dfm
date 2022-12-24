object BaseCreateUpdateView: TBaseCreateUpdateView
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 720
  ClientWidth = 1024
  Color = 16579576
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBackground: TPanel
    Left = 0
    Top = 0
    Width = 1024
    Height = 720
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Color = 8747344
    ParentBackground = False
    TabOrder = 0
    object pnlBackground2: TPanel
      Left = 1
      Top = 46
      Width = 1022
      Height = 673
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Aguarde um momento...'
      Color = 16381936
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clSilver
      Font.Height = -24
      Font.Name = 'Segoe UI Light'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object imgNoSearch2: TImage
        AlignWithMargins = True
        Left = 100
        Top = 100
        Width = 822
        Height = 423
        Margins.Left = 100
        Margins.Top = 100
        Margins.Right = 100
        Margins.Bottom = 100
        Align = alClient
        AutoSize = True
        Center = True
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000190000
          00190806000000C4E98563000000017352474200AECE1CE90000000467414D41
          0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
          A84944415478DAD596FF55833010C70313E0067683760398A065026502ED04D0
          096817D03A814C006C204E2023B001DEC9371AD210A0BCFEE1BD9797522EF7B9
          9F691DA14859965FB4DD8BE5D2F8BE7F271F9C1B412A826C86203E6DC5D228DA
          B68D8220C88C102D9A883D9A617C4B2BA15553142BF5850D12927236C53ACEED
          687BBF35E491B6D7A910F686BDDA93F271062446BA323A178E419E694B05DA10
          CF5B8BFD37364CEB0319B870CE04F168E39479387C8001937027858EE33CD067
          4E57436B4590C60A01C8177FAD5CB27778F614B51A8027051099EA6884686993
          A010A0B5E85A9B5B3C46FD1AA4E96CB2350831445401C49E9F44D749BE300CDF
          2C8821A284BC3D98BEB3D9B042F23C0F5DD77D412D3892808B8AE690A963B1CE
          D4584D62004A186A349D0229638966D504D39B0270424A1ABCDBA95E2BC33B18
          D1D89C1CE9D0DE509F9ED745519C312BBDDF111B441AAA696D9408D6A23F2BFC
          AE521C9B35F132FCDFAED18C48E9794D3AEC183B38E9EEBAB885B5BCF7D44927
          90B512D75EF5DA4C98E4273DD742125A9FA29B6C4FD825C4997414A2B5EE12E1
          A12D8720FFF72FD137B8EC062908CF70160000000049454E44AE426082}
        ExplicitLeft = 0
        ExplicitTop = 16
        ExplicitWidth = 1022
        ExplicitHeight = 623
      end
      object pnlBottomButtons: TPanel
        AlignWithMargins = True
        Left = 10
        Top = 623
        Width = 1002
        Height = 40
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alBottom
        BevelOuter = bvNone
        Color = 16381936
        ParentBackground = False
        TabOrder = 0
        object IndicatorLoadFormLabel: TLabel
          Left = 43
          Top = 22
          Width = 102
          Height = 18
          Caption = 'Carregando...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clSilver
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object pnlSave: TPanel
          Left = 832
          Top = 0
          Width = 170
          Height = 40
          Cursor = crHandPoint
          Align = alRight
          BevelOuter = bvNone
          BorderWidth = 1
          Color = 3299352
          ParentBackground = False
          TabOrder = 0
          object pnlSave2: TPanel
            Left = 1
            Top = 1
            Width = 168
            Height = 38
            Cursor = crHandPoint
            Align = alClient
            BevelOuter = bvNone
            Color = 5212710
            ParentBackground = False
            TabOrder = 0
            object btnSave: TSpeedButton
              Left = 38
              Top = 0
              Width = 130
              Height = 38
              Cursor = crHandPoint
              Align = alClient
              Caption = 'Salvar (F6)'
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWhite
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitTop = 2
            end
            object pnlSave3: TPanel
              Left = 0
              Top = 0
              Width = 38
              Height = 38
              Align = alLeft
              BevelOuter = bvNone
              Color = 4552994
              ParentBackground = False
              TabOrder = 0
              object imgSave: TImage
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
                  BD4944415478DAB5967B684E611CC7CFC91F729D154D2B8B2251B4B01452CB1A
                  9B3F988D90CBFCA7FC333299CB721D35B592C83FAE21B74CAE19EFE4AF955B22
                  4D5A2B458A78436BE5F2FA7CBDBFF3F6F47ACF7B899DFAF43BE739BFE7F779CE
                  739EF739AFEF653862B1587F42091443010C87287C8536DFF71F66AAE1A729AE
                  625BA01A8AACB9077EC1602755D707A119E1BBAC24141F40A8834D30141EC035
                  B809EFE19BF51B0BB36021545AF77A4407D24A10E4118EC032E880F574EAC862
                  4A3595876026DCA74F694A0989FD08E76D7A5A601BC93D990449B29D84C66491
                  2B692034811E772FD4425E2E128E3DB0430384DD881A1312047ACC5B10819530
                  1DDAACE345E84A53781A94D97905856F534FEFAF022673FD3C909CB397574C63
                  37D7658EA48AB6D6345354630371255A995A2411AECB7D1A0AB9780B2769A8B5
                  8EFF24B1F66384355024499DBDE8392444FEA3640AE1B1A7156AC6155040C2E7
                  14924E23EC180553534806D994B54A72D55ED0186774AE24972321B13A6F3440
                  49DA3919C9CD097D20794AE895E4062733B899DF07926E4297247AE96BED9D7C
                  099168FF6A4F51749E17FF4DFD25A18606AD557B4692E53A81D5249C0A91ECE7
                  5E43B281BC7D84CD21126D9C57A0DAB74DF1135C27614198C418011FC98B6621
                  394D580C85C12FFEB817DFAB4A487A1422D1323E012FC899944E42FB78CE5FFE
                  992ADF5F1548F2ED693AB5CAB81EE6C537B96083BC6792751025A7DEFAE98738
                  D79148F813B49826C2ECC4DE651DB4C55F823BDC703B667D50632041B3B24403
                  A2CE61B5277FB49A091BE12E5492F43D07819E5EBB4715B4D07743702FD5E777
                  17613B7C5024F96816A3AFB1E91D075BE9D3E4E6F8211D4B6D54A3A1D7A640DF
                  79ED45DADF8678F16FBCBE438B405BD22B135C4EAE17FA6FC5644BBDF8765D1E
                  92A2BF454FE0029C0D96764E1247A6EFFF7C7B02F1035EC3B3B0C2EEF11BEE87
                  567A9D684E950000000049454E44AE426082}
                ExplicitLeft = 13
                ExplicitTop = 10
              end
              object IndicatorLoadButtonSave: TActivityIndicator
                Left = 7
                Top = 7
                IndicatorColor = aicWhite
                IndicatorSize = aisSmall
                IndicatorType = aitRotatingSector
              end
            end
          end
        end
        object pnlCancel: TPanel
          AlignWithMargins = True
          Left = 652
          Top = 0
          Width = 170
          Height = 40
          Cursor = crHandPoint
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alRight
          BevelOuter = bvNone
          BorderWidth = 1
          Color = 8747344
          ParentBackground = False
          TabOrder = 1
          object pnlCancel2: TPanel
            Left = 1
            Top = 1
            Width = 168
            Height = 38
            Cursor = crHandPoint
            Align = alClient
            BevelOuter = bvNone
            Color = 15658211
            ParentBackground = False
            TabOrder = 0
            object btnCancel: TSpeedButton
              Left = 38
              Top = 0
              Width = 130
              Height = 38
              Cursor = crHandPoint
              Align = alClient
              Caption = 'Cancelar (Esc)'
              Flat = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = 8747344
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 54
              ExplicitTop = 2
            end
            object pnlCancel3: TPanel
              Left = 0
              Top = 0
              Width = 38
              Height = 38
              Align = alLeft
              BevelOuter = bvNone
              Color = 12893085
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
                  0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
                  DA4944415478DABD56D171C2300CB5F9E083AF74033241610398A06182C20485
                  091A26A01B1026289D0036804E001BE03F3E38A04FA0E45463A781E4AA3B5D63
                  4BD6B3A42753ADFE417451C7F3F91CE04F07DA846EB5D6F34A410040C13FA181
                  D836D01EC096A5414EA7530B811616809436ECEB5220C862C165A29B8FA109B4
                  0F9DB00B952E7C18040043116C8C60B1B04D198C64005B723708377AC365DA72
                  598C655FA92B11CCE17008EBF5BAB917E4E6A61CB895361BEB485D0941DFB35A
                  ADD62F0CC26C5AF0728EA0BDE3F11820489A99D9EFF761A3D130A2674A7948A0
                  1D0001DF8E0E52FA5D3A68F54766D7E4B292ACB1D72E0222837DE0D088F76530
                  C5E069D9C87F28C1BD201C6895D3EC0D377A89FDAE957D46023EB7758260F0E8
                  E66FBE1B21183576EAB1652448FB7803E26AB6A75F2B3B43617792403B1C72DF
                  24F8B57CCF88D5B7EC25D08E66C7308E3D41E8122FD0AF9C4B64F385EF01689F
                  E8BF26DB2A553627D030C7EF3709AC2CBC6F101FDEF1F2864196AF24C1884068
                  11A902AF29D817C1E795CB95E4F922EE8EB39E4B1083834FAA02B14A76E9C93B
                  3E62B6D34FEA8CCBF1A8100091A3CFEBF8D278284DF073155958197D236E27A5
                  30A14F047A59A14AD02CD1BC19D70319550120E95DF85FA232F20397BB1C8499
                  AADF3F0000000049454E44AE426082}
                ExplicitTop = 4
              end
            end
          end
        end
        object IndicatorLoadForm: TActivityIndicator
          Left = 0
          Top = 8
          IndicatorColor = aicWhite
          IndicatorType = aitRotatingSector
        end
      end
      object pgc: TPageControl
        AlignWithMargins = True
        Left = 10
        Top = 10
        Width = 1002
        Height = 603
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        ActivePage = tabMain
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object tabMain: TTabSheet
          Caption = '     Dados     '
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlMain: TPanel
            Left = 0
            Top = 0
            Width = 994
            Height = 574
            Align = alClient
            BevelOuter = bvNone
            Color = 16579576
            ParentBackground = False
            TabOrder = 0
          end
        end
      end
    end
    object pnlTitle: TPanel
      Left = 1
      Top = 1
      Width = 1022
      Height = 45
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 1
      OnMouseDown = pnlTitleMouseDown
      object imgTitle: TImage
        AlignWithMargins = True
        Left = 10
        Top = 10
        Width = 26
        Height = 25
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alLeft
        AutoSize = True
        Center = True
        ExplicitLeft = 20
        ExplicitTop = 7
        ExplicitHeight = 26
      end
      object lblTitle: TLabel
        AlignWithMargins = True
        Left = 46
        Top = 5
        Width = 61
        Height = 32
        Margins.Left = 0
        Margins.Top = 5
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'T'#237'tulo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -24
        Font.Name = 'Segoe UI Light'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object imgCloseTitle: TImage
        AlignWithMargins = True
        Left = 987
        Top = 10
        Width = 25
        Height = 25
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alRight
        AutoSize = True
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
        ExplicitLeft = 980
      end
      object imgMinimizeTitle: TImage
        AlignWithMargins = True
        Left = 952
        Top = 10
        Width = 25
        Height = 25
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        Align = alRight
        AutoSize = True
        Center = True
        Picture.Data = {
          0954506E67496D61676589504E470D0A1A0A0000000D49484452000000190000
          00190806000000C4E98563000000017352474200AECE1CE90000000467414D41
          0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
          D64944415478DAAD968171C2300C456D16286CD04E004C50B241B24198A06502
          DA09A013C07581A613900DCA06A4139409A0FF83447521C40DC477BA7046D693
          6459B6773563BFDF77F119401E2131A42BB285AC2105E4D37B9FD7D9F101E333
          F98606816F802DFF0511C0423C5703193D16CF9D4443781F9242EE8D6E04D8F6
          2204002EFC9045541C43F2F2A2F2D8ED76317466661D41EB330800545889223D
          1F878C5764800E8E04F4A0EB2D840A31BC7AEF743A4F4D0025D84A40CC407482
          E08F58BC60CE87D7024C445F92116663A9104E0E74F25A8001A5EE583C5BD8EB
          7913456565DC00DA48344342A6F8F14201E0B50D8040586DCF07BBBAE1900490
          AC45886628F3262C965C6194E8C55D03BBDF763FA5007E208585F4743F303772
          C733D37444DAC782909622A1CD8D42F4F044A16EDA64986CE4DE54C10490798B
          10ADDAB937C4C3C16909604F7DA2275EF7A5AD137F3AE0B0375448EAA40D38D3
          3D6F88824E779DED5DF2E759F7BC12A0175E063B09E77D4941F398BB6307687A
          9F28A070A69B976F4602F4E2A2C224B447E63DB090750444B67B5CBAE3F58673
          B2C8DEF11A9D7DC5E86323977D28ACCDCAD78AC0527CA6EEEF915037D6D0E76B
          25AB4AB10FAD9672EC4B6404EABBAB10CF0F11D6EDDF2F8BA50FA7437A3D1800
          00000049454E44AE426082}
        OnClick = imgMinimizeTitleClick
        ExplicitLeft = 945
      end
    end
  end
  object btnFocus: TButton
    Left = -1000
    Top = -1000
    Width = 75
    Height = 25
    Caption = 'focus'
    TabOrder = 1
  end
end
