unit uToNoLucro.Document;
    
interface
    
uses
    SysUtils, Classes;
Type
  TDocument = class(TObject)
  private
    { private declarations }
        
  public
    property number: String read Fnumber write Fnumber;
    property &type: String read Ftype write Ftype;
    property &object: String read Fobject write Fobject;
    { public declarations }
  end;
    
implementation
    

    
end.