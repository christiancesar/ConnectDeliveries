unit uToNoLucro.Page;
    
interface
    
uses
    SysUtils, Classes, uToNoLucro.Status;
Type 

  TPage = class(TObject)
  private
    { private declarations }

  public
    { public declarations }
    property total: Integer read Ftotal write Ftotal;
    property currentPage: Integer read FcurrentPage write FcurrentPage;
    property lastPage: Integer read FlastPage write FlastPage;
    property perPage: Integer read FperPage write FperPage;
        
    constructor Create;
    destructor Destroy; override;
    
  end;
    
implementation
    

    
end.