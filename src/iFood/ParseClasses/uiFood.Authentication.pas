unit uiFood.Authentication;

interface

Type
  TAuthentication = class(TObject)
  private
    Fscope: String;
    Fexpires_in: Integer;
    Ftoken_type: String;
    Faccess_token: String;

  protected

  public
    property access_token: String read Faccess_token write Faccess_token;
    property token_type: String read Ftoken_type write Ftoken_type;
    property expires_in: Integer read Fexpires_in write Fexpires_in;
    property scope: String read Fscope write Fscope;

  published
  end;

implementation

end.
