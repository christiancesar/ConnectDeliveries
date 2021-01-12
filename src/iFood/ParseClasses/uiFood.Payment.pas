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
    Fvalue: Currency;

  protected

  public
    property name: String read Fname write Fname;
    property code: String read Fcode write Fcode;
    property value: Currency read Fvalue write Fvalue;
    property prepaid: Boolean read Fprepaid write Fprepaid;
  
  published

  end;

implementation

end.
