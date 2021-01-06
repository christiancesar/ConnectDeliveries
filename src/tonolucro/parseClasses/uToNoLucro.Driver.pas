unit uToNoLucro.Driver;
    
interface
    
uses
    SysUtils, Classes, uToNoLucro.Document, uToNoLucro.Vehicle;
Type 

  TDriver = class(TObject)
  private
    { private declarations }

  public
    { private declarations }
    property id: String read Fid write Fid;
    property name: String read Fname write Fname;
    property phoneMobile: String read FphoneMobile write FphoneMobile;
    property document: TDocument read Fdocument write Fdocument;
    property vehicle: TVehicle read Fvehicle write Fvehicle;
    property &object: String read Fobject write Fobject;

    constructor Create;
    destructor Destroy; override;
  end;
    
implementation
    

    
end.