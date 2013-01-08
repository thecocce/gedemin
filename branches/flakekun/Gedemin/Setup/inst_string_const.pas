unit inst_string_const;

interface

const
  cFirstPage =      
        '��� ������ ��������� ����� ����������� ������ (������) ���� ' +
        '������ � ����������� ������ ��������� �������. ����� �����, ' +
        '�������� �������, ����� ���������� ������� ������� (������ ��������) ' +
        '��� ������ ����������� (�����������).'#13#10#13#10 +
        '�������� ���� ��� ��������� ��������� (����������) ����� ' +
        '���� ������ � ����������� ������� ��������� �������.';

  cWrongClientType = '��������, ��� ��������� � ���������� ����� ���� ������ �� ���������! ' +
     '��� ����� �������� � ������������ ������ ����������. ������ ���� ����� ���� ������ ' +
     '������������ ���������� ������� ���� ������ �� ����� ����������, ��� ��������� ������ ���������. ��� ' +
     '����������� ���������� ������ ������� ������������ ������ ���� ������ ' +
     '��� ��������� ���������� ���. ����� ����� ����� ��������� ��������� ���������.';
                                               
  cFirstChangePassword = '%s ��������������� �� ������ ��������� � ������ ���. ' +
   '������������� �������� ������ ��� ������������ SYSDBA. �������� ������?';

  cAutoSearchDB = '���������� ������� ���� � ���� ������. �� ������ ������� ���� ' +
   '������� ��� ���������� �������������� ����� (����� ����� �������� �������� ������� Escape). ' +
   ' ���������� �������������� �����?';

  cDBDetected = '��������� ���� %s. ������������ ��� � �������� ������� ���� ������?';
                                                               
  cCantDetectDB = '�� ������� ���������� ���� ������. ��������, ������ �� ' +
   '����������, �� ������� ��� � ��� ��� ����������������� ���� � ������. ' +
   '������� ���� ������ �������.';
                                      
  cCantConnectDB = '�� ������� ����������� � ���� ������: "%s". %s ' +
   '������� ���� ������ �������.';

  cBreakSearchDB = '����� ����������. ������� ���� ������ �������.';

  cNotAppropriateDB = '�� ������� ���������� ���������� ���� ������. ' +
   '������� ���� ������ �������.';

{   cIBDetected = '�� ����� ���������� ��������� %s. ��� ���������� ������ ' +
     '��������� ��������� Yaffil ����� ������. �� ������ �������������� ������?';}
                                    
   cIBDetected = '�� ����� ���������� ��������� %s. ��� ���������� ������ ' +
     '��������� ��������� Yaffil �� ������ ������ 877. ���������� ������ Yaffil?'#13#10 +
     '������� �� ��� ��������� �������.'#13#10 +
     '������� ��� ��� ������ �� ��������� ��������� ��������� �������.';


{  cIBDetected = '�� ����� ���������� ��������� %s. ��� ���������� ������ ' +
   '��������� ��������� Interbase Server ����������� ������ 6.0, ���� Firebird, ' +
   '���� Yaffil ����� ������. �� ������ �������������� ������?';}

  cRightIBDetected = '�� ����� ���������� ��������� %s. �� ������������� ' +
   '�������� ���������� ������ ���������. �� ������ ������������ ��� ' +
   '������������� ������?'#13#10 + '������� ��, ���� �� ������ ������������ ��� ' +
   '������������� ������.'#13#10 + '������� ���, ���� �� ������ �������� ������ �� %s.'#13#10 +
   '������� ������, ���� �� ������ �������� ���������.';

  cRightClientDetected = '�� ����� ���������� ��������� %s. �� ������������� ' +
   '�������� ���������� ������ ���������. ������������ ������������� ������?'#13#10 +
   '������� ��, ���� �� ������ ������������ ��� ������������� ������.'#13#10 +
   '������� ���, ���� �� ������ �������� ������ �� %s.';
  
  cClientDetected = '�� ����� ���������� ��������� %s. ��� ���������� ������ ' +
     '��������� ��������� Yaffil ����� ������. ���������� Yaffil ������?'#13#10 +
     '������� �� ��� ��������� �������.'#13#10 +
     '������� ��� ��� ������ �� ��������� ��������� �������� �������.';
 
  cRightDBDetected = '���� ������ %s ��� ���������� �� ����� ����������. ' +
   '�� ������ ������������ ��� ������������ ����?'#13#10 +
   '������� ��, ����� ������������ ������������ ����.'#13#10 +
   '������� ���, ����� �������� ������������ ���� ������ �� ���������.'#13#10 +
   '������� ������, ����� �� ������������� ��������� ���� ������.';

  cRightDBDetectedWithErr = '�� ����� ���������� ��������� ���� ���� ������: %s. ' +
   '������ � �������� ����������� � ���� �������� ������: %s. ��������, ������ ���� ' +
   '���������� ��� �������������� ��� ������� ���� �������. �� ������ �������� ���� � ���� ������?'#13#10 +
   '������� ��, ���� �� ������ �������� ���� � ���� ������.'#13#10 +
   '������� ���, ���� �� ������ �������� ������������ ���� ���� ������.'#13#10 +
   '������� ������, ���� �� ������ �������� ���������.';

  cDefaultDBPath = '�� ��������� ���� ������ %s ����� ����������� � ����� "%s\%s". ' +
   '������ �������� ���� ���������?';

  cDBPathDlgTitle = '���� ��� ��������� ���� ������';

  cUpgradeDB = '��� �������� ��������� ������������� ���������� ��������� ���������� (upgrade) ���� ������ %s. ' +
   '���������� ��?';

