unit uiFood.Credential;

interface
Type
  TCredential = class(TObject)
  private
    Fclient_id: String;
    Fclient_secret: String;
    Fpassword: String;
    Fgrant_type: String;
    Fusername: String;
    FbaseURL: String;

  protected

  public
    property baseURL: String read FbaseURL write FbaseURL;
    property client_id: String read Fclient_id write Fclient_id;
    property client_secret: String read Fclient_secret write Fclient_secret;
    property grant_type: String read Fgrant_type write Fgrant_type;
    property username: String read Fusername write Fusername;
    property password: String read Fpassword write Fpassword;
  published

  end;

implementation

end.
