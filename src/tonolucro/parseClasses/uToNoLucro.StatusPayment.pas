unit uToNoLucro.StatusPayment;
    
interface
    
uses
    SysUtils, Classes;
Type 

  TStatusPayment = class(TObject)
  private
    { private declarations }
        
  public
    { public declarations }
    property id: String read Fid write Fid;
    property title: String read Ftitle write Ftitle;
    property alert: String read Falert write Falert;
    property &object: String read Fobject write Fobject;

  end;
    
implementation
    

    
end.