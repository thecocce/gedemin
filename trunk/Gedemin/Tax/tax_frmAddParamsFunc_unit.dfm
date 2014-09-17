object frmAddParamsFunc: TfrmAddParamsFunc
  Left = 243
  Top = 176
  Width = 574
  Height = 194
  HelpContext = 15
  BorderWidth = 5
  Caption = '��������� �������'
  Color = clBtnFace
  Constraints.MinWidth = 571
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object plnButton: TPanel
    Left = 0
    Top = 120
    Width = 548
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnOk: TButton
      Left = 389
      Top = 5
      Width = 75
      Height = 21
      Action = actOk
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 469
      Top = 5
      Width = 75
      Height = 21
      Action = actCancel
      Cancel = True
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 548
    Height = 120
    Align = alClient
    BevelOuter = bvLowered
    TabOrder = 1
    object pnlFunction: TPanel
      Left = 1
      Top = 1
      Width = 546
      Height = 16
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object lblFunction: TLabel
        Left = 0
        Top = 0
        Width = 546
        Height = 16
        Align = alClient
        Color = clInactiveCaption
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clCaptionText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
    end
    object sbParams: TScrollBox
      Left = 1
      Top = 17
      Width = 546
      Height = 41
      Align = alClient
      BorderStyle = bsNone
      TabOrder = 1
      object pnlParam: TPanel
        Left = 0
        Top = 0
        Width = 545
        Height = 44
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        TabOrder = 0
        Visible = False
        object lblParam: TLabel
          Left = 8
          Top = 2
          Width = 40
          Height = 13
          Caption = 'lblParam'
        end
        object edtParam: TBtnEdit
          Left = 8
          Top = 16
          Width = 535
          Height = 22
          BtnCaption = '��������'
          BtnCursor = crArrow
          BtnGlyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000FF9933000000FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFF000000FF9933FF99330000000000000000000000000000000000000000
            00000000FFFFFFFFFFFFFFFFFFFFFFFF000000FF9933FFCC33FF9933FF9933FF
            9933FF9933FF9933FF9933FF9933FF9933000000FFFFFFFFFFFFFFFFFFFFFFFF
            FF6633FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FFFF99FF99
            33000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6633FFFF99FFFF99000000FF
            6633FF6633FF6633FF6633FF6633FF6633000000FFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF6633FFFF99000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF6633000000FF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
          BtnShowHint = False
          BtnWidth = 80
          BtnOnClick = edtParamBtnOnClick
          Anchors = [akLeft, akTop, akRight]
          Enabled = True
          TabOrder = 0
        end
      end
    end
    object pnlDescr: TPanel
      Left = 1
      Top = 58
      Width = 546
      Height = 61
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object Bevel1: TBevel
        Left = 0
        Top = 0
        Width = 546
        Height = 2
        Align = alTop
        Shape = bsBottomLine
      end
      object mmDescription: TMemo
        Left = 0
        Top = 2
        Width = 546
        Height = 59
        TabStop = False
        Align = alClient
        BorderStyle = bsNone
        Color = clInfoBk
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object pmAdd: TPopupMenu
    Images = dmImages.il16x16
    Left = 97
    Top = 112
    object miAnalitics: TMenuItem
      Action = actAddAnalytics
      ImageIndex = 216
    end
    object N1: TMenuItem
      Action = actAddValue
    end
    object miAccount: TMenuItem
      Action = actAccount
      ImageIndex = 210
    end
    object miFunction: TMenuItem
      Action = actAddFunction
    end
  end
  object alAdd: TActionList
    Images = dmImages.il16x16
    Left = 137
    Top = 112
    object actAddFunction: TAction
      Caption = '�������'
      ImageIndex = 137
      OnExecute = actAddFunctionExecute
    end
    object actAddAnalytics: TAction
      Caption = '���������'
      ImageIndex = 210
      OnExecute = actAddAnalyticsExecute
    end
    object actAccount: TAction
      Caption = '����'
      ImageIndex = 216
      OnExecute = actAccountExecute
    end
    object actOk: TAction
      Caption = 'OK'
      ShortCut = 16449
      OnExecute = actOkExecute
    end
    object actCancel: TAction
      Caption = '������'
      ShortCut = 27
      OnExecute = actCancelExecute
    end
    object actAddValue: TAction
      Caption = '��.���������'
      OnExecute = actAddValueExecute
    end
  end
  object ilAdd: TImageList
    Left = 177
    Top = 260
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FF00000000000000FF000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      8400000084000000840000000000000084000000840000008400000000000000
      8400000084000000840000000000000000000000000000000000000000000000
      000000000000FF000000FF00000000000000FFFFFF0000000000FF0000000000
      0000000000000000000000000000000000000000000000000000000000000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000840000008400000084000000
      8400000084000000840000000000000000000000840000008400000000000000
      8400000084000000840000000000000000000000000000000000000000000000
      0000FF0000000000000000000000FFFFFF0000000000FFFFFF0000000000FF00
      00000000000000000000000000000000000000000000000000000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF00000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000084000000
      840000000000000000000000000000000000000000000000000000000000FF00
      00000000000000000000FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF000000
      0000FF0000000000000000000000000000000000000000000000000084000000
      8400000084000000840000008400000084000000840000008400000000000000
      8400000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000084000000
      84000000000000000000000000000000000000000000FF000000FF0000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF0000000000FF00000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000008400000000000000
      840000008400000084000000000000000000FF0000000000000000000000FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF0000000000FF0000000000000000000000000000007B7B7B000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00000000000000840000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000840000008400000084000000
      0000000084000000840000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000FF0000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFF
      FF00000000000000000000008400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000084000000
      8400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0000000000FFFFFF00000000000000000000000000000000000000
      0000FFFFFF00FFFFFF007B7B7B0000000000000000000000000000000000FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000008400000084000000
      8400000084000000840000008400000084000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00FFFFFF007B7B7B0000000000000000000000
      000000000000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      8400000084000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000084000000840000000000000000000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF007B7B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000840000008400000084000000840000008400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFE3FE01F0000
      0223F81FC00F00000323F40F80070000DFCFE00700030000DFCF800300010000
      CFA3400180000000CF130000C0000000CFFF0000E0000000EFFF8001F0000000
      80FFC003F8010000E7FFE00FFC010000F33FF07FFE010000F83FF8FFFF1F0000
      FFFFFFFFFFFF0000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
end
