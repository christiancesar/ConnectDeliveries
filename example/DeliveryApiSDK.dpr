program DeliveryApiSDK;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  uFormMain in 'uFormMain.pas' {FormMain},
  uClassBaseDelivery in '..\src\Common\uClassBaseDelivery.pas',
  uiFood.Authentication in '..\src\iFood\ParseClasses\uiFood.Authentication.pas',
  uiFood.Credential in '..\src\iFood\ParseClasses\uiFood.Credential.pas',
  uiFood.Merchant in '..\src\iFood\ParseClasses\uiFood.Merchant.pas',
  uiFood in '..\src\iFood\uiFood.pas';

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
