unit uToNoLucro.Address;
    
interface
    
uses
    SysUtils, Classes;
Type
    TAddress = class(TObject)
  private
    { private declarations }
        
  public
    property street: String read Fstreet write Fstreet;
    property number: Integer read Fnumber write Fnumber;
    property complement: String read Fcomplement write Fcomplement;
    property district: String read Fdistrict write Fdistrict;
    property zip: Integer read Fzip write Fzip;
    property state: String read Fstate write Fstate;
    property city: String read Fcity write Fcity;
    property reference: String read Freference write Freference;
    property latitude: Integer read Flatitude write Flatitude;
    property longitude: Integer read Flongitude write Flongitude;
    property &object: String read Fobject write Fobject;
    { public declarations }
  end;
    
implementation
    

    
end.