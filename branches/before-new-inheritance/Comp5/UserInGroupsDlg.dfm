�
 TUSERINGROUPSDIALOG 0�  TPF0TUserInGroupsDialogUserInGroupsDialogLeft&Top� BorderIconsbiSystemMenu BorderStylebsDialogCaption ��������� �����ClientHeight� ClientWidth�Color��� Font.CharsetRUSSIAN_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style OldCreateOrderPositionpoDesktopCenterOnCreate
FormCreatePixelsPerInch`
TextHeight TLabelLabel2LeftTop@WidthnHeightCaption��������� � �������:  TLabelLabel3Left� Top@Width|HeightCaption�� ��������� � �������:  TxLabelxLabelLeftTopWidth1HeightCaption ��������� ����� ���Font.CharsetRUSSIAN_CHARSET
Font.ColorclBlackFont.Height�	Font.NameTimes New Roman
Font.Style 	FromColor׈1 ToColor���   TDBGridDBGrid1LeftTopPWidth� HeightxCtl3D
DataSource
dsInGroupsOptionsdgColumnResizedgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit ParentCtl3DTabOrder TitleFont.CharsetRUSSIAN_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameTahomaTitleFont.Style   TDBGridDBGrid2Left� TopPWidth� HeightxCtl3D
DataSourcedsGroupsOptionsdgColumnResizedgTabsdgRowSelectdgAlwaysShowSelectiondgConfirmDeletedgCancelOnExit ParentCtl3DTabOrderTitleFont.CharsetRUSSIAN_CHARSETTitleFont.ColorclWindowTextTitleFont.Height�TitleFont.NameTahomaTitleFont.Style   TmBitButtonmBitButton1Left� TopPCaption<- ��������ActionactAddFont.CharsetRUSSIAN_CHARSET
Font.ColorclBlackFont.Height�	Font.NameTahoma
Font.Style ParentColor
ParentFontTabOrder  TmBitButtonmBitButton2Left� ToppCaption
������� ->Action	actRemoveFont.CharsetRUSSIAN_CHARSET
Font.ColorclBlackFont.Height�	Font.NameTahoma
Font.Style ParentColor
ParentFontTabOrder  TmBitButtonmBitButton3LeftETopCaptionOkFont.CharsetRUSSIAN_CHARSET
Font.ColorclBlackFont.Height�	Font.NameTahoma
Font.Style ParentColor
ParentFontTabOrderOnClickmBitButton3Click  TmBitButtonmBitButton4LeftETop Caption������Font.CharsetRUSSIAN_CHARSET
Font.ColorclBlackFont.Height�	Font.NameTahoma
Font.Style ParentColor
ParentFontTabOrderOnClickmBitButton4Click  TQueryqryInGroupsDatabaseNamexxxSQL.StringsSELECT usergroupkey, name #FROM fin_usergroup g, fin_userref r9WHERE g.usergroupkey = r.usergroupkey AND r.userkey = :UKORDER BY name Left(Top� 	ParamDataDataType	ftIntegerNameUK	ParamType	ptUnknown   TIntegerFieldqryInGroupsUSERGROUPKEY	FieldNameUSERGROUPKEYVisible  TStringFieldqryInGroupsNAME	FieldNameNAME   TQuery	qryGroupsDatabaseNamexxxSQL.StringsSELECT usergroupkey, name FROM fin_usergroup gWHERE g.disabled = 0 AND  g.usergroupkey NOT IN <  (SELECT usergroupkey FROM fin_userref WHERE userkey = :UK)ORDER BY name  Left Top� 	ParamDataDataType	ftIntegerNameUK	ParamType	ptUnknown   TIntegerFieldqryGroupsUSERGROUPKEY	FieldNameUSERGROUPKEYVisible  TStringFieldqryGroupsNAME	FieldNameNAME   TDataSource
dsInGroupsDataSetqryInGroupsLeft`Top�   TDataSourcedsGroupsDataSet	qryGroupsLeftXTop�   TActionList
ActionListLeft� Top�  TActionactAddCaption<- ��������	OnExecuteactAddExecuteOnUpdateactAddUpdate  TAction	actRemoveCaption
������� ->	OnExecuteactRemoveExecuteOnUpdateactRemoveUpdate   TQueryqryDatabaseNamexxxLeft� Top� 	ParamData   TgsMultilingualSupportgsMultilingualSupportEnabled	LanguagerusContextTUserInGroupsDialogLeft� Top8   