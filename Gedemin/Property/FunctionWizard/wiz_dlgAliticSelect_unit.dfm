object dlgAnaliticSelect: TdlgAnaliticSelect
  Left = 825
  Top = 359
  Width = 264
  Height = 245
  BorderWidth = 5
  Caption = '����� ���������'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 171
    Width = 238
    Height = 26
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 161
      Top = 5
      Width = 75
      Height = 21
      Action = actCancel
      Anchors = [akRight, akBottom]
      TabOrder = 0
    end
    object Button2: TButton
      Left = 81
      Top = 5
      Width = 75
      Height = 21
      Action = actOk
      Anchors = [akRight, akBottom]
      Default = True
      TabOrder = 1
    end
  end
  object clbAlalitics: TCheckListBox
    Left = 0
    Top = 0
    Width = 238
    Height = 171
    Align = alClient
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
  end
  object ActionList: TActionList
    Left = 96
    Top = 40
    object actOk: TAction
      Caption = 'Ok'
      OnExecute = actOkExecute
    end
    object actCancel: TAction
      Caption = '������'
      ShortCut = 27
      OnExecute = actCancelExecute
    end
  end
end
