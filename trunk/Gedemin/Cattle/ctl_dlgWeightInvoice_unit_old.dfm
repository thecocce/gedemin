�
 TCTL_DLGWEIGHTINVOICE 0�=  TPF0Tctl_dlgWeightInvoicectl_dlgWeightInvoiceLeftTop� ActiveControl
edQuantityBorderStylebsDialogCaption�����-���������ClientHeightmClientWidth�Color	clBtnFaceFont.CharsetRUSSIAN_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style OldCreateOrder	PositionpoScreenCenterOnCreate
FormCreate	OnDestroyFormDestroyPixelsPerInch`
TextHeight TPanel
pnlButtonsLeft TopHWidth�Height%AlignalBottom
BevelOuterbvNoneFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameTahoma
Font.Style 
ParentFontTabOrder  TButtonbtnOkLeftFTopWidthKHeightActionactOkAnchorsakTopakRight Caption&��TabOrder   TButton	btnCancelLeft�TopWidthKHeightAction	actCancelAnchorsakTopakRight Cancel	TabOrder  TButtonbtnNextLeft� TopWidthKHeightActionactNextDefault	TabOrder   TPageControl	pcInvoiceLeft Top Width�HeightH
ActivePagetsInvoicePosAlignalClientTabOrderOnChangecbKindChange 	TTabSheet	tsInvoiceCaption&1 ��������� TBevelBevel3LeftTop� Width�HeightZAnchorsakLeftakTopakRight ShapebsFrame  TBevelBevel2LeftTopUWidth�HeightvAnchorsakLeftakTopakRight ShapebsFrame  TBevelBevel1LeftTopWidth�HeightOAnchorsakLeftakTopakRight ShapebsFrame  TLabellblDateLeftTopWidthHeightCaption����:  TLabellblDepartmentLeftTop9WidthTHeightCaption�������������:  TLabel	lblNumberLeftTop"WidthKHeightCaption� ���������:  TLabellblTTNLeft� TopWidth'HeightCaption� ���:  TLabellblPurchaseKindLeftTop\WidthCHeightCaption��� �������:  TLabel
lblSuplierLeftTopuWidth=HeightCaption
���������:  TLabellblDeliveryKindLeftTop� WidthJHeightCaption��� ��������:  TLabellblReceivingLeftTop� WidthDHeightCaption��� �������:  TLabellblWasteCountLeftTopWidthSHeightAutoSizeCaption������ � ��������:WordWrap	  TLabellblFaceLeftTop� Width[HeightCaption���������� ����:Visible  TLabellblKindLeft� Top"WidthQHeightCaption��� ���������:  TLabelLabel1LeftsTop� Width>HeightCaption����������:  TLabelLabel2Left� Top� Width<HeightCaption�/� ������:  TLabelLabel3Left� Top� WidthBHeightCaption������ ���:  TLabellblDestinationLeft� TopWidth?HeightCaption��� ����������:WordWrap	  TLabelLabel8LeftGTop� Width@HeightCaption��� ������:  TgsIBLookupComboBoxluDepartmentLeftsTop6WidthHeightHelpContextDatabasedmDatabase.ibdbGAdminTransactionibtrInvoice
DataSource	dsInvoice	DataFieldDEPARTMENTKEY	ListTable
gd_contact	ListFieldnameKeyFieldid	Conditioncontacttype=4gdClassNameTgdcDepartment
ItemHeight ParentShowHintShowHint	TabOrder  TxDateDBEditdbeDateLeftsTopWidthQHeight	DataFieldDOCUMENTDATE
DataSource
dsDocumentKindkDateEditMask!99\.99\.9999;1;_	MaxLength
TabOrder   TDBEdit	dbeNumberLeftsTopWidthQHeight	DataFieldNUMBER
DataSource
dsDocumentTabOrder  TDBEditdbeTTNLeft6TopWidthQHeight	DataField	TTNNUMBER
DataSource	dsInvoiceTabOrder  TgsIBLookupComboBox
luSupplierLeftsToprWidthHeightHelpContextDatabasedmDatabase.ibdbGAdminTransactionibtrInvoice
DataSource	dsInvoice	DataFieldSUPPLIERKEY	ListTable
gd_contact	ListFieldnameKeyFieldid	Conditioncontacttype=3gdClassNameTgdcCompanyEnabled
ItemHeight ParentShowHintShowHint	TabOrderOnChangeluSupplierChange  TDBEditdbeWasteCountLeftsTopWidth=Height	DataField
WASTECOUNT
DataSource	dsInvoiceTabOrder  TDBCheckBoxcbForceSlaughterLeft	Top� Width� Height	AlignmenttaLeftJustifyCaption����������� ����	DataFieldFORCESLAUGHTER
DataSource	dsInvoiceTabOrderValueChecked1ValueUnchecked0  	TComboBoxcbPurchaseKindLeftsTop[Width� HeightStylecsDropDownList
ItemHeightTabOrderOnChangecbPurchaseKindChangeItems.Strings���. �������������� � ���������������� ������   	TComboBoxcbDeliveryKindLeftsTop� Width� HeightStylecsDropDownList
ItemHeightTabOrderItems.Strings�����������	������������������ ������������ ����   TgsIBLookupComboBoxluReceivingKeyLeftsTop� Width� HeightHelpContextDatabasedmDatabase.ibdbGAdminTransactionibtrInvoice
DataSource	dsInvoice	DataFieldRECEIVINGKEY	ListTablectl_reference	ListFieldnameKeyFieldid	ConditionPARENT = 1000
ItemHeight ParentShowHintShowHint	TabOrder  TgsIBLookupComboBoxluFaceLeftsTop� WidthHeightHelpContextDatabasedmDatabase.ibdbGAdminTransactionibtrInvoice
DataSource	dsInvoice	DataFieldFACEKEY	ListTable
gd_contact	ListFieldnameKeyFieldid	Conditioncontacttype=2gdClassNameTgdcContact
ItemHeight ParentShowHintShowHint	TabOrderVisible  	TComboBoxcbKindLeft6TopWidthQHeightStylecsDropDownList
ItemHeightTabOrderOnChangecbKindChangeItems.Strings�� ������ ����   TDBEditdbeDistanceLeftsTop� WidthBHeight
DataSourcedsContactPropsTabOrder  TDBEdit
dbeFarmTaxLeft� Top� Width<Height
DataSourcedsContactPropsTabOrder  TDBEditdbeVATLeft� Top� WidthGHeight
DataSourcedsContactPropsTabOrder	  TgsIBLookupComboBoxluDestinationLeft� TopWidth� HeightHelpContextDatabasedmDatabase.ibdbGAdminTransactionibtrInvoice	ListTableCTL_REFERENCE	ListFieldNAMEKeyFieldID	ConditionPARENT = 2000
ItemHeight ParentShowHintShowHint	TabOrder  TDBEditdbeNDSTransLeftETop� WidthBHeight
DataSourcedsContactPropsTabOrder
   	TTabSheettsInvoicePosCaption&2 ������� ���������
ImageIndex TControlBarcbMainLeft TopAWidth�HeightAlignalTopAutoDockAutoSize	
BevelEdgesbeBottom 
BevelInnerbvNone
BevelOuterbvNone	BevelKindbkNoneColor	clBtnFaceDockSiteParentColorTabOrder TToolBartbMainLeftTopWidthxHeightAutoSize	EdgeBorders Flat	ImagesdmImages.ilToolBarSmallTabOrder  TToolButtontbtNewLeft Top ActionactNewParentShowHintShowHint	  TToolButtontbtEditLeftTop ActionactEditParentShowHintShowHint	  TToolButton	tbtDeleteLeft.Top Action	actDeleteParentShowHintShowHint	  TToolButtontbtDuplicateLeftETop ActionactDuplicateParentShowHintShowHint	    TgsIBCtrlGridibgrdInvoiceLineLeft Top[Width�Height� AlignalClient
DataSourcedsInvoiceLineOptionsdgTitlesdgColumnResize
dgColLines
dgRowLinesdgAlwaysShowSelectiondgCancelOnExit TabOrder
OnDblClickibgrdInvoiceLineDblClickRefreshTypertNoneStripedInternalMenuKindimkWithSeparatorExpands ExpandsActiveExpandsSeparateTitlesExpanding
Conditions ConditionsActiveCheckBox.VisibleCheckBox.FirstColumnMinColWidth(ColumnEditors AliasesAliasDESTNAMELName
���������� AliasGOODNAMELName
����(����)    	TGroupBoxgbTotalLeft TopWidth�Height)AlignalBottomCaption�����Ctl3DParentCtl3DTabOrder TLabelLabel4LeftTopWidthGHeightCaption���-�� �����:  TLabelLabel5LeftTopWidthNHeightCaption������� �����:  TLabel
lbQuantityLeftUTopWidthHeightCaption0  TLabellbMeatWeightLeftUTopWidthHeightCaption0  TLabelLabel6Left� TopWidth:HeightCaption
����� ���:  TLabelLabel7Left� TopWidthuHeightCaption����� ��� �� �������:  TLabellbLiveWeightLeft'TopWidthHeightCaption0  TLabellbRealWeightLeft'TopWidthHeightCaption0   TPanelpnlControlValuesLeft Top Width�HeightAAlignalTop
BevelOuterbvNoneTabOrder  TLabelLabel9LeftTopWidthGHeightCaption���-�� �����:  TLabelLabel10LeftTop'WidthNHeightCaption������� �����:  TEdit
edQuantityLeftUTop
WidthyHeightTabOrder Text0  TEditedMeatWeightLeftUTop#WidthyHeightTabOrderText0     TActionListalMainImagesdmImages.ilToolBarSmallLeft}Top  TActionactNewCategoryMasterCaptionactNewHint������� ����� ������
ImageIndex ShortCut-	OnExecuteactNewExecuteOnUpdateactNewUpdate  TActionactEditCategoryMasterCaptionactEditHint�������� ������� ������
ImageIndexShortCut-@	OnExecuteactEditExecute  TAction	actDeleteCategoryMasterCaption	actDeleteHint������� ������� ������
ImageIndexShortCut.@	OnExecuteactDeleteExecute  TActionactDuplicateCategoryMasterCaptionactDuplicateHint������� ����� ������� ������
ImageIndex  TActionactOkCaptionOk	OnExecuteactOkExecute  TAction	actCancelCaption��������	OnExecuteactCancelExecute  TActionactNextCaption������	OnExecuteactNextExecute   TIBTransactionibtrInvoiceActiveDefaultDatabasedmDatabase.ibdbGAdminParams.Stringsread_committedrec_versionnowait AutoStopActionsaNoneLeftTop   
TIBDataSetibdsDocumentDatabasedmDatabase.ibdbGAdminTransactionibtrInvoiceDeleteSQL.Stringsdelete from GD_DOCUMENTwhere  ID = :OLD_ID InsertSQL.Stringsinsert into GD_DOCUMENTN  (ID, DOCUMENTTYPEKEY, TRTYPEKEY, NUMBER, DOCUMENTDATE, DESCRIPTION, SUMNCU, I   SUMCURR, SUMEQ, AFULL, ACHAG, AVIEW, CURRKEY, COMPANYKEY, CREATORKEY, <   CREATIONDATE, EDITORKEY, EDITIONDATE, DISABLED, RESERVED)valuesL  (:ID, :DOCUMENTTYPEKEY, :TRTYPEKEY, :NUMBER, :DOCUMENTDATE, :DESCRIPTION, M   :SUMNCU, :SUMCURR, :SUMEQ, :AFULL, :ACHAG, :AVIEW, :CURRKEY, :COMPANYKEY, N   :CREATORKEY, :CREATIONDATE, :EDITORKEY, :EDITIONDATE, :DISABLED, :RESERVED) RefreshSQL.StringsSelect   ID,  DOCUMENTTYPEKEY,  TRTYPEKEY,	  NUMBER,  DOCUMENTDATE,  DESCRIPTION,	  SUMNCU,
  SUMCURR,  SUMEQ,  AFULL,  ACHAG,  AVIEW,
  CURRKEY,  COMPANYKEY,  CREATORKEY,  CREATIONDATE,  EDITORKEY,  EDITIONDATE,  DISABLED,
  RESERVEDfrom GD_DOCUMENT where
  ID = :ID SelectSQL.StringsSELECT   * FROM  GD_DOCUMENT WHERE    ID = :DOCUMENTKEY ModifySQL.Stringsupdate GD_DOCUMENTset  ID = :ID,%  DOCUMENTTYPEKEY = :DOCUMENTTYPEKEY,  TRTYPEKEY = :TRTYPEKEY,  NUMBER = :NUMBER,  DOCUMENTDATE = :DOCUMENTDATE,  DESCRIPTION = :DESCRIPTION,  SUMNCU = :SUMNCU,  SUMCURR = :SUMCURR,  SUMEQ = :SUMEQ,  AFULL = :AFULL,  ACHAG = :ACHAG,  AVIEW = :AVIEW,  CURRKEY = :CURRKEY,  COMPANYKEY = :COMPANYKEY,  CREATORKEY = :CREATORKEY,  CREATIONDATE = :CREATIONDATE,  EDITORKEY = :EDITORKEY,  EDITIONDATE = :EDITIONDATE,  DISABLED = :DISABLED,  RESERVED = :RESERVEDwhere  ID = :OLD_ID Left3Top   
TIBDataSetibdsInvoiceDatabasedmDatabase.ibdbGAdminTransactionibtrInvoiceDeleteSQL.Stringsdelete from CTL_INVOICEwhere   DOCUMENTKEY = :OLD_DOCUMENTKEY InsertSQL.Stringsinsert into CTL_INVOICEJ  (DOCUMENTKEY, RECEIPTKEY, TTNNUMBER, KIND, DEPARTMENTKEY, PURCHASEKIND, R   SUPPLIERKEY, RECEIVINGKEY, FORCESLAUGHTER, WASTECOUNT, RESERVED, DELIVERYKIND,    FACEKEY)valuesP  (:DOCUMENTKEY, :RECEIPTKEY, :TTNNUMBER, :KIND, :DEPARTMENTKEY, :PURCHASEKIND, I   :SUPPLIERKEY, :RECEIVINGKEY, :FORCESLAUGHTER, :WASTECOUNT, :RESERVED,    :DELIVERYKIND, :FACEKEY) RefreshSQL.StringsSelect   DOCUMENTKEY,  RECEIPTKEY,  TTNNUMBER,  KIND,  DEPARTMENTKEY,  PURCHASEKIND,  SUPPLIERKEY,  RECEIVINGKEY,  FORCESLAUGHTER,  WASTECOUNT,  RESERVED,  DELIVERYKIND,	  FACEKEYfrom CTL_INVOICE where  DOCUMENTKEY = :DOCUMENTKEY SelectSQL.StringsSELECT   * FROM  CTL_INVOICE WHERE  DOCUMENTKEY = :DOCUMENTKEY  ModifySQL.Stringsupdate CTL_INVOICEset  DOCUMENTKEY = :DOCUMENTKEY,  RECEIPTKEY = :RECEIPTKEY,  TTNNUMBER = :TTNNUMBER,  KIND = :KIND,!  DEPARTMENTKEY = :DEPARTMENTKEY,  PURCHASEKIND = :PURCHASEKIND,  SUPPLIERKEY = :SUPPLIERKEY,  RECEIVINGKEY = :RECEIVINGKEY,#  FORCESLAUGHTER = :FORCESLAUGHTER,  WASTECOUNT = :WASTECOUNT,  RESERVED = :RESERVED,  DELIVERYKIND = :DELIVERYKIND,  FACEKEY = :FACEKEYwhere   DOCUMENTKEY = :OLD_DOCUMENTKEY LeftQTop   TDataSource
dsDocumentDataSetibdsDocumentLeft� Top   TDataSource	dsInvoiceDataSetibdsInvoiceLeft� Top   
TIBDataSetibdsInvoiceLineDatabasedmDatabase.ibdbGAdminTransactionibtrInvoiceCachedUpdates	DeleteSQL.Stringsdelete from CTL_INVOICEPOSwhere  ID = :OLD_ID InsertSQL.Stringsinsert into CTL_INVOICEPOSJ  (ID, INVOICEKEY, GOODKEY, QUANTITY, MEATWEIGHT, LIVEWEIGHT, REALWEIGHT, *   DESTKEY, AFULL, ACHAG, AVIEW, RESERVED)valuesQ  (:ID, :INVOICEKEY, :GOODKEY, :QUANTITY, :MEATWEIGHT, :LIVEWEIGHT, :REALWEIGHT, /   :DESTKEY, :AFULL, :ACHAG, :AVIEW, :RESERVED) RefreshSQL.StringsSelect   ID,  INVOICEKEY,
  GOODKEY,  QUANTITY,  MEATWEIGHT,  LIVEWEIGHT,  REALWEIGHT,
  DESTKEY,  PRICEKEY,  PRICE,	  SUMNCU,  AFULL,  ACHAG,  AVIEW,  DISABLED,
  RESERVEDfrom CTL_INVOICEPOS where
  ID = :ID SelectSQL.StringsSELECT   G.NAME AS GOODNAME, G.ALIAS,   DEST.NAME AS DESTNAME,  /  CTL.LIVEWEIGHT, CTL.MEATWEIGHT, CTL.QUANTITY,  CTL.REALWEIGHT, 4  CTL.DESTKEY, CTL.GOODKEY, CTL.ID, CTL.INVOICEKEY, #  CTL.ACHAG, CTL.AFULL, CTL.AVIEW,   CTL.RESERVED FROM  CTL_INVOICEPOS CTL     JOIN GD_GOOD G ON      CTL.GOODKEY = G.ID     JOIN CTL_REFERENCE DEST ON      DEST.ID = CTL.DESTKEY WHERE  CTL.INVOICEKEY = :DOCUMENTKEY  ModifySQL.Stringsupdate CTL_INVOICEPOSset  ID = :ID,  INVOICEKEY = :INVOICEKEY,  GOODKEY = :GOODKEY,  QUANTITY = :QUANTITY,  MEATWEIGHT = :MEATWEIGHT,  LIVEWEIGHT = :LIVEWEIGHT,  REALWEIGHT = :REALWEIGHT,  DESTKEY = :DESTKEY,  AFULL = :AFULL,  ACHAG = :ACHAG,  AVIEW = :AVIEW,  RESERVED = :RESERVEDwhere  ID = :OLD_ID LeftoTop   TDataSourcedsInvoiceLineDataSetibdsInvoiceLineLeft� Top   TFormPlaceSaverFormPlaceSaverOnlyForm	LeftATop   TgsDocNumerator	dnInvoiceDatabasedmDatabase.ibdbGAdmin
DataSource
dsDocumentDocumentType�@ Left_Top   
TIBDataSetibdsContactPropsDatabasedmDatabase.ibdbGAdminTransactionibtrInvoiceAfterInsertibdsContactPropsAfterInsertDeleteSQL.Stringsdelete from GD_CONTACTPROPSwhere  CONTACTKEY = :OLD_CONTACTKEY InsertSQL.Stringsinsert into GD_CONTACTPROPS  (CONTACTKEY, RESERVED)values  (:CONTACTKEY, :RESERVED) RefreshSQL.StringsSelect   CONTACTKEY,
  RESERVEDfrom GD_CONTACTPROPS where  CONTACTKEY = :CONTACTKEY SelectSQL.StringsSELECT  * FROM  GD_CONTACTPROPS P WHERE  P.CONTACTKEY = :SUPPLIERKEY ModifySQL.Stringsupdate GD_CONTACTPROPSset  CONTACTKEY = :CONTACTKEY,  RESERVED = :RESERVEDwhere  CONTACTKEY = :OLD_CONTACTKEY 
DataSource	dsInvoiceLeft� Top   TatSQLSetup
atSQLSetupIgnoresLinkibdsInvoiceLineRelationNameGD_GOOD
IgnoryTypeitFull  Left#Top   TDataSourcedsContactPropsDataSetibdsContactPropsLeftTop   TIBSQLIBSQLDoubleListDatabasedmDatabase.ibdbGAdminSQL.Stringsselect * from ctl_invoicepos ip%where ip.invoicekey = :invoicekey and     exists (        select id from        ctl_invoicepos ip2.        where ip2.invoicekey = :invoicekey and5        ip.goodkey = ip2.goodkey and ip2.id <> ip.id)ORDER BY goodkey TransactionibtrInvoiceLeftTop�   TIBSQLibsqlUpdateLineDatabasedmDatabase.ibdbGAdminSQL.Stringsupdate ctl_invoicepos   set LIVEWEIGHT = :LIVEWEIGHT,MEATWEIGHT =  :MEATWEIGHT, QUANTITY = :QUANTITY, REALWEIGHT = :REALWEIGHTwhere id = :id  TransactionibtrInvoiceLeft7Top�   TIBSQLIBSQLDeletePosDatabasedmDatabase.ibdbGAdminSQL.Stringsdelete from ctl_invoicepos where id = :id  TransactionibtrInvoiceLeftUTop�    