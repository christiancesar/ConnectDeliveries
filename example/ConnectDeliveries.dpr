program ConnectDeliveries;

uses
  System.StartUpCopy,
  FMX.Forms,
  uFormMain in 'uFormMain.pas' {FormMain},
  uiFood in '..\src\iFood\uiFood.pas',
  uiFood.Address in '..\src\iFood\ParseClasses\uiFood.Address.pas',
  uiFood.Authentication in '..\src\iFood\ParseClasses\uiFood.Authentication.pas',
  uiFood.Availability in '..\src\iFood\ParseClasses\uiFood.Availability.pas',
  uiFood.Benefits in '..\src\iFood\ParseClasses\uiFood.Benefits.pas',
  uiFood.Coordinates in '..\src\iFood\ParseClasses\uiFood.Coordinates.pas',
  uiFood.Credential in '..\src\iFood\ParseClasses\uiFood.Credential.pas',
  uiFood.Customer in '..\src\iFood\ParseClasses\uiFood.Customer.pas',
  uiFood.DeliveryAddress in '..\src\iFood\ParseClasses\uiFood.DeliveryAddress.pas',
  uiFood.DeliveryMethod in '..\src\iFood\ParseClasses\uiFood.DeliveryMethod.pas',
  uiFood.Item in '..\src\iFood\ParseClasses\uiFood.Item.pas',
  uiFood.Localizer in '..\src\iFood\ParseClasses\uiFood.Localizer.pas',
  uiFood.Merchant in '..\src\iFood\ParseClasses\uiFood.Merchant.pas',
  uiFood.MerchantDetail in '..\src\iFood\ParseClasses\uiFood.MerchantDetail.pas',
  uiFood.Message in '..\src\iFood\ParseClasses\uiFood.Message.pas',
  uiFood.MetaData in '..\src\iFood\ParseClasses\uiFood.MetaData.pas',
  uiFood.OrderDetail in '..\src\iFood\ParseClasses\uiFood.OrderDetail.pas',
  uiFood.Payment in '..\src\iFood\ParseClasses\uiFood.Payment.pas',
  uiFood.PickupAreaAssigned in '..\src\iFood\ParseClasses\uiFood.PickupAreaAssigned.pas',
  uiFood.Polling in '..\src\iFood\ParseClasses\uiFood.Polling.pas',
  uiFood.Reopenable in '..\src\iFood\ParseClasses\uiFood.Reopenable.pas',
  uiFood.ReplacementOptions in '..\src\iFood\ParseClasses\uiFood.ReplacementOptions.pas',
  uiFood.SponsorshipValues in '..\src\iFood\ParseClasses\uiFood.SponsorshipValues.pas',
  uiFood.SubItem in '..\src\iFood\ParseClasses\uiFood.SubItem.pas',
  uiFood.Unavailability in '..\src\iFood\ParseClasses\uiFood.Unavailability.pas',
  uiFood.Validation in '..\src\iFood\ParseClasses\uiFood.Validation.pas',
  uBaseDelivery in '..\src\common\uBaseDelivery.pas',
  uReturnMessage in '..\src\common\uReturnMessage.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
