object at_frmNSObjects: Tat_frmNSObjects
  Left = 320
  Top = 212
  Width = 1142
  Height = 654
  Caption = '������ ��������'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object TBDock: TTBDock
    Left = 0
    Top = 0
    Width = 1134
    Height = 26
    object tb: TTBToolbar
      Left = 0
      Top = 0
      Caption = 'tb'
      CloseButton = False
      DockMode = dmCannotFloatOrChangeDocks
      FullSize = True
      Images = dmImages.il16x16
      MenuBar = True
      ParentShowHint = False
      ProcessShortCuts = True
      ShowHint = True
      ShrinkMode = tbsmWrap
      TabOrder = 0
      object TBItem1: TTBItem
        Action = actOpenObject
      end
      object TBItem2: TTBItem
        Action = actAddToNamespace
      end
      object TBSeparatorItem1: TTBSeparatorItem
      end
    end
  end
  object sb: TStatusBar
    Left = 0
    Top = 608
    Width = 1134
    Height = 19
    Panels = <>
    SimplePanel = False
  end
  object gsIBGrid: TgsIBGrid
    Left = 0
    Top = 138
    Width = 1134
    Height = 470
    Align = alClient
    BorderStyle = bsNone
    DataSource = ds
    Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgMultiSelect]
    PopupMenu = pm
    ReadOnly = True
    TabOrder = 2
    InternalMenuKind = imkWithSeparator
    Expands = <>
    ExpandsActive = False
    ExpandsSeparate = False
    TitlesExpanding = False
    Conditions = <>
    ConditionsActive = False
    CheckBox.Visible = False
    CheckBox.FirstColumn = False
    ScaleColumns = True
    MinColWidth = 40
    ColumnEditors = <>
    Aliases = <>
  end
  object pnlTopFilter: TPanel
    Left = 0
    Top = 26
    Width = 1134
    Height = 112
    Align = alTop
    TabOrder = 3
    object pnlFilterButtons: TPanel
      Left = 1
      Top = 1
      Width = 219
      Height = 110
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object Label1: TLabel
        Left = 6
        Top = 59
        Width = 54
        Height = 13
        Caption = '��������:'
      end
      object btnClearAll: TButton
        Left = 4
        Top = 5
        Width = 102
        Height = 21
        Action = actClearAll
        TabOrder = 0
      end
      object btnSetAll: TButton
        Left = 112
        Top = 5
        Width = 102
        Height = 21
        Action = actSetAll
        TabOrder = 1
      end
      object btnSetFilter: TButton
        Left = 112
        Top = 83
        Width = 102
        Height = 21
        Action = actSetFilter
        TabOrder = 4
      end
      object chbxInNS: TCheckBox
        Left = 5
        Top = 34
        Width = 193
        Height = 17
        Caption = '������ � ������������ ����'
        TabOrder = 2
      end
      object gsPeriodEdit: TgsPeriodEdit
        Left = 67
        Top = 56
        Width = 148
        Height = 21
        TabOrder = 3
      end
    end
    object pnlFilter: TPanel
      Left = 220
      Top = 1
      Width = 913
      Height = 110
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
    end
  end
  object ActionList: TActionList
    Images = dmImages.il16x16
    Left = 816
    Top = 80
    object actOpenObject: TAction
      Caption = '������� ������...'
      Hint = '������� ������...'
      ImageIndex = 1
      OnExecute = actOpenObjectExecute
      OnUpdate = actOpenObjectUpdate
    end
    object actAddToNamespace: TAction
      Caption = '�������� � ������������ ����'
      ImageIndex = 81
      OnExecute = actAddToNamespaceExecute
      OnUpdate = actAddToNamespaceUpdate
    end
    object actSetFilter: TAction
      Caption = '���������'
      OnExecute = actSetFilterExecute
    end
    object actClearAll: TAction
      Caption = '�������� ���'
      OnExecute = actClearAllExecute
    end
    object actSetAll: TAction
      Caption = '���������� ���'
      OnExecute = actSetAllExecute
    end
  end
  object ibtr: TIBTransaction
    Active = False
    DefaultDatabase = dmDatabase.ibdbGAdmin
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    AutoStopAction = saNone
    Left = 552
    Top = 296
  end
  object ibds: TIBDataSet
    Database = dmDatabase.ibdbGAdmin
    Transaction = ibtr
    ReadTransaction = ibtr
    Left = 592
    Top = 296
  end
  object ds: TDataSource
    DataSet = ibds
    OnDataChange = dsDataChange
    Left = 552
    Top = 336
  end
  object pm: TPopupMenu
    Left = 128
    Top = 280
  end
end
