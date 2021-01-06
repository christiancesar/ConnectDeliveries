unit uToNoLucro.Payment;
    
interface
    
uses
    SysUtils, Classes, uToNoLucro.StatusPayment, uToNoLucro.PaymentType;
Type 

  TPayment = class(TObject)
  private
    { private declarations }
        
  public
    { public declarations }
    property prepaid: Boolean read Fprepaid write Fprepaid;
    property statusPayment: TStatusPayment read FstatusPayment write FstatusPayment;
    property paymentType: TPaymentType read FpaymentType write FpaymentType;
    property amountCart: Currency read FamountCart write FamountCart;
    property amountCartDiscount: Currency read FamountCartDiscount write FamountCartDiscount;
    property amountShipment: Currency read FamountShipment write FamountShipment;
    property amountShipmentDiscount: Currency read FamountShipmentDiscount write FamountShipmentDiscount;
    property amountDiscount: Currency read FamountDiscount write FamountDiscount;
    property amountTotal: Currency read FamountTotal write FamountTotal;
    property amountChange: Currency read FamountChange write FamountChange;
    property paymentAt: String read FpaymentAt write FpaymentAt;
    property &object: String read Fobject write Fobject;

    constructor Create;
    destructor Destroy; override;
  end;
    
implementation
    

    
end.