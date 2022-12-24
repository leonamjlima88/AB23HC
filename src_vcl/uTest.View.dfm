object TestView: TTestView
  Left = 0
  Top = 0
  Caption = 'TestView'
  ClientHeight = 511
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 32
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Store'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 32
    Top = 151
    Width = 465
    Height = 290
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object edtStoreName: TEdit
    Left = 32
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'edtStoreName'
  end
  object Button2: TButton
    Left = 184
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Show'
    TabOrder = 3
    OnClick = Button2Click
  end
  object edtShowId: TEdit
    Left = 184
    Top = 64
    Width = 89
    Height = 21
    TabOrder = 4
    Text = 'edtName'
  end
  object Button3: TButton
    Left = 328
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 5
    OnClick = Button3Click
  end
  object edtUpdateId: TEdit
    Left = 328
    Top = 64
    Width = 41
    Height = 21
    TabOrder = 6
    Text = 'edtName'
  end
  object edtUpdateName: TEdit
    Left = 375
    Top = 64
    Width = 122
    Height = 21
    TabOrder = 7
    Text = 'edtName'
  end
  object Button4: TButton
    Left = 512
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Deletar'
    TabOrder = 8
    OnClick = Button4Click
  end
  object edtDeleteId: TEdit
    Left = 512
    Top = 64
    Width = 41
    Height = 21
    TabOrder = 9
    Text = 'edtName'
  end
  object Button5: TButton
    Left = 616
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Index'
    TabOrder = 10
    OnClick = Button5Click
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 584
    Top = 240
    object FDMemTable1id: TLargeintField
      FieldName = 'id'
    end
    object FDMemTable1name: TStringField
      FieldName = 'name'
      Size = 100
    end
    object FDMemTable1created_at: TDateTimeField
      FieldName = 'created_at'
    end
    object FDMemTable1updated_at: TDateTimeField
      FieldName = 'updated_at'
    end
  end
end
