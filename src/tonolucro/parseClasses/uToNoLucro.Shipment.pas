unit uToNoLucro.Shipment;
    
interface
    
uses
    SysUtils, Classes, uToNoLucro.Address, uToNoLucro.Driver, uToNoLucro.Carrier, uToNoLucro.Status,
    uToNoLucro.Type;
Type 

  TShipment = class(TObject)
  private
    { private declarations }
        
  public
    { private declarations }
    property amountShipment: Currency read FamountShipment write FamountShipment;
    property amountShipmentDiscount: Currency read FamountShipmentDiscount write FamountShipmentDiscount;
    property amountShipmentTotal: Currency read FamountShipmentTotal write FamountShipmentTotal;
    property deliveryAt: String read FdeliveryAt write FdeliveryAt;
    property nfse: String read Fnfse write Fnfse;
    property addressDelivery: TAddress read FaddressDelivery write FaddressDelivery;
    property addressPickup: TAddress read FaddressPickup write FaddressPickup;
    property transportType: TType read FtransportType write FtransportType;
    property packageType: TType read FpackageType write FpackageType;
    property slo: TType read Fslo write Fslo;
    property driver: TDriver read Fdriver write Fdriver;
    property carrier: TCarrier read Fcarrier write Fcarrier;

    property &object: String read Fobject write Fobject;

    constructor Create;
    destructor Destroy; override;
  end;
    
implementation
    

    
end.