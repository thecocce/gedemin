unit ProjectCommon;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Messages;

const
  WM_BARCODE_LABEL = WM_USER + 1;
  AM_DCD_SCAN = WM_USER + 1001;
  WM_SCAN_DATA = WM_USER + 100;
  AM_DCD_TIMEOUT = WM_USER + 1002;

implementation

end.

