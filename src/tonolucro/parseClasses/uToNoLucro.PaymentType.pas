unit uToNoLucro.PaymentType;
    
interface
    
uses
    SysUtils, Classes;
Type 

  TPaymentType = class(TObject)
  private
    { private declarations }

  public
    { public declarations }
    property id: Integer read Fid write Fid;
    property paymentTypeParentId: Integer read FpaymentTypeParentId write FpaymentTypeParentId;
    property externalId: TExternalId read FexternalId write FexternalId;
    property environmentId: Integer read FenvironmentId write FenvironmentId;
    property title: String read Ftitle write Ftitle;
    property titleInternal: String read FtitleInternal write FtitleInternal;
    property slug: String read Fslug write Fslug;
    property priority: Integer read Fpriority write Fpriority;
    property active: Boolean read Factive write Factive;
    property &object: String read Fobject write Fobject;

    constructor Create;
    destructor Destroy; override;
  end;
    
implementation
    

    
end.