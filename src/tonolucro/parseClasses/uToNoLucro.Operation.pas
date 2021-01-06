unit uToNoLucro.Operation;
    
interface
    
uses
    SysUtils, Classes;
Type 

  TOperation = class(TObject)
  private
    { private declarations }

  public
    { public declarations }
    property open: Boolean read Fopen write Fopen;
    property periods: TStrings read Fperiods write Fperiods;
    property &object: String read Fobject write Fobject;

    constructor Create;
    destructor Destroy; override;
  end;
    
implementation
    

    
end.