program ConnectDeliveries;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  uFormMain in 'uFormMain.pas' {FormMain},
  uBaseDelivery in '..\src\Common\uBaseDelivery.pas',
  uiFood.Authentication in '..\src\iFood\ParseClasses\uiFood.Authentication.pas',
  uiFood.Credential in '..\src\iFood\ParseClasses\uiFood.Credential.pas',
  uiFood.Merchant in '..\src\iFood\ParseClasses\uiFood.Merchant.pas',
  uiFood in '..\src\iFood\uiFood.pas',
  uiFood.Unavailability in '..\src\ifood\parseClasses\uiFood.Unavailability.pas',
  uiFood.Availability in '..\src\ifood\parseClasses\uiFood.Availability.pas',
  uiFood.Validation in '..\src\ifood\parseClasses\uiFood.Validation.pas',
  uiFood.Reopenable in '..\src\ifood\parseClasses\uiFood.Reopenable.pas',
  uiFood.Message in '..\src\ifood\parseClasses\uiFood.Message.pas',
  uiFood.Polling in '..\src\ifood\parseClasses\uiFood.Polling.pas',
  uiFood.Address in '..\src\ifood\parseClasses\uiFood.Address.pas',
  uiFood.MerchantDetail in '..\src\ifood\parseClasses\uiFood.MerchantDetail.pas',
  uReturnMessage in '..\src\common\uReturnMessage.pas',
  uiFood.ReplacementOptions in '..\src\ifood\parseClasses\uiFood.ReplacementOptions.pas',
  uiFood.OrderDetail in '..\src\ifood\parseClasses\uiFood.OrderDetail.pas',
  uiFood.SubItem in '..\src\ifood\parseClasses\uiFood.SubItem.pas',
  uiFood.Item in '..\src\ifood\parseClasses\uiFood.Item.pas',
  uiFood.PickupAreaAssigned in '..\src\ifood\parseClasses\uiFood.PickupAreaAssigned.pas',
  uiFood.MetaData in '..\src\ifood\parseClasses\uiFood.MetaData.pas',
  uiFood.DeliveryMethod in '..\src\ifood\parseClasses\uiFood.DeliveryMethod.pas',
  uiFood.SponsorshipValues in '..\src\ifood\parseClasses\uiFood.SponsorshipValues.pas',
  uiFood.Benefits in '..\src\ifood\parseClasses\uiFood.Benefits.pas',
  uiFood.Localizer in '..\src\ifood\parseClasses\uiFood.Localizer.pas',
  uiFood.Coordinates in '..\src\ifood\parseClasses\uiFood.Coordinates.pas',
  uiFood.DeliveryAddress in '..\src\ifood\parseClasses\uiFood.DeliveryAddress.pas',
  uiFood.Customer in '..\src\ifood\parseClasses\uiFood.Customer.pas',
  uiFood.Payment in '..\src\ifood\parseClasses\uiFood.Payment.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.UseMetropolisUI;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Metropolis UI Application';
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
