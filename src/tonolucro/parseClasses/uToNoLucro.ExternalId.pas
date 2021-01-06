unit uToNoLucro.ExternalId;
    
interface
    
uses
    SysUtils, Classes;
Type
  TExternalID = class(TObject)
  private
        
  public
    property id: String read Fid write Fid;
    property uid: String read Fuid write Fuid;
    property content: String read Fcontent write Fcontent;
    property createdAt: String read FcreatedAt write FcreatedAt;
    property updatedAt: String read FupdatedAt write FupdatedAt;
        
    property &object: String read Fobject write Fobject;
        
  end;
    
implementation
    

    
end.