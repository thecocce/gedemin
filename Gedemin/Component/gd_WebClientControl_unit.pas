
unit gd_WebClientControl_unit;

interface

uses
  Classes, Windows, Messages, SyncObjs, SysUtils, idHTTP, idURI, idComponent,
  idThreadSafe, gdMessagedThread, gd_FileList_unit, gd_ProgressNotifier_unit;

type
  TgdWebClientThread = class(TgdMessagedThread)
  private
    FgdWebServerURL: TidThreadSafeString;
    FConnected: TidThreadSafeInteger;
    FServerFileList: TFLCollection;
    FInUpdate: Boolean;
    FHTTP: TidHTTP;
    FCmdList: TStringList;
    FURI: TidURI;
    FProgressWatch: IgdProgressWatch;
    FPI: TgdProgressInfo;
    FDBID: Integer;
    FCompanyName, FCompanyRUID: String;
    FLocalIP: String;
    FEXEVer: String;
    FUpdateToken: String;
    FPath: String;
    FWebServerResponse: String;

    function LoadWebServerURL: Boolean;
    function QueryWebServer: Boolean;
    function UpdateFiles: Boolean;
    function ProcessUpdateCommand: Boolean;
    procedure FinishUpdate;

    function GetgdWebServerURL: String;
    procedure SetgdWebServerURL(const Value: String);

    procedure DoOnWork(Sender: TObject; AWorkMode: TWorkMode; const AWorkCount: Integer);
    procedure DoOnProgressWatch(Sender: TObject; const AProgressInfo: TgdProgressInfo);
    procedure SyncProgressWatch;
    function GetProgressWatch: IgdProgressWatch;
    procedure SetProgressWatch(const Value: IgdProgressWatch);

  protected
    function ProcessMessage(var Msg: TMsg): Boolean; override;
    procedure LogError; override;
    procedure Setup; override;
    procedure TearDown; override;

  public
    constructor Create;
    destructor Destroy; override;

    procedure AfterConnection;
    procedure StartUpdateFiles;

    property gdWebServerURL: String read GetgdWebServerURL write SetgdWebServerURL;
    property ProgressWatch: IgdProgressWatch read GetProgressWatch write SetProgressWatch;
  end;

  EgdWebClientThread = class(Exception);

var
  gdWebClientThread: TgdWebClientThread;

implementation

uses
  ComObj, ActiveX, gdcJournal, gd_security, JclSimpleXML, gdcBaseInterface,
  gdNotifierThread_unit, gd_directories_const, JclFileUtils,
  Forms, gd_CmdLineParams_unit, gd_GlobalParams_unit, jclSysInfo;

const
  WM_GD_AFTER_CONNECTION       = WM_USER + 1118;
  WM_GD_QUERY_SERVER           = WM_USER + 1119;
  WM_GD_GET_FILES_LIST         = WM_USER + 1120;
  WM_GD_UPDATE_FILES           = WM_USER + 1121;
  WM_GD_PROCESS_UPDATE_COMMAND = WM_USER + 1122;
  WM_GD_FINISH_UPDATE          = WM_USER + 1123;

{ TgdWebClientThread }

constructor TgdWebClientThread.Create;
begin
  inherited Create(True);
  FreeOnTerminate := False;
  Priority := tpLowest;
  FHTTP := TidHTTP.Create(nil);
  FHTTP.HandleRedirects := True;
  FHTTP.ReadTimeout := gd_GlobalParams.GetWebClientTimeout;
  FHTTP.ConnectTimeout := gd_GlobalParams.GetWebClientTimeout;
  FHTTP.OnWork := DoOnWork;
  FURI := TidURI.Create;
  FgdWebServerURL := TidThreadSafeString.Create;
  FConnected := TidThreadSafeInteger.Create;
  FPath := ExtractFilePath(Application.ExeName);
end;

