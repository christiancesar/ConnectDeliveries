unit uToNoLucro.Vehicle;
    
interface
    
uses
    SysUtils, Classes;
Type 

  TVehicle = class(TObject)
  private
    { private declarations }

  public
    property id: String read Fid write Fid;
    property driver_id: String read Fdriver_id write Fdriver_id;
    property license_plate: String read Flicense_plate write Flicense_plate;
    property &type: String read Ftype write Ftype;
    property model: String read Fmodel write Fmodel;
    property &object: String read Fobject write Fobject;
    { private declarations }
  end;
    
implementation
    

    
end.