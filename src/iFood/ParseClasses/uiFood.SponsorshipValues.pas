unit uiFood.SponsorshipValues;

interface

uses
  SysUtils, Classes;

Type
  TSponsorshipValues = class(TObject)
  private
    Fifood: Currency;
    Fmerchant: Currency;

  protected

  public
    property IFOOD: Currency read Fifood write Fifood;
    property MERCHANT: Currency read Fmerchant write Fmerchant;

  published

  end;

implementation

end.
