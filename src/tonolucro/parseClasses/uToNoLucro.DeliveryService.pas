unit uToNoLucro.DeliveryService;
    
interface
    
uses
    SysUtils, Classes, uToNoLucro.Address, uToNoLucro.BaseInformation;
Type
  TDeliveryService = class(TObject)
  private
    { private declarations }
        
  public
    property active: Boolean read Factive write Factive;
    property outsourced: Boolean read Foutsourced write Foutsourced;
    property addressPickup: TAddress read FaddressPickup write FaddressPickup;
    property carrier: TBaseInformation read Fcarrier write Fcarrier;
    property &object: String read Fobject write Fobject;

    constructor Create;
    destructor Destroy; override;
    { public declarations }
  end;
    
implementation
    

    
end.