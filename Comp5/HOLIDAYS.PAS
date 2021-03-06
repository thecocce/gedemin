{++

  Component
  Copyright c) 98 by Golden Software

  Module

    holidays.pas

  Abstract

     Component to show congratulation message

  Author

    Vladimir Vorobey (18-March-1998)

  Contact address

    andreik@gs.minsk.by

  Uses

    -

  Revisions history

    -

  Known bugs

    -

  Wishes

    -

--}


unit Holidays;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

const
  defHolidaysEnabled = true;
  defDateSize = 6;

type
  THolidays = class(TComponent)
  private
    FEnabled: boolean;
    FHolidays: TStringList;

    FormOnActivate: TNotifyEvent;

    procedure SetHolidays(AValue: TStringList);

    procedure Loaded; override;
    procedure Congratulation;
    procedure MyFormOnActivate(Sender: TObject);

  public
    constructor Create(AnOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: boolean read FEnabled write FEnabled
      default defHolidaysEnabled;
    property Holidays: TStringList read FHolidays write SetHolidays;
  end;

implementation

constructor THolidays.Create;
begin
  inherited Create(AnOwner);
  Enabled := defHolidaysEnabled;
  FHolidays := TStringList.Create;
  FormOnActivate := nil;
end;

destructor THolidays.Destroy;
begin
  FHolidays.Free;
  inherited Destroy;
end;

procedure THolidays.SetHolidays(AValue: TStringList);
begin
  FHolidays.Assign(AValue);
end;

(*
  Procedure
    Loaded

  Description
    ������������� ���������� �� ������� OnActivate �����

  Input
    -

  Output
    -

  Comments
    ��������� ���� Enabled � ������������� ���������� OnActivate �����
    �� MyOnActivate �����, �������������� �������� �������� ������� �
    FormOnActivate. � ������ csDesigning ���������� �� �������.

*)

procedure THolidays.Loaded;
begin
  if not (csDesigning in ComponentState) then
    if Enabled then
      if (Owner is TForm) then
        begin
          if Assigned(TForm(Owner).OnActivate) then
            FormOnActivate := TForm(Owner).OnActivate;
          TForm(Owner).OnActivate := MyFormOnActivate;
        end;
end;

(*
  Procedure
    Congratulation

  Description
    ����� ���������������� ���������

  Input
    -

  Output
    -

  Comments
    �������� �� �������� Holidays ������, ��������� �� ��
    ���� � ���������, �������� �� ������������ ������� ���� �
    ������� � ������ ������������ ���������.

*)

procedure THolidays.Congratulation;
var
  i: integer;
  s : string;
  Day, Month, Year, Day1, Month1: word;
begin
  DecodeDate(Date, Year, Month, Day);
  for i := 0 to Holidays.Count - 1 do
  begin
    s := Holidays.Strings[i];
    if length(s) > defDateSize then
    try
      day1 := StrToInt(copy(s,4,2));
      Month1 := StrToInt(copy(s,1,2));
      if (day = day1) and (month = month1) then
        ShowMessage(copy(s, defDateSize, length(s) - (defDateSize - 1)));
    except
    end;
  end;
end;

(*
  Procedure
    MyFormOnActivate

  Description
    ���������� ������� OnActivate �����

  Input
    -

  Output
    -

  Comments
    ������� ��������������� ���������. ��������������� ������ ����������
    OnActivate ����� � ������������� ��� ��������.

*)

procedure THolidays.MyFormOnActivate;
begin
  if Enabled then Congratulation;
  if (Owner is TForm) then
  begin
    if Assigned(FormOnActivate) then
    begin
      TForm(Owner).OnActivate := FormOnActivate;
      // �������������� ����� OnActivate ������� �����
      FormOnActivate(Self);
    end;
  end;
end;

end.
