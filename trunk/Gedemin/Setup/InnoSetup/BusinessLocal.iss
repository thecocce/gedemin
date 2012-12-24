; External components: Windows Script Host, Windows Script Control

#include "CommonLocal.iss"

[Setup]
AppName=�������: ����������� �������������
AppVerName=�������: ����������� �������������

[Files]
Source: "Database\business.bk"; DestDir: "{app}\Database"; Flags: deleteafterinstall; Tasks: databasefile

[Code]
function GetSafeAppName(Param: String): String;
begin
  Result := '����������� �������������';
end;

function GetDBFileName(Param: String): String;
begin
  Result := 'business.fdb';
end;

function GetBKFileName(Param: String): String;
begin
  Result := 'business.bk';
end;

function GetRegAccessSubKey(Param: String): String;
begin
  Result := GetSafeAppName('');
end;

