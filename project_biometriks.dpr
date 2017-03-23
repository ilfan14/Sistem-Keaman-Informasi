program project_biometriks;

uses
  Vcl.Forms,
  unit_biometriks in 'unit_biometriks.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
