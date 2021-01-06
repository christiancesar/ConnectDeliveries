unit uToNoLucro.Status;
    
interface
    
uses
    SysUtils, Classes;
Type 

  TStatus = class(TObject)
  private
    { private declarations }

  public
    { public declarations }
    property id: String read Fid write Fid;
    property title: String read Ftitle write Ftitle;
    property &object: String read Fobject write Fobject;
  end;
    
implementation
    

    
end.