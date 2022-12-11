program ab23hcvcl;

uses
  Vcl.Forms,
  uMainView in 'uMainView.pas' {MainView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainView, MainView);
  Application.Run;
end.
