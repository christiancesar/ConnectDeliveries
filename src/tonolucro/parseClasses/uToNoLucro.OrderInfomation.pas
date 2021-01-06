unit uToNoLucro.Orders.Info;
    
interface
    
uses
  SysUtils, Classes, System.Generics.Collections, uToNoLucro.ClassAddress, uToNoLucro.Status,
  uToNoLucro.Customer, uToNoLucro.Coupon, uToNoLucro.Payment, uToNoLucro.Cart, uToNoLucro.Shipment;

Type

  TOrderInfomation = class(TObject)
  private
    { private declarations }
        
  public
    { public declarations }

    property id: Integer read Fid write Fid;
    property uid: String read Fuid write Fuid;
    property externalId: String read FexternalId write FexternalId;
    property amount: Currency read Famount write Famount;
    property amountDiscount: Currency read FamountDiscount write FamountDiscount;
    property amountTotal: Currency read FamountTotal write FamountTotal;
    property status: TStatus read Fstatus write Fstatus;
    property notes: String read Fnotes write Fnotes;
    property createdAt: String read FcreatedAt write FcreatedAt;
    property customer: TCustomer read Fcustomer write Fcustomer;
    property coupon: TCoupon read Fcoupon write Fcoupon;
    property payment: TPayment read Fpayment write Fpayment;
    property cart: TCart read Fcart write Fcart;
    property shipment: TShipment read Fshipment write Fshipment;

    property &object: String read Fobject write Fobject;
  end;

implementation



end.