{  cQueryReportPassword = '������� ������������ � ������ ��� ����������� ������� ������� � ' +
   '������� ���� ������'; sty}

  cQueryPassword = '������� ��� ������������ � ������ ��� ����������� � ������� ���� ������.';

  cShutDownSystem = '���������� ��������� ������������ �������. ���������� �� ������?';

  cShutDownNeeded = '��� ����������� ��������� ���������� ��������� ������������ �������.';

  cAdminInstall = '��� ��������� ��������� ������������ ������ ������� � ������ ' +
   '���������������. ���������� � �������� ��������������. ����� �� ��������� ���������?';

  cAdminUninstall = '��� �������� ��������� ������������ ������ ������� � ' +
   '������ ���������������. ���������� � �������� ��������������. ����� �� ' +
   '��������� ��������?';

  cUninstallMistake = '� �������� �������� �������� ������: %s';

  cUpdateIBServer = '�� ���������� ��������� %s, ������ �������� ��� ����� ' +
   '����� ������� %s?';
  
  cRemoveUninstall = '��������� ��������� ����� ������� ����� ������������. ' +
    '������������� ��������� ������?';                                     
// ����� ��������� ���������� ��������� ������������.     

  cRightClientCantUpdate = '�� ����� ���������� ��������� %s. ��������� ��������� �� ����� �������� ��� �� %s.';

  cExpCreateUser = '��������� ������ ��� �������� ������������ Interbase: %s';

  cExpInstallationFailed = '���� %s �� ���������. ��������� ��������� ����������.';

  cExpWrongArchiveType = '������ ��� ������ �� ��������������';

  cExpUnknownActionType = '����������� ��� ��������';

  cExpCantCreateFolder = '�� ������� ������� ����� %s';

  cExpCantConnectServiceManager = '���������� ������������ � service control manager.';

  cExpCantSetFileAttr = '�� ������� ����� �������� ReadOnly, Hidden ��� ����� %s';

  cExpCantDetectDB = '�� ������� ���������� ���� ������';

  cExpIBDetected = '�� ���������� ��������� %s. ��������� �������� �������������.';

{  cExpCantFindReportServer = '�� ������� ���������� ���� ������� �������: %s'; sty}

  cExpPassChange = '��������� ������ ��� ��������� ������ ������������: %s';

  cExpCantUnloadServer = '�� ������� ��������� IB ������. ���������� ��� ' +
   '�������� �������, ����� ��������� ��������� ��������� �����.';

  cExpInstallBreak = '��������� �������� �������������';

  cExpCantRegFile = '�� ������� ���������������� ���� %s';

  cExpCantReplaceFile = '�� ������� ����������� ���� %s ��� ����������� ������ %s';

  cExpCantReplaceFile2 = '�� ������� �������� ���� %s';

  cExpWrongDataType = '�������� ��� ������';

  cExpStartError = '��������� ������ ��� ������� %s';

  cExpWrongInstallParam = '��������� ��������� ���� �������� � ����������� ����������';

  cExpAdminInstall = '��� ��������� ��������� ������������ ������ ������� � ������ ���������������.';

  cExpWinSock = '��� ��������� ��������� ���������� ���������� ������� �������� TCP/IP.';

  cExpQueryServiceConfig = '������ ������������ ������: %s';

  cExpChangeServiceConfig = '��������� ������������ ������: %s';

  cExpOpenService = '�������� ������: %s';

  cExpCreateService = '���������� ������� ������: %s';

  cExpQueryServiceStatus = '������ ������� ������: %s';

  cExpCantStartService = '�� ������� ��������� %s. ��� ������ �� ���������� ������.';

  cExpStartService = '������ ������: %s';

  cExpAdminUninstall = '��� �������� ��������� ������������ ������ ' +
   '������� � ������ ���������������.';

  cExpCantUnregFile = '�� ������� ������� ����������� ��� ����� %s';

  cExpWrongNetProtocol = '�������� ������� ��������. %s';

  cExpWrongFileVersionFormat = '�������� ������ ������ �����: %s';

  cExpCantAttachToServer = '�� ������� ����������� � ������� ���� ������';

  cExpRussianServerName = '�������� ������� ����� ��������� ������ ��������� ' +
   '����� � �� ����� ���������� � �����.';
                
  cPathDoesNotExistsQuest = '����� %s �� ����������. ������� ��?';

  cErrDrvType0 = '��� ���������� �� ���������!';
  cErrDrvType1 = '���� �� ������! ��������, �� ��������� ���������� ���� ������ �� ������� ����.';
  cErrDrvTypeDRIVE_REMOTE = '������ ���������� ���� ������ �� ������� ����!';
  cErrDrvTypeDRIVE_CDROM = '������ ���������� ���� ������ �� �������-����!';


implementation

end.