object xReportView: TxReportView
  Left = 259
  Top = 215
  Width = 696
  Height = 458
  Caption = '�������� ������'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'ms sans serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  Scaled = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 550
    Height = 427
    Align = alClient
    TabOrder = 0
    object Memo: TMemo
      Left = 2
      Top = 18
      Width = 546
      Height = 407
      Align = alClient
      BorderStyle = bsNone
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'COURIER NEW CYR'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
      WantReturns = False
      WordWrap = False
    end
  end
  object Panel1: TPanel
    Left = 550
    Top = 0
    Width = 138
    Height = 427
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 28
      Top = 120
      Width = 86
      Height = 16
      Caption = '���-�� �����'
    end
    object BitBtn1: TBitBtn
      Left = 26
      Top = 28
      Width = 89
      Height = 33
      Caption = '������'
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkOK
    end
    object BitBtn2: TBitBtn
      Left = 26
      Top = 74
      Width = 89
      Height = 33
      Caption = '������'
      TabOrder = 1
      OnClick = BitBtn2Click
      Kind = bkCancel
    end
    object seCountCopy: TSpinEdit
      Left = 30
      Top = 136
      Width = 86
      Height = 26
      MaxValue = 0
      MinValue = 0
      TabOrder = 2
      Value = 1
    end
  end
end
