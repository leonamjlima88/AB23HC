inherited SizeIndexView: TSizeIndexView
  Caption = ''
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBackground: TPanel
    inherited pnlContent: TPanel
      inherited pnlTitle: TPanel
        inherited lblTitle: TLabel
          Width = 68
          Caption = 'Tamanho'
          ExplicitWidth = 68
        end
      end
      inherited scbContent: TScrollBox
        inherited pnlGrid: TPanel
          Height = 447
          ExplicitHeight = 447
          inherited pnlGrid2: TPanel
            Height = 447
            ExplicitHeight = 447
            inherited pnlDbgrid: TPanel
              Height = 447
              ExplicitHeight = 447
              inherited imgNoSearch: TSkAnimatedImage
                Height = 267
                ExplicitHeight = 267
              end
            end
            inherited DBGrid1: TJvDBGrid
              Height = 447
              OnCellClick = DBGrid1CellClick
              OnDrawColumnCell = DBGrid1DrawColumnCell
              OnDblClick = DBGrid1DblClick
              OnKeyDown = DBGrid1KeyDown
              OnTitleClick = DBGrid1TitleClick
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
                  Alignment = taCenter
                  Expanded = False
                  FieldName = 'action_view'
                  Title.Alignment = taCenter
                  Title.Caption = ' '
                  Width = 25
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'id'
                  Title.Caption = 'ID'
                  Width = 70
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'name'
                  Title.Caption = 'Nome'
                  Width = 350
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'created_at'
                  Title.Caption = 'Criado em'
                  Width = 150
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'created_by_acl_user_name'
                  Title.Caption = 'Criado por'
                  Width = 110
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'updated_at'
                  Title.Caption = 'Atualizado em'
                  Width = 150
                  Visible = True
                end
                item
                  Expanded = False
                  FieldName = 'updated_by_acl_user_name'
                  Title.Caption = 'Atualizado por'
                  Width = 110
                  Visible = True
                end
                item
                  Expanded = False
                  Visible = True
                end>
            end
          end
        end
        inherited pnlNavigator: TPanel
          Top = 507
          ExplicitTop = 507
          inherited pnlNavFirst3: TPanel
            inherited pnlNavFirst2: TPanel
              inherited btnNavFirst: TSpeedButton
                OnClick = btnNavigationClick
              end
            end
          end
          inherited pnlNavLast3: TPanel
            inherited pnlNavLast2: TPanel
              inherited btnNavLast: TSpeedButton
                OnClick = btnNavigationClick
                ExplicitLeft = 0
                ExplicitTop = -2
                ExplicitWidth = 20
                ExplicitHeight = 23
              end
            end
          end
          inherited pnlNavPrior4: TPanel
            inherited pnlNavPrior2: TPanel
              inherited pnlNavPrior: TPanel
                inherited btnNavPrior: TSpeedButton
                  OnClick = btnNavigationClick
                end
              end
            end
          end
          inherited pnlNavNext4: TPanel
            inherited pnlNavNext2: TPanel
              inherited pnlNavNext: TPanel
                inherited btnNavNext: TSpeedButton
                  OnClick = btnNavigationClick
                end
              end
            end
          end
        end
        inherited pnlButtonsTop: TPanel
          inherited pnlOptions: TPanel
            inherited pnlOptions2: TPanel
              inherited pnlOptions3: TPanel
                inherited imgOptions: TImage
                  OnClick = imgOptionsClick
                end
              end
            end
          end
          inherited pnlAppend: TPanel
            inherited pnlAppend2: TPanel
              inherited btnAppend: TSpeedButton
                OnClick = btnAppendClick
              end
              inherited pnlAppend3: TPanel
                OnClick = btnAppendClick
                inherited imgAppend: TImage
                  OnClick = btnAppendClick
                end
              end
            end
          end
          inherited pnlSearch3: TPanel
            inherited Panel4: TPanel
              inherited imgSearchClear: TImage
                OnClick = imgSearchClearClick
              end
              inherited pnlSearch5: TPanel
                inherited edtSearchValue: TEdit
                  OnChange = edtSearchValueChange
                  OnDblClick = imgSearchClearClick
                  OnKeyPress = edtSearchValueKeyPress
                end
              end
              inherited pnlImgDoSearch: TPanel
                OnClick = imgDoSearchClick
                inherited imgDoSearch: TImage
                  OnClick = imgDoSearchClick
                end
              end
            end
          end
        end
        object pnlLocate: TPanel
          AlignWithMargins = True
          Left = 0
          Top = 552
          Width = 648
          Height = 46
          Margins.Left = 0
          Margins.Top = 20
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alBottom
          BevelOuter = bvNone
          Color = 16579576
          ParentBackground = False
          TabOrder = 3
          Visible = False
          object imgLocateAppend: TImage
            Left = 0
            Top = 0
            Width = 20
            Height = 20
            Cursor = crHandPoint
            Picture.Data = {
              0954506E67496D61676589504E470D0A1A0A0000000D49484452000000140000
              001408060000008D891D0D000000017352474200AECE1CE90000000467414D41
              0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
              7E4944415478DAAD94CD2E035114C7EF157BF5B125158285883E80D848EC8CBE
              804C638DD6A25BE9B612CA0354DFA01D2C6C2CC45E6A49246A2DA2892DC6EFEA
              8CDCF96A67AA27F9E79CB973EEEF7E1F29426CAE6CA4700632D12252DFC3E80D
              DD22EBB168D5C2FA4A7FC37CD9D8B28538221C17DDAD8D0A7EB0D4402940C7CE
              AC925815E87600C832ABB85C42980BA93D14ADDC1F10D80EEE34225FEDDB9A13
              5FA3B188BC2C336D48E7009EBAEC5983C4AC33701DB719B5A7E48DCA1EB34B02
              549693319292007F97FC4C90D61ADFD18DF6DD0458728079DCAAF6CF0F6F2BA0
              ED6BCC00688A18C6559BA2F38BD66407801CFB3457A01513B844E77B4F7F80AF
              F809ADED0B5D442CF900B7ACFD5B11DEDBD152C02B82F5411E8A49703620A029
              170E8D916F5BA84348FF13A85ED4ACFBF454523D225155950C9A44E7A253CAC2
              2CCFC0277A7150CB36457F5601565081A71EF659712AA804B01D003AD03DD129
              B0433D40EA45ED4716D810F02E6E03CD88CE817DA20F74872E51CD9D956E3F9A
              9B9804204234240000000049454E44AE426082}
            OnClick = btnAppendClick
          end
          object imgLocateEdit: TImage
            Left = 0
            Top = 25
            Width = 20
            Height = 20
            Cursor = crHandPoint
            Picture.Data = {
              0954506E67496D61676589504E470D0A1A0A0000000D49484452000000140000
              001408060000008D891D0D000000017352474200AECE1CE90000000467414D41
              0000B18F0BFC6105000000097048597300000EC300000EC301C76FA864000001
              CA4944415478DA9D953F2C435114C6BFDB1222420949633248176611535B9381
              F81726D2329834BA4A9ABC328B926090A093C15016912EADC16668AC066CD20E
              1A6944D0F77CB7D5E6F5FF7B3DC9CD3DEFE4DE5FBE73EEBDE70954314D71DA54
              88690B34AF060C0BC0C6702B478AE39EE35A28F1F36A7B4579E05771AD58A1ED
              D2ED437D4B73F8CBC145E077D06D6BD1D43D063C3061CCE4D4AAC4D62A80AAE2
              3CE587D70CAC5822E0D2A2C4178B40A6B9C1340F0C133ABA80CF8FF2E82CD3BF
              12F200F8F164A06679EB1D009659E2C728103B2BA929813D82A96E50A63175ED
              9D808B55199D83967A85385E65BEAA7E85572A8CD09931AC2C7A0438C681BB30
              35BD95AFCAA5FC4C67B02ECC3E042CEDF036DA8124974B65D52D2D819A216512
              261585FDD594E58C20AD3ED004AC601298E4DCDF30CD8BAD8630DA8B04DED099
              2C09CBD35C3F31A54C7F281E3A25170A236E603E604659A1861EF1B53DD1DDA6
              6613D09FF4D8427E4EDC025F194330E43B9123F7F4A852DEC388D19D35D46DF2
              3DEF179B03A1326D4F93BC109F9D5F3A25FDB0C98E13E2081298AE00FE437D9C
              645FB43448F19D6B02041DEAE3A2D686ACE2F2F117304597173277603F8464B8
              E181BEBC6AE705557AFB03C8D0A8C23CF54E3C0000000049454E44AE426082}
            OnClick = btnEditClick
          end
          object lblLocateAppend: TLabel
            Left = 26
            Top = 2
            Width = 171
            Height = 16
            Cursor = crHandPoint
            Caption = 'Incluir um novo registro. (Ins)'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8747344
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnAppendClick
          end
          object lblLocateEdit: TLabel
            Left = 26
            Top = 27
            Width = 156
            Height = 16
            Cursor = crHandPoint
            Caption = 'Editar registro posicionado.'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8747344
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            OnClick = btnEditClick
          end
          object pnlSave: TPanel
            AlignWithMargins = True
            Left = 478
            Top = 4
            Width = 170
            Height = 42
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 4
            Margins.Right = 0
            Margins.Bottom = 0
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
              Height = 40
              Cursor = crHandPoint
              Align = alClient
              BevelOuter = bvNone
              Color = 5212710
              ParentBackground = False
              TabOrder = 0
              object btnLocateConfirm: TSpeedButton
                Left = 38
                Top = 0
                Width = 130
                Height = 40
                Cursor = crHandPoint
                Align = alClient
                Caption = 'Confirmar (Enter)'
                Flat = True
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWhite
                Font.Height = -13
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                OnClick = btnLocateConfirmClick
                ExplicitTop = 2
                ExplicitHeight = 38
              end
              object pnlSave3: TPanel
                Left = 0
                Top = 0
                Width = 38
                Height = 40
                Align = alLeft
                BevelOuter = bvNone
                Color = 4552994
                ParentBackground = False
                TabOrder = 0
                OnClick = btnLocateConfirmClick
                object imgSave: TImage
                  AlignWithMargins = True
                  Left = 5
                  Top = 5
                  Width = 25
                  Height = 30
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
                  OnClick = btnLocateConfirmClick
                  ExplicitLeft = 13
                  ExplicitTop = 10
                  ExplicitHeight = 28
                end
              end
            end
          end
          object pnlCancel: TPanel
            AlignWithMargins = True
            Left = 298
            Top = 4
            Width = 170
            Height = 42
            Cursor = crHandPoint
            Margins.Left = 0
            Margins.Top = 4
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
              Height = 40
              Cursor = crHandPoint
              Align = alClient
              BevelOuter = bvNone
              Color = 15658211
              ParentBackground = False
              TabOrder = 0
              object btnLocateClose: TSpeedButton
                Left = 38
                Top = 0
                Width = 130
                Height = 40
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
                OnClick = btnLocateCloseClick
                ExplicitLeft = 54
                ExplicitTop = 2
                ExplicitHeight = 38
              end
              object pnlCancel3: TPanel
                Left = 0
                Top = 0
                Width = 38
                Height = 40
                Align = alLeft
                BevelOuter = bvNone
                Color = 12893085
                ParentBackground = False
                TabOrder = 0
                OnClick = btnLocateCloseClick
                object imgCancel4: TImage
                  AlignWithMargins = True
                  Left = 5
                  Top = 5
                  Width = 25
                  Height = 30
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
                  OnClick = btnLocateCloseClick
                  ExplicitTop = 4
                  ExplicitHeight = 28
                end
              end
            end
          end
        end
      end
    end
    inherited SplitView1: TSplitView
      inherited pnlSplitView: TPanel
        inherited pnlSplitView3: TPanel
          inherited pnlSplitViewApply: TPanel
            inherited pnlSplitViewApply2: TPanel
              OnClick = btnSplitViewApplyClick
            end
          end
          inherited pnlSplitViewHide: TPanel
            inherited pnlSplitViewHide2: TPanel
              OnClick = imgSplitViewHideClick
            end
          end
          inherited pnlFilterClean2: TPanel
            inherited pnlFilterClean: TPanel
              OnClick = imgFilterCleanClick
            end
          end
        end
        inherited scbSplitView: TScrollBox
          object lblFilterIndex2: TLabel
            Left = 10
            Top = 59
            Width = 109
            Height = 13
            Caption = 'Campo de Pesquisa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8747344
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lblFilterSearchType2: TLabel
            Left = 10
            Top = 15
            Width = 101
            Height = 13
            Caption = 'Modo de pesquisa'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 8747344
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cbxFilterIndex: TComboBox
            Left = 10
            Top = 74
            Width = 299
            Height = 24
            Style = csDropDownList
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnSelect = cbxFilterIndexSelect
          end
          object cbxFilterSearchType: TComboBox
            Tag = 2
            Left = 10
            Top = 30
            Width = 299
            Height = 24
            Style = csDropDownList
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 4605510
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemIndex = 0
            ParentFont = False
            TabOrder = 1
            Text = 'Pesquise no In'#237'cio'
            Items.Strings = (
              'Pesquise no In'#237'cio'
              'Em Qualquer Parte'
              'Pesquise no Fim')
          end
        end
      end
    end
  end
  object tmrDoSearch: TTimer
    Enabled = False
    Interval = 600
    OnTimer = tmrDoSearchTimer
    Left = 888
  end
  object ppmOptions: TJvPopupMenu
    Style = msXP
    Cursor = crHandPoint
    ImageMargin.Left = 0
    ImageMargin.Top = 0
    ImageMargin.Right = 0
    ImageMargin.Bottom = 0
    ImageSize.Height = 0
    ImageSize.Width = 0
    Left = 818
    object mniRegistros1: TMenuItem
      Caption = '    * Registros *    '
      Enabled = False
    end
    object mniAppend: TMenuItem
      Caption = '        Incluir'
      ShortCut = 45
      OnClick = btnAppendClick
    end
    object mniEdit: TMenuItem
      Caption = '        Editar'
      ShortCut = 112
      OnClick = btnEditClick
    end
    object mniDelete: TMenuItem
      Caption = '        Deletar'
      OnClick = btnDeleteClick
    end
    object mniView: TMenuItem
      Caption = '        Visualizar'
      ShortCut = 119
      OnClick = btnViewClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object mniGrade1: TMenuItem
      Caption = '    * Grade *'
      Enabled = False
    end
    object mniSaveGridConfig: TMenuItem
      Caption = '        Salvar ordem dos campos'
      OnClick = mniSaveGridConfigClick
    end
    object mniDeleteGridConfig: TMenuItem
      Caption = '        Restaurar ordem dos campos'
      OnClick = mniDeleteGridConfigClick
    end
  end
end
