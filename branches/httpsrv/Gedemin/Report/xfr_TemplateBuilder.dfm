object xfr_dlgTemplateBuilder: Txfr_dlgTemplateBuilder
  Left = 261
  Top = 176
  BorderStyle = bsSingle
  Caption = '�������������� �������'
  ClientHeight = 348
  ClientWidth = 642
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 317
    Width = 642
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 482
      Top = 5
      Width = 75
      Height = 21
      Anchors = [akRight, akBottom]
      Caption = '��'
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 562
      Top = 5
      Width = 75
      Height = 21
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '������'
      ModalResult = 2
      TabOrder = 1
    end
    object Button3: TButton
      Left = 5
      Top = 5
      Width = 75
      Height = 21
      Anchors = [akLeft, akBottom]
      Caption = '�������'
      Enabled = False
      ModalResult = 1
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 642
    Height = 317
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Memo: TSynEdit
      Left = 0
      Top = 28
      Width = 642
      Height = 289
      Cursor = crIBeam
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      TabOrder = 0
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Terminal'
      Gutter.Font.Style = []
      Keystrokes = <
        item
          Command = ecUp
          ShortCut = 38
        end
        item
          Command = ecSelUp
          ShortCut = 8230
        end
        item
          Command = ecScrollUp
          ShortCut = 16422
        end
        item
          Command = ecDown
          ShortCut = 40
        end
        item
          Command = ecSelDown
          ShortCut = 8232
        end
        item
          Command = ecScrollDown
          ShortCut = 16424
        end
        item
          Command = ecLeft
          ShortCut = 37
        end
        item
          Command = ecSelLeft
          ShortCut = 8229
        end
        item
          Command = ecWordLeft
          ShortCut = 16421
        end
        item
          Command = ecSelWordLeft
          ShortCut = 24613
        end
        item
          Command = ecRight
          ShortCut = 39
        end
        item
          Command = ecSelRight
          ShortCut = 8231
        end
        item
          Command = ecWordRight
          ShortCut = 16423
        end
        item
          Command = ecSelWordRight
          ShortCut = 24615
        end
        item
          Command = ecPageDown
          ShortCut = 34
        end
        item
          Command = ecSelPageDown
          ShortCut = 8226
        end
        item
          Command = ecPageBottom
          ShortCut = 16418
        end
        item
          Command = ecSelPageBottom
          ShortCut = 24610
        end
        item
          Command = ecPageUp
          ShortCut = 33
        end
        item
          Command = ecSelPageUp
          ShortCut = 8225
        end
        item
          Command = ecPageTop
          ShortCut = 16417
        end
        item
          Command = ecSelPageTop
          ShortCut = 24609
        end
        item
          Command = ecLineStart
          ShortCut = 36
        end
        item
          Command = ecSelLineStart
          ShortCut = 8228
        end
        item
          Command = ecEditorTop
          ShortCut = 16420
        end
        item
          Command = ecSelEditorTop
          ShortCut = 24612
        end
        item
          Command = ecLineEnd
          ShortCut = 35
        end
        item
          Command = ecSelLineEnd
          ShortCut = 8227
        end
        item
          Command = ecEditorBottom
          ShortCut = 16419
        end
        item
          Command = ecSelEditorBottom
          ShortCut = 24611
        end
        item
          Command = ecToggleMode
          ShortCut = 45
        end
        item
          Command = ecCopy
          ShortCut = 16429
        end
        item
          Command = ecCut
          ShortCut = 8238
        end
        item
          Command = ecPaste
          ShortCut = 8237
        end
        item
          Command = ecDeleteChar
          ShortCut = 46
        end
        item
          Command = ecDeleteLastChar
          ShortCut = 8
        end
        item
          Command = ecDeleteLastChar
          ShortCut = 8200
        end
        item
          Command = ecDeleteLastWord
          ShortCut = 16392
        end
        item
          Command = ecUndo
          ShortCut = 32776
        end
        item
          Command = ecRedo
          ShortCut = 40968
        end
        item
          Command = ecLineBreak
          ShortCut = 13
        end
        item
          Command = ecLineBreak
          ShortCut = 8205
        end
        item
          Command = ecTab
          ShortCut = 9
        end
        item
          Command = ecShiftTab
          ShortCut = 8201
        end
        item
          Command = ecContextHelp
          ShortCut = 16496
        end
        item
          Command = ecSelectAll
          ShortCut = 16449
        end
        item
          Command = ecCopy
          ShortCut = 16451
        end
        item
          Command = ecPaste
          ShortCut = 16470
        end
        item
          Command = ecCut
          ShortCut = 16472
        end
        item
          Command = ecBlockIndent
          ShortCut = 24649
        end
        item
          Command = ecBlockUnindent
          ShortCut = 24661
        end
        item
          Command = ecLineBreak
          ShortCut = 16461
        end
        item
          Command = ecInsertLine
          ShortCut = 16462
        end
        item
          Command = ecDeleteWord
          ShortCut = 16468
        end
        item
          Command = ecDeleteLine
          ShortCut = 16473
        end
        item
          Command = ecDeleteEOL
          ShortCut = 24665
        end
        item
          Command = ecUndo
          ShortCut = 16474
        end
        item
          Command = ecRedo
          ShortCut = 24666
        end
        item
          Command = ecGotoMarker0
          ShortCut = 16432
        end
        item
          Command = ecGotoMarker1
          ShortCut = 16433
        end
        item
          Command = ecGotoMarker2
          ShortCut = 16434
        end
        item
          Command = ecGotoMarker3
          ShortCut = 16435
        end
        item
          Command = ecGotoMarker4
          ShortCut = 16436
        end
        item
          Command = ecGotoMarker5
          ShortCut = 16437
        end
        item
          Command = ecGotoMarker6
          ShortCut = 16438
        end
        item
          Command = ecGotoMarker7
          ShortCut = 16439
        end
        item
          Command = ecGotoMarker8
          ShortCut = 16440
        end
        item
          Command = ecGotoMarker9
          ShortCut = 16441
        end
        item
          Command = ecSetMarker0
          ShortCut = 24624
        end
        item
          Command = ecSetMarker1
          ShortCut = 24625
        end
        item
          Command = ecSetMarker2
          ShortCut = 24626
        end
        item
          Command = ecSetMarker3
          ShortCut = 24627
        end
        item
          Command = ecSetMarker4
          ShortCut = 24628
        end
        item
          Command = ecSetMarker5
          ShortCut = 24629
        end
        item
          Command = ecSetMarker6
          ShortCut = 24630
        end
        item
          Command = ecSetMarker7
          ShortCut = 24631
        end
        item
          Command = ecSetMarker8
          ShortCut = 24632
        end
        item
          Command = ecSetMarker9
          ShortCut = 24633
        end
        item
          Command = ecNormalSelect
          ShortCut = 24654
        end
        item
          Command = ecColumnSelect
          ShortCut = 24643
        end
        item
          Command = ecLineSelect
          ShortCut = 24652
        end
        item
          Command = ecMatchBracket
          ShortCut = 24642
        end>
      Lines.Strings = (
        'Memo')
    end
    object TBDock1: TTBDock
      Left = 0
      Top = 0
      Width = 642
      Height = 28
      BoundLines = [blTop, blBottom]
      object TBToolbar1: TTBToolbar
        Left = 0
        Top = 0
        Caption = 'TBToolbar1'
        Images = dmImages.il16x16
        TabOrder = 0
        object TBItem4: TTBItem
          Action = actSaveToFile
        end
        object TBItem3: TTBItem
          Action = actLoadFromFile
        end
        object TBSeparatorItem1: TTBSeparatorItem
        end
        object TBItem2: TTBItem
          Action = actFind
        end
        object TBItem1: TTBItem
          Action = actReplace
        end
      end
    end
  end
  object ActionList: TActionList
    Images = dmImages.il16x16
    Left = 232
    Top = 64
    object actLoadFromFile: TAction
      Caption = '���������'
      ImageIndex = 132
      OnExecute = actLoadFromFileExecute
    end
    object actSaveToFile: TAction
      Caption = '���������'
      ImageIndex = 25
      OnExecute = actSaveToFileExecute
    end
    object actFind: TAction
      Caption = '�����'
      ImageIndex = 23
      OnExecute = actFindExecute
    end
    object actReplace: TAction
      Caption = '��������'
      ImageIndex = 22
      OnExecute = actReplaceExecute
    end
  end
  object OpenDialog: TOpenDialog
    Left = 72
    Top = 64
  end
  object SaveDialog: TSaveDialog
    Left = 104
    Top = 64
  end
  object FindDialog: TFindDialog
    OnFind = FindDialogFind
    Left = 152
    Top = 64
  end
  object ReplaceDialog: TReplaceDialog
    OnFind = FindDialogFind
    OnReplace = ReplaceDialogReplace
    Left = 192
    Top = 64
  end
end
