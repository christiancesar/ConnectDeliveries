unit uToNoLucro.Carrier;
    
interface
    
uses
    SysUtils, Classes, uToNoLucro.Document, uToNoLucro.Address;
Type 

  TCarrier = class(TObject)
  private
    { private declarations }
        
  public
    { private declarations }
    property id: String read Fid write Fid;
    property title: String read Ftitle write Ftitle;
    property description: String read Fdescription write Fdescription;
    property image: String read Fimage write Fimage;
    property document: TDocument read Fdocument write Fdocument;
    property sponsor: String read Fsponsor write Fsponsor;
    property phone: String read Fphone write Fphone;
    property email: String read Femail write Femail;
    property address: TAddress read Faddress write Faddress;
    property createdAt: String read FcreatedAt write FcreatedAt;
    property updatedAt: String read FupdatedAt write FupdatedAt;
    property &object: String read Fobject write Fobject;

    constructor Create;
    destructor Destroy; override;
  end;
    
implementation
    

    
end.