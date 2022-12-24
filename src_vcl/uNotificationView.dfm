object NotificationView: TNotificationView
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'NotificationView'
  ClientHeight = 69
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Scaled = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBorder: TPanel
    Left = 0
    Top = 0
    Width = 405
    Height = 69
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 1
    Color = 4422672
    ParentBackground = False
    TabOrder = 0
    object pnlBackground: TPanel
      Left = 1
      Top = 1
      Width = 403
      Height = 67
      Align = alClient
      BevelOuter = bvNone
      Color = 14612679
      Enabled = False
      ParentBackground = False
      TabOrder = 0
      object pnlTitle: TPanel
        Left = 0
        Top = 0
        Width = 403
        Height = 18
        Align = alTop
        Alignment = taLeftJustify
        BevelOuter = bvNone
        Color = 4422672
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        object Image1: TImage
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 16
          Height = 16
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alLeft
          Center = True
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D494844520000000E0000
            000E08060000001F482DD1000000017352474200AECE1CE90000000467414D41
            0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000000
            DA4944415478DABD926111C2300C851B0748600E4001870350005300530053C0
            50C050C050800470301C3007E53D2ED98FD28E7FE42E975D93EF15F22A2E11DE
            FB1DAB8894B1BE4480050AA1891E3D9105049A240868AB106FB1410A1D9039E0
            FA0B0434426955BD0E04099F90197A5D087E94D1C812FFF9A5B73621B846D9A0
            314D807794A3FD9ABF8167F4AB1EC421577F435629DF30C3CD527C8E99878117
            940E07B91B089DE3A3581AD8AA6F57371C33DECACD1B48D3F7EE77D0C31A6011
            7B727C08F48C4BE037FDED8DB79098AC2E6B851C234B2E239C7903EC61690F83
            E2C3A50000000049454E44AE426082}
        end
        object Label1: TLabel
          AlignWithMargins = True
          Left = 20
          Top = 2
          Width = 62
          Height = 13
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alLeft
          Caption = 'Notifica'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object memMsg: TMemo
        AlignWithMargins = True
        Left = 5
        Top = 23
        Width = 393
        Height = 39
        Margins.Left = 5
        Margins.Top = 5
        Margins.Right = 5
        Margins.Bottom = 5
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = 14612679
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4934475
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Lines.Strings = (
          'Registro salvo com sucesso!')
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  object btnFocus: TButton
    Left = -1000
    Top = 72
    Width = 75
    Height = 25
    Caption = 'btnFocus'
    TabOrder = 1
  end
  object Timer1: TTimer
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 312
    Top = 24
  end
end
