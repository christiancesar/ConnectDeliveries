unit uToNoLucro.Coupon;
    
interface
    
uses
    SysUtils, Classes;
Type 

  TCoupon = class(TObject)
  private
    { private declarations }

  public
    { public declarations }
    property id: String read Fid write Fid;
    property title: String read Ftitle write Ftitle;
    property code: String read Fcode write Fcode;
    property &object: String read Fobject write Fobject;

    constructor Create;
    destructor Destroy; override;
  end;
    
implementation
    

    
end.