inherited dlgEntryEditForm: TdlgEntryEditForm
  Left = 499
  Top = 181
  HelpContext = 206
  Caption = '�������� ��������'
  ClientHeight = 373
  ClientWidth = 447
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 343
    Width = 447
    inherited Button1: TButton
      Left = 369
    end
    inherited Button2: TButton
      Left = 289
    end
  end
  inherited PageControl: TPageControl
    Width = 447
    Height = 343
    inherited tsGeneral: TTabSheet
      inherited Label1: TLabel
        Top = 12
      end
      inherited Label2: TLabel
        Top = 221
      end
      object Label9: TLabel [2]
        Left = 8
        Top = 202
        Width = 86
        Height = 13
        Caption = '����� � ������:'
      end
      object Label8: TLabel [3]
        Left = 8
        Top = 178
        Width = 41
        Height = 13
        Caption = '������:'
      end
      object Label7: TLabel [4]
        Left = 8
        Top = 155
        Width = 37
        Height = 13
        Caption = '�����:'
      end
      object Label6: TLabel [5]
        Left = 8
        Top = 131
        Width = 115
        Height = 13
        Caption = '��������� �� �������:'
      end
      object Label5: TLabel [6]
        Left = 8
        Top = 107
        Width = 109
        Height = 13
        Caption = '��������� �� ������:'
      end
      object Label4: TLabel [7]
        Left = 8
        Top = 82
        Width = 90
        Height = 13
        Caption = '���������� ����:'
      end
      object Label3: TLabel [8]
        Left = 8
        Top = 58
        Width = 86
        Height = 13
        Caption = '��������� ����:'
      end
      inherited cbName: TComboBox
        Left = 128
        Width = 307
      end
      inherited mDescription: TMemo
        Left = 128
        Top = 221
        Width = 307
        TabOrder = 9
      end
      inherited eLocalName: TEdit
        Left = 128
        Width = 307
        TabOrder = 1
      end
      object beAnalDebit: TBtnEdit
        Left = 128
        Top = 102
        Width = 307
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
        BtnOnClick = beAnalDebitBtnOnClick
        Anchors = [akLeft, akTop, akRight]
        Enabled = True
        TabOrder = 4
      end
      object beAnalCredit: TBtnEdit
        Left = 128
        Top = 126
        Width = 307
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
        BtnOnClick = beAnalDebitBtnOnClick
        Anchors = [akLeft, akTop, akRight]
        Enabled = True
        TabOrder = 5
      end
      object beSum: TBtnEdit
        Left = 128
        Top = 150
        Width = 307
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
        TabOrder = 6
      end
      object gsiblCurr: TgsIBLookupComboBox
        Left = 128
        Top = 174
        Width = 307
        Height = 21
        HelpContext = 1
        Database = dmDatabase.ibdbGAdmin
        Transaction = dmDatabase.ibtrGenUniqueID
        ListTable = 'GD_CURR'
        ListField = 'SHORTNAME'
        KeyField = 'ID'
        gdClassName = 'TgdcCurr'
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
      end
      object beSumCurr: TBtnEdit
        Left = 128
        Top = 197
        Width = 307
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
      object beDebit: TBtnEdit
        Left = 128
        Top = 54
        Width = 307
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
        BtnOnClick = beDebitBtnOnClick
        Anchors = [akLeft, akTop, akRight]
        Enabled = True
        TabOrder = 2
        OnChange = beDebitChange
        OnExit = beDebitExit
      end
      object beCredit: TBtnEdit
        Left = 128
        Top = 78
        Width = 307
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
        BtnOnClick = beDebitBtnOnClick
        Anchors = [akLeft, akTop, akRight]
        Enabled = True
        TabOrder = 3
        OnChange = beCreditChange
        OnExit = beCreditExit
      end
    end
    object tsAdditional: TTabSheet
      Caption = '��������������'
      ImageIndex = 1
      object Label10: TLabel
        Left = 8
        Top = 13
        Width = 85
        Height = 13
        Caption = '������ �������:'
      end
      object Label11: TLabel
        Left = 8
        Top = 37
        Width = 79
        Height = 13
        Caption = '����� �������:'
      end
      object Label12: TLabel
        Left = 8
        Top = 61
        Width = 80
        Height = 13
        Caption = '���� ��������:'
      end
      object beBeginDate: TBtnEdit
        Left = 128
        Top = 8
        Width = 307
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
        TabOrder = 0
      end
      object beEndDate: TBtnEdit
        Left = 128
        Top = 32
        Width = 307
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
        TabOrder = 1
      end
      object beEntryDate: TBtnEdit
        Left = 128
        Top = 56
        Width = 307
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
        TabOrder = 2
      end
    end
  end
  inherited ActionList: TActionList
    Left = 16
    Top = 296
  end
end
