unit uiFood.Payment;

interface

uses
  SysUtils, Classes;

Type
  TPayment = class(TObject)
  private
    Fname: String;
    Fcode: String;
    Fprepaid: Boolean;
    Fissuer: String;
    Fvalue: Currency;

  protected

  public
    property name: String read Fname write Fname;
    property code: String read Fcode write Fcode;
    property value: Currency read Fvalue write Fvalue;
    property prepaid: Boolean read Fprepaid write Fprepaid;
    property issuer: String read Fissuer write Fissuer;
  published

  end;

implementation

end.