procedure TgdWebClientThread.AfterConnection;
begin
  Assert(IBLogin <> nil);

  if FConnected.Value <> 0 then
    exit;

  if gd_GlobalParams.GetWebServerActive then
    exit;

  gdWebServerURL := gd_GlobalParams.GetWebClientRemoteServer;
  if gdWebServerURL > '' then
  begin
    FURI.URLDecode(gdWebServerURL);
    if FURI.Protocol = '' then
      gdWebServerURL := 'http://' + gdWebServerURL;
  end;    

  FDBID := IBLogin.DBID;
  FCompanyName := IBLogin.CompanyName;
  FCompanyRUID := gdcBaseManager.GetRUIDStringByID(IBLogin.CompanyKey);
  FLocalIP := GetIPAddress(IBLogin.ComputerName);
  if VersionResourceAvailable(Application.EXEName) then
    with TjclFileVersionInfo.Create(Application.EXEName) do
    try
      FEXEVer := BinFileVersion;
    finally
      Free;
    end;
  FUpdateToken := gd_GlobalParams.UpdateToken;

  PostMsg(WM_GD_AFTER_CONNECTION);
end;

function TgdWebClientThread.QueryWebServer: Boolean;
begin
  Result := False;
  if gdWebServerURL = '' then
    ErrorMessage := 'gdWebServerURL is not assigned.'
  else if FInUpdate then
    ErrorMessage := 'Update process is running.'
  else begin
    FURI.URI := gdWebServerURL;
    gdNotifierThread.Add('����������� � �������: ' + FURI.Host + '...', 0, 2000);
    try
      FWebServerResponse := FHTTP.Get(TidURI.URLEncode(gdWebServerURL + '/query?' +
        'dbid=' + IntToStr(FDBID) +
        '&c_name=' + FCompanyName +
        '&c_ruid=' + FCompanyRUID +
        '&loc_ip=' + FLocalIP +
        '&exe_ver=' + FExeVer +
        '&update_token=' + FUpdateToken));
      Result := True;
      gdNotifierThread.Add('����������� ������ �������.', 0, 2000);
    except
      gdNotifierThread.Add('��������� ������ � �������� �����������!', 0, 2000);
      raise;
    end;
  end;
end;

function TgdWebClientThread.LoadWebServerURL: Boolean;
begin
  if gdWebServerURL = '' then
  begin
    FURI.URI := Gedemin_NameServerURL;
    gdNotifierThread.Add('����� �������: ' + FURI.Host + '...', 0, 2000);
    gdWebServerURL := FHTTP.Get(Gedemin_NameServerURL);
  end;

  if gdWebServerURL > '' then
  begin
    gdNotifierThread.Add('��������� ����� ���������� �������: ' + gdWebServerURL, 0, 2000);
    Result := True;
  end else
  begin
    gdNotifierThread.Add('����� ���������� ������� �� ���������.', 0, 2000);
    Result := False;
  end;
end;

function TgdWebClientThread.UpdateFiles: Boolean;
var
  ResponseData: TStringStream;
begin
  if gd_GlobalParams.NetworkDrive or gd_GlobalParams.CDROMDrive then
    Result := False
  else begin
    if FServerFileList = nil then
    begin
      ResponseData := TStringStream.Create('');
      try
        FHTTP.Get(TidURI.URLEncode(gdWebServerURL + '/get_files_list'), ResponseData);
        FServerFileList := TFLCollection.Create;
        FServerFileList.ParseXML(ResponseData.DataString);
        FServerFileList.OnProgressWatch := DoOnProgressWatch;
      finally
        ResponseData.Free;
      end;
    end;

    if FCmdList = nil then
      FCmdList := TStringList.Create
    else
      FCmdList.Clear;

    Result := True;
  end;  
end;

