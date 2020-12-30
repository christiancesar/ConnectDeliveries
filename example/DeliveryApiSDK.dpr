program DeliveryApiSDK;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  uFormMain in 'uFormMain.pas' {FormMain},
  uiFood in '..\src\uiFood.pas',
  uiFood.Authentication in '..\src\uiFood.Authentication.pas',
  uiFood.Credential in '..\src\uiFood.Credential.pas',
  uClassBaseDelivery in '..\src\Common\uClassBaseDelivery.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.UseMetropolisUI;
  TStyleManager.TrySetStyle('Metropolis UI Dark');
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Metropolis UI Application';
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
