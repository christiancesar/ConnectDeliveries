unit uToNoLucro.
MerchantInfo;
        
interface
    
uses
    SysUtils, Classes, uToNoLucro.ClassAddress, uToNoLucro.ExternalId;
    
Type
  
  TMerchantInfo = class(TObject)
  private
        
  public
    property merchantId: String read FmerchantId write FmerchantId;
    property externalId: TExternalId read FexternalId write FexternalId;
    property title: String read Ftitle write Ftitle;
    property description: String read Fdescription write Fdescription;
    property image: String read Fimage write Fimage;
    property document: String read Fdocument write Fdocument;
    property sponsor: String read Fsponsor write Fsponsor;
    property phone: String read Fphone write Fphone;
    property email: String read Femail write Femail;
    property address: TAddress read Faddress write Faddress;
    property &object: String read Fobject write Fobject;

    constructor Create; override;
    destructor Destroy; override;
        
  end;


implementation
    

    
end.