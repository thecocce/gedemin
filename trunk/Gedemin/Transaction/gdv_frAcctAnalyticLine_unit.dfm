object frAcctAnalyticLine: TfrAcctAnalyticLine
  Left = 0
  Top = 0
  Width = 514
  Height = 23
  Anchors = [akLeft, akTop, akRight]
  AutoScroll = False
  TabOrder = 0
  object lAnaliticName: TLabel
    Left = 16
    Top = 5
    Width = 64
    Height = 13
    Caption = 'lAnaliticName'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object spSelectDocument: TSpeedButton
    Left = 492
    Top = 1
    Width = 22
    Height = 21
    Hint = '������� ��������'
    Anchors = [akTop, akRight]
    Flat = True
    Glyph.Data = {
      36040000424D3604000000000000360000002800000010000000100000000100
      2000000000000004000000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0052AD
      FF0018529400185A9C00185A9C00185A9C00185AA500185AA500185A9C00185A
      9C00185294001852940018528C00184A84004AADFF00FF00FF00FF00FF00185A
      A500186BBD001873CE001873CE001873CE001873CE001873CE001873CE001873
      CE001873CE00186BC600186BBD00185AA500104A7B00FF00FF00FF00FF001863
      AD001873CE00187BDE00187BDE00187BE7001884E7001884E7001884E7001884
      E7001884E700186BC600186BC6001863AD0018528C00FF00FF00FF00FF00186B
      C600187BDE00188CFF00188CFF00188CFF00188CFF00188CFF00188CFF00188C
      FF00188CFF001884E7001873CE00186BBD0018529400FF00FF00FF00FF001873
      CE001884E700188CFF00188CFF00188CFF00188CFF00188CFF00188CFF00188C
      FF00188CFF001884E7001873D600186BC600185A9C00FF00FF00FF00FF00187B
      DE00188CF700188CFF00188CFF00188CFF00188CFF00188CFF00188CFF00188C
      F700188CF7001884E7001873D6001873CE00185AA500FF00FF00FF00FF001884
      E700188CFF00188CFF0084C6FF0084C6FF001884EF0084C6FF0084C6FF00188C
      F70084C6FF0084C6FF001873CE001873CE001863AD00FF00FF00FF00FF001884
      EF00188CFF00188CFF00FFFFFF00FFFFFF00188CFF00FFFFFF00FFFFFF00188C
      F700FFFFFF00FFFFFF001873CE001873CE001863AD00FF00FF00FF00FF00188C
      FF002194FF002194FF00188CFF00188CFF00188CF7001884F7001884EF001884
      EF001884EF001873D6001873CE001873CE001863AD00FF00FF00FF00FF00188C
      FF0039A5FF0039A5FF002194FF001894FF00188CFF00188CFF001884EF001884
      E700187BDE00187BDE00187BDE001873CE001863AD00FF00FF00FF00FF002194
      FF0052ADFF004AADFF00299CFF002194FF002194FF001894FF00188CF7001884
      EF001884E700187BDE00187BDE001873CE001863AD00FF00FF00FF00FF0039A5
      FF006BBDFF0052ADFF0039A5FF00319CFF00299CFF00299CFF002194FF00188C
      FF001884F7001884EF00187BDE001873CE001863AD00FF00FF00FF00FF004AAD
      FF0084C6FF006BBDFF0052ADFF004AADFF0039A5FF00319CFF00299CFF002194
      FF001894FF00188CF7001884EF001873CE00185A9C00FF00FF00FF00FF00ADDE
      FF004AADFF00319CFF002194FF00188CFF00188CFF00188CF700188CF7001884
      EF001884E700187BDE001873CE00186BBD0063B5FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    ParentShowHint = False
    ShowHint = True
    OnClick = actSelectDocumentExecute
  end
  object chkNull: TCheckBox
    Left = 2
    Top = 3
    Width = 15
    Height = 17
    Hint = '������� �� ������ ���������'
    Caption = '�� ����������'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object cbAnalitic: TgsIBLookupComboBox
    Left = 248
    Top = 1
    Width = 157
    Height = 21
    HelpContext = 1
    SortOrder = soAsc
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 1
    Visible = False
  end
  object xdeDateTime: TxDateEdit
    Left = 415
    Top = 1
    Width = 60
    Height = 21
    Kind = kDate
    Anchors = [akLeft, akTop, akRight]
    EditMask = '!99\.99\.9999;1;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 10
    ParentFont = False
    TabOrder = 2
    Text = '  .  .    '
    Visible = False
  end
  object eAnalitic: TEdit
    Left = 120
    Top = 1
    Width = 118
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Visible = False
  end
end
