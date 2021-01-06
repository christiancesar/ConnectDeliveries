unit uToNoLucro.CommonObject;
    
interface
    
uses
    SysUtils, Classes;
Type

  TCommonObject = class(TObject)
  private
    { private declarations }
        
  public
    property id: String read Fid write Fid;
    property name: String read Fname write Fname;
    property value: String read Fvalue write Fvalue;
    property &object: String read Fobject write Fobject;
        
    { public declarations }
  end;

    
implementation
    

    
end.