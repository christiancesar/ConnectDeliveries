unit uiFood.OrderDetail;
    
interface
    
uses
    SysUtils, Classes, uiFood.MerchantDetail, uiFood.Payment, uiFood.Customer, 
    uiFood.Item, uiFood.DeliveryAddress;

    Type
    TOrderDetail = class(TObject)
    private
        
        
    public
        property id: String read Fid write Fid;
        property reference: String read Freference write Freference;
        property shortReference: String read FshortReference write FshortReference;
        property createdAt: String read FcreatedAt write FcreatedAt;
        property &type: String read F&type write F&type;
        property merchant: TMerchantDetail read Fmerchant write Fmerchant;
        property payments: TObjectList<TPayment> read Fpayments write Fpayments;
        property customer: TCustomer read Fcustomer write Fcustomer;
        property items: TObjectList<TItem> read Fitems write Fitems;
        property subTotal: String read FsubTotal write FsubTotal;
        property totalPrice: String read FtotalPrice write FtotalPrice;
        property deliveryFee: String read FdeliveryFee write FdeliveryFee;
        property deliveryAddress: TDeliveryAddress read FdeliveryAddress write FdeliveryAddress;
        property deliveryDateTime: String read FdeliveryDateTime write FdeliveryDateTime;
        property preparationTimeInSeconds: String read FpreparationTimeInSeconds write FpreparationTimeInSeconds;

        constructor Create; override;
        destructor Destroy; override;
    published
        
    end;

implementation
    

    
end.