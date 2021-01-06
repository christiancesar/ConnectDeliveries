unit uToNoLucro.Customer;
    
interface
    
uses
    SysUtils, Classes, uToNoLucro.Document, uToNoLucro.ExternalId;
Type 

  TCustomer = class(TObject)
  private
    { private declarations }
        
  public
    { public declarations }
    property id: Integer read Fid write Fid;
    property uid: String read Fuid write Fuid;
    property externalId: TExternalId read FexternalId write FexternalId;
    property name: String read Fname write Fname;
    property document: TDocument read Fdocument write Fdocument;
    property phone: String read Fphone write Fphone;
    property phoneMobile: String read FphoneMobile write FphoneMobile;
    property email: String read Femail write Femail;
    property createdAt: String read FcreatedAt write FcreatedAt;
    property &object: String read Fobject write Fobject;

    constructor Create;
    destructor Destroy; override;
  end;

    
implementation
    

    
end.