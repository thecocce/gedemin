�
 TGDC_DLGCUSTOMPAYMENT 0�  TPF0�Tgdc_dlgCustomPaymentgdc_dlgCustomPaymentLeft� Top)Caption��������� ���������ClientHeight�ClientWidth OnShowFormShowPixelsPerInch`
TextHeight �TButton	btnAccessLeftTop�AnchorsakLeftakBottom   �TButtonbtnNewLeftUTop�AnchorsakLeftakBottom   �TButtonbtnOKLeft|Top�AnchorsakLeftakBottom   �TButton	btnCancelLeft�Top�AnchorsakLeftakBottom   �TButtonbtnHelpLeft� Top�AnchorsakLeftakBottom   �TPageControlPageControl1Left TopWidth Height�
ActivePagetsMainAnchorsakLeftakTopakRightakBottom TabOrder 	TTabSheettsMainCaption	��������� TPanelpnlMainLeft Top WidthHeight�AlignalClient
BevelOuterbvNoneTabOrder  TBevelBevel1LeftTop#Width�HeightSShapebsFrame  TBevelBevel3LeftTop}Width�Height;ShapebsFrame  TLabelLabel17LeftTop� WidthEHeightAutoSizeCaption���������� �������:Transparent	WordWrap	  TLabelLabel1LeftTop	Width#HeightCaption�����:Transparent	  TLabelLabel2Left� Top	WidthHeightCaption����:Transparent	  TLabelLabel4Left-Top	WidthXHeightCaption������ �� �����:Transparent	  TLabelLabel12LeftTop^Width#HeightCaption�����:Transparent	  TLabelLabel10LeftTop� Width0HeightCaption	��� ���.:Transparent	  TLabelLabel16LeftgTop� WidthAHeightCaption����. ����.:Transparent	  TLabelLabel6LeftTop� Width?HeightCaption����. ����.:Transparent	  TLabelLabel7Left� Top� WidthLHeightCaption���� �������:Transparent	  TLabelLabel3LeftjTop,WidthHeightCaption����:Transparent	  TLabelLabel11Left� Top� Width6HeightCaption
��� ����.:Transparent	  TLabelLabel18LeftTop,WidthAHeightCaption����������:  TLabelLabel23Left� Top^WidthHeightCaption����:Transparent	  TLabelLabel5LeftTopEWidth!HeightCaption�����:  TLabelLabel20Left� Top�WidthsHeightCaption������� �� ��������:  TLabelLabel8LeftTophWidth2HeightCaption��������  TgsIBLookupComboBoxdbeCorrAccountLeft�Top(WidthkHeightHelpContextDatabasedmDatabase.ibdbGAdminTransaction
ibtrCommon
DataSource	dsgdcBase	DataFieldCORRACCOUNTKEY	ListTableGD_COMPANYACCOUNT	ListFieldACCOUNTKeyFieldIDgdClassNameTgdcAccount
ItemHeightParentShowHintShowHint	TabOrderOnChangedbeCorrAccountChange  TDBMemodbePaymentDestinationLeftZTop� Width�HeightV	DataFieldDESTINATION
DataSource	dsgdcBaseTabOrder  TDBEdit	dbeNumberLeftZTopWidthGHeight	DataFieldNUMBER
DataSource	dsgdcBaseTabOrder   TxDateDBEditdbeDateLeft� TopWidthJHeight	DataFieldDOCUMENTDATE
DataSource	dsgdcBaseKindkDateEditMask!99\.99\.9999;1;_	MaxLength
TabOrder  TDBEditdbeOperLeftUTop� WidthLHeight	DataFieldPROC
DataSource	dsgdcBaseTabOrder  TDBEditdbeQueueLeft�Top� WidthLHeight	DataFieldQUEUE
DataSource	dsgdcBaseTabOrder
  TgsIBLookupComboBoxdbeDestLeftUTop� WidthLHeightHelpContextDatabasedmDatabase.ibdbGAdminTransaction
ibtrCommon
DataSource	dsgdcBase	DataFieldDESTCODEKEY	ListTableBN_DESTCODE	ListFieldCODEKeyFieldID
ItemHeightParentShowHintShowHint	TabOrder  TxDateDBEditdbeTermLeftTop� WidthLHeight	DataFieldTERM
DataSource	dsgdcBaseKindkDateEditMask!99\.99\.9999;1;_	MaxLength
TabOrder  TDBEditdbeOperKindLeftTop� WidthLHeight	DataFieldOPER
DataSource	dsgdcBaseTabOrder	  TgsIBLookupComboBoxdbeCorrCompanyLeftZTop(WidthHeightHelpContextDatabasedmDatabase.ibdbGAdminTransaction
ibtrCommon
DataSource	dsgdcBase	DataFieldCORRCOMPANYKEYFieldsCITY	ListTable8gd_contact join gd_company on gd_company.contactkey = id	ListFieldnameKeyFieldidgdClassNameTgdcBaseContact
ItemHeightParentShowHintShowHint	TabOrderOnChangedbeCorrCompanyChange  TEditedBankLeftTopZWidth� HeightColor	clBtnFaceCtl3D	ParentCtl3DReadOnly	TabOrder  TDBEditdbeAdditionalLeftZTopAWidth�Height	DataFieldCORRCOMPTEXT
DataSource	dsgdcBaseTabOrder  TxDBCalculatorEdit	dbeAmountLeftZTopZWidthpHeightTabOrder	DecDigits	DataFieldAMOUNT
DataSource	dsgdcBase  TgsIBLookupComboBoxgsibluOwnAccountLeft�TopWidthkHeightHelpContextDatabasedmDatabase.ibdbGAdminTransaction
ibtrCommon
DataSource	dsgdcBase	DataField
ACCOUNTKEY	ListTableGD_COMPANYACCOUNT	ListFieldACCOUNTKeyFieldID
ItemHeightParentShowHintShowHint	TabOrder  	TComboBox
cmbExpenseLeft Top�Width� Height
ItemHeightTabOrderItems.Strings�� ���� ������������� ���� �����������@����������� �� ���� �����������, ��������� - �� ���� �����������   TgsTransactionComboBoxgsTransactionComboBoxLeftZTopdWidth�HeightHintD����������� �������: 
     F4 - �������� � �������������� ��������.StylecsDropDownList
ItemHeightParentShowHintShowHint	TabOrder
DataSource	dsgdcBase	DataField	TRTYPEKEY    	TTabSheettsAttributeCaption��������
ImageIndex TatContaineratContainerLeft Top WidthHeight�
DataSource	dsgdcBaseAlignalClientTabOrder     �TActionListalBaseLeft�TopG  �TDataSource	dsgdcBaseLeft�TopG   