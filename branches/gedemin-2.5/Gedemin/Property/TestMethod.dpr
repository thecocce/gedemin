program TestMethod;

uses
  Forms,
  TestMetod_unit in 'TestMetod_unit.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
