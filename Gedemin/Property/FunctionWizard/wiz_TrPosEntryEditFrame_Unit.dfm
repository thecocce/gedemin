inherited frTrPosEntryEditFrame: TfrTrPosEntryEditFrame
  Height = 288
  Constraints.MinHeight = 288
  inherited PageControl: TPageControl
    Height = 288
    OnChanging = PageControlChanging
    inherited tsGeneral: TTabSheet
      inherited Label1: TLabel
        Top = 9
      end
      inherited Label2: TLabel
        Top = 192
      end
      inherited lLocalName: TLabel
        Height = 27
      end
      object lAccount: TLabel [3]
        Left = 4
        Top = 56
        Width = 26
        Height = 13
        Caption = '����:'
      end
      object lblAccountTypeTitle: TLabel [4]
        Left = 4
        Top = 79
        Width = 53
        Height = 13
        Caption = '��� �����:'
      end
      object lblNCUSumm: TLabel [5]
        Left = 4
        Top = 101
        Width = 83
        Height = 13
        Caption = '����� � ������:'
      end
      object lblCurrTitle: TLabel [6]
        Left = 4
        Top = 125
        Width = 41
        Height = 13
        Caption = '������:'
      end
      object lblCURRSum: TLabel [7]
        Left = 4
        Top = 149
        Width = 86
        Height = 13
        Caption = '����� � ������:'
      end
      object Label3: TLabel [8]
        Left = 4
        Top = 173
        Width = 70
        Height = 13
        Caption = '����� � ���.:'
      end
      inherited cbName: TComboBox
        Width = 328
      end
      inherited mDescription: TMemo
        Top = 192
        Width = 328
        Height = 66
        TabOrder = 9
      end
      inherited eLocalName: TEdit
        Width = 328
      end
      object beAccount: TBtnEdit
        Left = 95
        Top = 51
        Width = 327
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
        BtnOnClick = beAccountBtnOnClick
        Anchors = [akLeft, akTop, akRight]
        Enabled = True
        TabOrder = 2
        OnChange = beAccountChange
        OnExit = beAccountExit
        OnKeyPress = beAccountKeyPress
      end
      object rbDebit: TRadioButton
        Left = 95
        Top = 77
        Width = 89
        Height = 17
        Caption = '���������'
        TabOrder = 3
        OnClick = rbDebitClick
      end
      object rbCredit: TRadioButton
        Left = 184
        Top = 77
        Width = 89
        Height = 17
        Caption = '����������'
        TabOrder = 4
        OnClick = rbCreditClick
      end
      object beSum: TBtnEdit
        Left = 95
        Top = 96
        Width = 327
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
        BtnOnClick = beSumBtnOnClick
        Anchors = [akLeft, akTop, akRight]
        Enabled = True
        TabOrder = 5
      end
      object beCurr: TBtnEdit
        Left = 95
        Top = 120
        Width = 327
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
        BtnOnClick = beCurrBtnOnClick
        Anchors = [akLeft, akTop, akRight]
        Enabled = True
        TabOrder = 6
        OnChange = beCurrChange
      end
      object beSumCurr: TBtnEdit
        Left = 95
        Top = 144
        Width = 327
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
        BtnOnClick = beSumBtnOnClick
        Anchors = [akLeft, akTop, akRight]
        Enabled = True
        TabOrder = 7
      end
      object beSumEQ: TBtnEdit
        Left = 95
        Top = 168
        Width = 327
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
        BtnOnClick = beSumBtnOnClick
        Anchors = [akLeft, akTop, akRight]
        Enabled = True
        TabOrder = 8
      end
    end
    object tsAnalytics: TTabSheet
      BorderWidth = 3
      Caption = '���������'
      ImageIndex = 1
      inline frAnalytics: TfrAnalytics
        Width = 428
        Height = 281
        Align = alClient
        inherited Panel: TPanel
          Width = 428
          Height = 281
          inherited sbAnalytics: TScrollBox
            Width = 426
            Height = 279
          end
        end
      end
    end
    object tsQuantity: TTabSheet
      BorderWidth = 3
      Caption = '�������������� ����������'
      ImageIndex = 2
      inline frQuantity: TfrQuantity
        Width = 429
        Height = 254
        Align = alClient
        inherited TBDock1: TTBDock
          Width = 429
        end
        inherited lvQuantity: TListView
          Width = 429
          Height = 226
          OnDblClick = nil
        end
        inherited ActionList: TActionList
          Left = 152
          Top = 120
        end
      end
    end
  end
  object pmCurr: TPopupMenu
    OnPopup = pmCurrPopup
    Left = 80
    Top = 216
  end
  object pmAccount: TPopupMenu
    OnPopup = pmAccountPopup
    Left = 16
    Top = 216
  end
end
