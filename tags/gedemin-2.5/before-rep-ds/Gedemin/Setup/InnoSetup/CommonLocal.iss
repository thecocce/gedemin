; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
AppID=Ged25Local
AppPublisher=Golden Software of Belarus, Ltd
AppPublisherURL=http://www.gsbelarus.com
AppSupportURL=http://www.gsbelarus.com
AppUpdatesURL=http://www.gsbelarus.com
AppSupportPhone=+375-17-2921333, +375-17-3313546
DefaultDirName={pf}\Golden Software\Gedemin 2.5\Local
DefaultGroupName=Golden Software ������� 2.5
DisableProgramGroupPage=yes
OutputDir=d:\temp\setup
OutputBaseFilename=setup
Compression=lzma/ultra
SolidCompression=yes
MinVersion=0,5.01sp2
Uninstallable=yes
ShowLanguageDialog=auto
SourceDir=D:\Golden\Gedemin_Local_FB\
UsePreviousAppDir=yes
DisableReadyPage=yes

[Languages]
Name: "english"; MessagesFile: "compiler:default.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags:
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "gedemin.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "fbclient.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "fbclient.dll"; DestDir: "{app}\fbembed.dll"; Flags: ignoreversion
Source: "gedemin.jpg"; DestDir: "{app}"; Flags: ignoreversion
Source: "gsdbquery.dll"; DestDir: "{app}"; Flags: ignoreversion regserver
Source: "UDF\gudf.dll"; DestDir: "{app}\UDF"; Flags: ignoreversion
Source: "ib_util.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "icudt30.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "icuin30.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "icuuc30.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "msvcp80.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "msvcr80.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "Microsoft.VC80.CRT.manifest"; DestDir: "{app}"; Flags: ignoreversion
Source: "firebird.msg"; DestDir: "{app}"; Flags: ignoreversion
Source: "Intl\fbintl.dll"; DestDir: "{app}\Intl"; Flags: ignoreversion
Source: "Intl\fbintl.conf"; DestDir: "{app}\Intl"; Flags: ignoreversion
Source: "gbak.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "midas.dll"; DestDir: "{sys}"; Flags: regserver onlyifdoesntexist sharedfile

Source: "Help\fr24rus.chm"; DestDir: "{app}\Help"; Flags: ignoreversion
Source: "Help\vbs55.chm"; DestDir: "{app}\Help"; Flags: ignoreversion

[Icons]
Name: "{group}\{code:GetSafeAppName}"; Filename: "{app}\gedemin.exe"; WorkingDir: "{app}"
Name: "{group}\www.gsbelarus.com"; Filename: "http://www.gsbelarus.com"; IconFileName: "{app}\gedemin.exe"
Name: "{commondesktop}\{code:GetSafeAppName}"; Filename: "{app}\gedemin.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{code:GetSafeAppName}"; Filename: "{app}\gedemin.exe"; Tasks: quicklaunchicon
Name: "{group}\{cm:UninstallProgram,{code:GetSafeAppName}}"; Filename: "{uninstallexe}"; WorkingDir: "{app}"

[Registry]
Root: HKLM; SubKey: "SOFTWARE\Golden Software\Gedemin\Client\CurrentVersion\Access"; ValueType: string; ValueName: "UserName"; ValueData: ""; Flags: deletevalue uninsdeletevalue
Root: HKLM; SubKey: "SOFTWARE\Golden Software\Gedemin\Client\ExecuteFiles"; ValueType: dword; ValueName: "{app}\gedemin.exe"; ValueData: 0; Flags: deletevalue uninsdeletevalue
Root: HKLM; SubKey: "SOFTWARE\Golden Software\Gedemin\Client\CurrentVersion"; ValueType: string; ValueName: "ServerName"; ValueData: "{app}\Database\{code:GetDBFileName}"; Flags: deletevalue uninsdeletevalue
Root: HKLM; SubKey: "SOFTWARE\Golden Software\Gedemin\Client\CurrentVersion\Access\{code:GetRegAccessSubKey}"; ValueType: string; ValueName: "Database"; ValueData: "{app}\Database\{code:GetDBFileName}"; Flags: deletekey uninsdeletekey
Root: HKLM; SubKey: "Software\Golden Software"; Flags: uninsdeletekeyifempty
Root: HKLM; Subkey: "SOFTWARE\Golden Software\Gedemin\Client\CurrentVersion\Setting"; Flags: uninsdeletekey
Root: HKCU; SubKey: "SOFTWARE\Golden Software\Gedemin\Client\CurrentVersion\Access\{code:GetRegAccessSubKey}"; Flags: deletekey uninsdeletekey
Root: HKCU; SubKey: "Software\Golden Software\Gedemin\Client"; Flags: uninsdeletekey
Root: HKCU; SubKey: "Software\Golden Software\Gedemin"; Flags: uninsdeletekeyifempty
Root: HKCU; SubKey: "Software\Golden Software"; Flags: uninsdeletekeyifempty

[Run]
FileName: "{app}\gbak.exe"; Parameters: "-c -p 8192 -bu 4096 -user SYSDBA -pas masterkey Database\{code:GetBKFileName} Database\{code:GetDBFileName}"; WorkingDir: {app}; StatusMsg: "���������� ���� ������..."; Flags: waituntilterminated runhidden
Filename: "{app}\gedemin.exe"; Description: "{cm:LaunchProgram,{code:GetSafeAppName}}"; WorkingDir: {app}; Flags: nowait postinstall skipifsilent

[UninstallRun]
FileName: "{app}\gbak.exe"; Parameters: "-b -user SYSDBA -pas masterkey Database\{code:GetDBFileName} Database\{code:GetBKFileName}"; WorkingDir: {app}; StatusMsg: "������������� ���� ������..."; Flags: waituntilterminated runhidden

[Code]

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := PageID = wpFinished;
end;

(*

function InitializeSetup(): Boolean;
begin
  Result := True;
end;

procedure CurStepChanged(CurStep: TSetupStep);
var
  RC: Integer;
begin
  if CurStep = ssInstall then
  begin
    if FileExists(ExpandConstant('{app}') + '\unins000.exe') and FileExists(ExpandConstant('{app}') + '\gedemin.exe') then
    begin
      if MsgBox('� ��������� �������� ���������� ����� ������������� ��������� �������. ��������� �� ������������?', mbConfirmation, MB_YESNO) = IDYES then
      begin
        if not Exec(ExpandConstant('{app}') + '\unins000.exe', '', ExpandConstant('{app}'), SW_HIDE, ewWaitUntilTerminated, RC) then
        begin
          MsgBox(SysErrorMessage(RC), mbError, MB_OK);
          Abort;
        end;
      end else
      begin
        MsgBox('������� ��������� ������� ������� � ��������� ���������.', mbError, MB_OK);
        Abort;
      end;
    end;
  end;
end;

*)

