; External components: Windows Script Host, Windows Script Control

; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define URL "http://kkc.by"

[Setup]
AppName=POSitive: Check
AppVerName=POSitive: Check
AppID=POSitiveCheck25
AppPublisher=KKC, Ltd
AppPublisherURL={#URL}
AppSupportURL={#URL}
AppUpdatesURL={#URL}
AppSupportPhone=+375-17-32-111-32
DefaultDirName={sd}\KKC\POSitive Check
DefaultGroupName=KKC
DisableProgramGroupPage=yes
OutputDir=c:\temp\setup
OutputBaseFilename=setup
Compression=lzma/ultra
SolidCompression=yes
MinVersion=0,5.01sp2
Uninstallable=yes
ShowLanguageDialog=yes
SourceDir={#SourcePath}\..\..\..\Gedemin_Local_FB\
UsePreviousAppDir=yes
DisableReadyPage=yes

[Languages]
Name: "english"; MessagesFile: "compiler:default.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "databasefile"; Description: "���������� ���� ���� ������"; GroupDescription: "���� ������:"; Flags:
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags:
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "gedemin.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "gedemin_upd.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "gedemin.exe.manifest"; DestDir: "{app}"; Flags: ignoreversion
Source: "fbembed.dll"; DestDir: "{app}"; Flags: ignoreversion
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
Source: "midas.dll"; DestDir: "{app}"; Flags: ignoreversion
Source: "midas.sxs.manifest"; DestDir: "{app}"; Flags: ignoreversion
Source: "Help\fr24rus.chm"; DestDir: "{app}\Help"; Flags: ignoreversion
Source: "Help\vbs55.chm"; DestDir: "{app}\Help"; Flags: ignoreversion
;Source: "menufront.jpg"; DestDir: "{app}"; DestName: "gedemin.jpg"; Flags: ignoreversion
Source: "Database\menufront.bk"; DestDir: "{app}\Database"; Flags: deleteafterinstall; Tasks: databasefile

[INI]
Filename: "{app}\databases.ini"; Section: "{code:GetSafeAppName}"; Key: "FileName"; String: "Database\{code:GetDBFileName}"; Tasks: "databasefile"
Filename: "{app}\databases.ini"; Section: "{code:GetSafeAppName}"; Key: "Selected"; String: "1"; Tasks: "databasefile"
Filename: "{app}\gedemin.ini"; Section: "WEB CLIENT"; Key: "Token"; String: "POSITIVE_CHECK"; 

[Icons]
Name: "{group}\{code:GetSafeAppName}"; Filename: "{app}\gedemin.exe"; WorkingDir: "{app}"
Name: "{group}\{code:GetSafeAppName} �����-����"; Filename: "{app}\gedemin.exe"; Parameters: "/sn ""{app}\Database\{code:GetDBFileName}"" /user Term /password 1"; WorkingDir: "{app}"
Name: "{commondesktop}\{code:GetSafeAppName}"; Filename: "{app}\gedemin.exe"; Tasks: desktopicon
Name: "{commondesktop}\{code:GetSafeAppName} �����-����"; Filename: "{app}\gedemin.exe"; Parameters: "/sn ""{app}\Database\{code:GetDBFileName}"" /user Term /password 1"; WorkingDir: "{app}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{code:GetSafeAppName}"; Filename: "{app}\gedemin.exe"; WorkingDir: "{app}"; Tasks: quicklaunchicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{code:GetSafeAppName} �����-����"; Filename: "{app}\gedemin.exe"; Parameters: "/sn ""{app}\Database\{code:GetDBFileName}"" /user Term /password 1"; WorkingDir: "{app}"; Tasks: quicklaunchicon
Name: "{group}\{cm:UninstallProgram,{code:GetSafeAppName}}"; Filename: "{uninstallexe}"; WorkingDir: "{app}"
Name: "{group}\������������"; Filename: "http://gsbelarus.com/gs/content/downloads/doc/rest_front.pdf"; IconFileName: "{app}\gedemin.exe"

[Run]
FileName: "{app}\gedemin.exe"; Parameters: "/rd /r EMBEDDED ""{app}\Database\{code:GetBKFileName}"" ""{app}\Database\{code:GetDBFileName}"" SYSDBA masterkey 8192 8192"; WorkingDir: {app}; StatusMsg: "���������� ���� ������..."; Flags: waituntilterminated runhidden; Tasks: databasefile
Filename: "{app}\gedemin.exe"; Description: "{cm:LaunchProgram,{code:GetSafeAppName}}"; WorkingDir: {app}; Flags: nowait postinstall skipifsilent

[UninstallDelete]
Type: files; Name: "{app}\gedemin.ini"
Type: files; Name: "{app}\gedemin_upd.ini"
Type: files; Name: "{app}\*.bak"
Type: files; Name: "{app}\*.new"
Type: filesandordirs; Name: "{app}\udf"
Type: filesandordirs; Name: "{app}\Intl"
Type: filesandordirs; Name: "{app}\Help"
Type: dirifempty; Name: "{app}\Database"

[Code]

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := PageID = wpFinished;
end;

function GetSafeAppName(Param: String): String;
begin
  Result := 'POSitive Check';
end;

function GetDBFileName(Param: String): String;
begin
  Result := 'menufront.fdb';
end;

function GetBKFileName(Param: String): String;
begin
  Result := 'menufront.bk';
end;

function GetRegAccessSubKey(Param: String): String;
begin
  Result := GetSafeAppName('');
end;