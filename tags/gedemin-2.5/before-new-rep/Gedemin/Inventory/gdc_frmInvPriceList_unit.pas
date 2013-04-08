
{++


  Copyright (c) 2001 by Golden Software of Belarus

  Module

    gdc_frmInvPriceList_unit.pas

  Abstract

    Part of a business class. Price List document.

  Author

    Romanovski Denis (23-10-2001)

  Revisions history

    Initial  23-10-2001  Dennis  Initial version.

--}

unit gdc_frmInvPriceList_unit;


interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  gdc_frmMDHGR_unit, Db, Menus, ActnList, Grids, DBGrids, gsDBGrid,
  gsIBGrid, ToolWin, ComCtrls, ExtCtrls, TB2Item, TB2Dock, TB2Toolbar,
  gdcInvPriceList_unit, IBCustomDataSet, gdcBase, gdcClasses, gdcTree,
  gd_MacrosMenu, StdCtrls, gsDesktopManager;

type
  Tgdc_frmInvPriceList = class(Tgdc_frmMDHGR)
    gdcInvPriceList: TgdcInvPriceList;
    gdcInvPriceListLine: TgdcInvPriceListLine;
    procedure FormCreate(Sender: TObject);
  private


  public
    constructor Create(AnOwner: TComponent); override;
    class function CreateAndAssign(AnOwner: TComponent): TForm; override;
    class function GetSubTypeList(SubTypeList: TStrings): Boolean; override;
    procedure SaveDesktopSettings; override;
  end;

var
  gdc_frmInvPriceList: Tgdc_frmInvPriceList;

implementation

{$R *.DFM}

uses
  gd_ClassList, Storages;

{ Tgdc_frmMDHGR1 }

constructor Tgdc_frmInvPriceList.Create(AnOwner: TComponent);
begin
  inherited Create(AnOwner);
end;

class function Tgdc_frmInvPriceList.CreateAndAssign(AnOwner: TComponent): TForm;
begin
  Result := nil;
end;

procedure Tgdc_frmInvPriceList.FormCreate(Sender: TObject);
begin
  gdcObject := gdcInvPriceList;
  gdcDetailObject := gdcInvPriceListLine;

  gdcInvPriceList.SubType := FSubType;  
  gdcInvPriceListLine.SubType := FSubType;

  inherited;

  Caption := gdcInvPriceList.DocumentName[True];
end;

class function Tgdc_frmInvPriceList.GetSubTypeList(
  SubTypeList: TStrings): Boolean;
begin
  Result := TgdcInvPriceList.GetSubTypeList(SubTypeList);
end;

procedure Tgdc_frmInvPriceList.SaveDesktopSettings;
begin
  inherited;
  if Assigned(DesktopManager) then
    DesktopManager.SaveDesktopItem(Self);

end;

initialization
  RegisterFrmClass(Tgdc_frmInvPriceList);

finalization
  UnRegisterFrmClass(Tgdc_frmInvPriceList);

end.
 