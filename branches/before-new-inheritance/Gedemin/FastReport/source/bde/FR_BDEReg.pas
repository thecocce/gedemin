
{******************************************}
{                                          }
{     FastReport v2.4 - BDE components     }
{            Registration unit             }
{                                          }
{ Copyright (c) 1998-2001 by Tzyganenko A. }
{                                          }
{******************************************}

unit FR_BDEreg;

interface

{$I FR.inc}

procedure Register;

implementation

uses
  Windows, Messages, SysUtils, Classes
{$IFNDEF Delphi6}
, DsgnIntf
{$ELSE}
, DesignIntf, DesignEditors
{$ENDIF}
, FR_BDEDB;

procedure Register;
begin
  RegisterComponents('FastReport', [TfrBDEComponents]);
end;

end.