function TgdWebClientThread.ProcessMessage(var Msg: TMsg): Boolean;
begin
  Result := True;
  case Msg.Message of
    WM_GD_AFTER_CONNECTION:
      if (FConnected.Value = 0) and LoadWebServerURL then
      begin
        FConnected.Value := 1;
        PostThreadMessage(ThreadID, WM_GD_QUERY_SERVER, 0, 0);
      end;

    WM_GD_QUERY_SERVER:
      if QueryWebServer then
      begin
        if Pos('UPDATE', FWebServerResponse) > 0 then
          PostThreadMessage(ThreadID, WM_GD_UPDATE_FILES, 0, 0);
      end;

    WM_GD_UPDATE_FILES:
      begin
        FInUpdate := True;
        if UpdateFiles then
          PostThreadMessage(ThreadID, WM_GD_PROCESS_UPDATE_COMMAND, 0, 0)
        else
          FInUpdate := False;
      end;

    WM_GD_PROCESS_UPDATE_COMMAND:
      if ProcessUpdateCommand then
        PostThreadMessage(ThreadID, WM_GD_PROCESS_UPDATE_COMMAND, 0, 0)
      else
        PostThreadMessage(ThreadID, WM_GD_FINISH_UPDATE, 0, 0);

    WM_GD_FINISH_UPDATE:
      begin
        FinishUpdate;
        FInUpdate := False;
      end;
  else
    Result := False;
  end;
end;

procedure TgdWebClientThread.LogError;
begin
  TgdcJournal.AddEvent(ErrorMessage, 'HTTPClient', -1, nil, True);
end;

procedure TgdWebClientThread.Setup;
begin
  inherited;
  Assert(CoInitialize(nil) = S_OK);
end;

procedure TgdWebClientThread.TearDown;
begin
  CoUninitialize;
  inherited;
end;

destructor TgdWebClientThread.Destroy;
begin
  inherited;
  FgdWebServerURL.Free;
  FConnected.Free;
  FServerFileList.Free;
  FHTTP.Free;
  FCmdList.Free;
  FURI.Free;
end;

function TgdWebClientThread.GetgdWebServerURL: String;
begin
  Result := FgdWebServerURL.Value;
end;

procedure TgdWebClientThread.SetgdWebServerURL(const Value: String);
begin
  FgdWebServerURL.Value := Value;
end;

function TgdWebClientThread.ProcessUpdateCommand: Boolean;
begin
  Result := FServerFileList.UpdateFile(FHTTP, gdWebServerURL, FCmdList);
end;

procedure TgdWebClientThread.FinishUpdate;
var
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  FName: String;
begin
  if Assigned(FCmdList) then
  try
    if FCmdList.Count > 0 then
    begin
      FCmdList.SaveToFile(FPath + Gedemin_Updater_Ini);
      FName := FPath + Gedemin_Updater;
      FillChar(StartupInfo, SizeOf(TStartupInfo), #0);
      StartupInfo.cb := SizeOf(TStartupInfo);
      if not CreateProcess(PChar(FName),
        PChar('"' + FName + '" ' + IntToStr(GetCurrentProcessID)),
        nil, nil, False, NORMAL_PRIORITY_CLASS or CREATE_NO_WINDOW, nil, nil,
        StartupInfo, ProcessInfo) then
      begin
        ErrorMessage := 'Can not start ' + Gedemin_Updater + '. ' +
          SysErrorMessage(GetLastError);
      end;
    end;
  finally
    FreeAndNil(FCmdList);
  end;
  FServerFileList.OnProgressWatch := nil;
end;

procedure TgdWebClientThread.StartUpdateFiles;
begin
  PostMsg(WM_GD_UPDATE_FILES);
end;

procedure TgdWebClientThread.DoOnWork(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
  if Terminated then
    Abort;
end;

procedure TgdWebClientThread.DoOnProgressWatch(Sender: TObject;
  const AProgressInfo: TgdProgressInfo);
begin
  FPI := AProgressInfo;
  Synchronize(SyncProgressWatch);
end;

procedure TgdWebClientThread.SyncProgressWatch;
begin
  if Assigned(FProgressWatch) then
    FProgressWatch.UpdateProgress(FPI);
end;

function TgdWebClientThread.GetProgressWatch: IgdProgressWatch;
begin
  Lock;
  try
    Result := FProgressWatch;
  finally
    Unlock;
  end;
end;

procedure TgdWebClientThread.SetProgressWatch(
  const Value: IgdProgressWatch);
begin
  Lock;
  try
    FProgressWatch := Value;
  finally
    Unlock;
  end;
end;

initialization
  gdWebClientThread := TgdWebClientThread.Create;
  gdWebClientThread.Resume;

finalization
  FreeAndNil(gdWebClientThread);
end.