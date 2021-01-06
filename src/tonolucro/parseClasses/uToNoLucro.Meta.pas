unit uToNoLucro.Meta;
    
interface
    
uses
    SysUtils, Classes, uToNoLucro.Status;
Type 

  TMeta = class(TObject)
  private
    { private declarations }
        
  public
    { public declarations }
    property page: TPage read Fpage write Fpage;

    constructor Create;
    destructor Destroy; override;
    
  end;
    
implementation
    

    
end.