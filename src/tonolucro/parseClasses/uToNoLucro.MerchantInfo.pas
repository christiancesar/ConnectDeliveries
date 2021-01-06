unit uToNoLucro.
MerchantInfo;
        
interface
    
uses
    SysUtils, Classes, uToNoLucro.ClassAddress, uToNoLucro.ClassDocument, uToNoLucro.ClassExternalId,
    uToNoLucro.ClassDeliveryService, uToNoLucro.ClassExternalId, uToNoLucro.ClassFoodService,
    uToNoLucro.ClassBaseInformation;
    
Type
  
  TMerchantInfo = class(TBaseInformation)
  private
        
  public
    property uid: String read Fuid write Fuid;
    property externalId: String read FexternalId write FexternalId;
    property url: String read Furl write Furl;
    property rating: String read Frating write Frating;
    property foodService: TFoodService read FfoodService write FfoodService;
    property deliveryService: TDeliveryService read FdeliveryService write FdeliveryService;
    property supportService: TBaseInformation read FsupportService write FsupportService;
    property &object: String read Fobject write Fobject;

    constructor Create; override;
    destructor Destroy; override;
        
  end;


implementation
    

    
end.