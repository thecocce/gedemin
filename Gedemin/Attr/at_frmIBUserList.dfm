object frmIBUserList: TfrmIBUserList
  Left = 243
  Top = 211
  BorderStyle = bsDialog
  Caption = '������������'
  ClientHeight = 351
  ClientWidth = 366
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 10
    Top = 10
    Width = 350
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = '  � ���� ���������� ��������� ������������:'
    Color = clBlack
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindow
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
  end
  object lblCount: TLabel
    Left = 13
    Top = 289
    Width = 3
    Height = 13
  end
  object lvUser: TListView
    Left = 10
    Top = 40
    Width = 350
    Height = 161
    Anchors = [akLeft, akTop, akRight]
    Columns = <
      item
        AutoSize = True
        Caption = '������������ IB'
      end
      item
        AutoSize = True
        Caption = '��� ������������'
      end>
    ColumnClick = False
    FlatScrollBars = True
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object memoInfo: TMemo
    Left = 10
    Top = 205
    Width = 348
    Height = 82
    TabStop = False
    Anchors = [akLeft, akTop, akRight]
    BorderStyle = bsNone
    Lines.Strings = (
      '��� ������������� �������� ����������/�������� '
      '�����-������, �����-�������� '
      '���������� ��������� ������ ������������� �� ���� ������. '
      ''
      '���� ������������ ��������� ��� �� ������������ '
      '��������� ���� ��������, ������� ����������.')
    ParentColor = True
    ReadOnly = True
    TabOrder = 1
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 312
    Width = 366
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 366
      Height = 2
      Align = alTop
    end
    object btnCancel: TButton
      Left = 199
      Top = 10
      Width = 75
      Height = 21
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '��������'
      ModalResult = 2
      TabOrder = 0
    end
    object btnOk: TButton
      Left = 285
      Top = 10
      Width = 75
      Height = 21
      Action = actOk
      Anchors = [akTop, akRight]
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
  end
  object ibsqlUser: TIBSQL
    Database = dmDatabase.ibdbGAdmin
    SQL.Strings = (
      'SELECT'
      '  NAME, FULLNAME'
      ''
      'FROM'
      '  GD_USER'
      ''
      'WHERE'
      '  IBNAME = :IBNAME ')
    Transaction = IBTransaction
    Left = 30
    Top = 150
  end
  object IBTransaction: TIBTransaction
    Active = False
    DefaultDatabase = dmDatabase.ibdbGAdmin
    AutoStopAction = saNone
    Left = 60
    Top = 150
  end
  object IBUserTimer: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = IBUserTimerTimer
    Left = 90
    Top = 150
  end
  object IBDatabaseInfo: TIBDatabaseInfo
    Database = dmDatabase.ibdbGAdmin
    Left = 120
    Top = 150
  end
  object alIBUsers: TActionList
    Left = 272
    Top = 112
    object actOk: TAction
      Caption = '����������'
      Hint = '�� ������ ����������, ������ ���� ��������� ���� ������������'
      OnExecute = actOkExecute
      OnUpdate = actOkUpdate
    end
    object actBuildUserList: TAction
      Caption = '����������� ������ �������������'
      Hint = '����������� ������ �������������'
      ShortCut = 116
      OnExecute = actBuildUserListExecute
    end
  end
end
