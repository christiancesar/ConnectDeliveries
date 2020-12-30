unit uiFood;

interface
uses
  uIfood.Authentication, uIfood.Credential, REST.Client, REST.Types;

Type
  TiFood = class
  private
    { private declarations }
  protected
    FClient: TRESTClient;
    FResquest: TRESTRequest;
    FResponse: TRestResponse;
    { protected declarations }
  public
    class function Authentication(const Credential: TCredential): TAuthentication;
    constructor Create(const BaseUrl: String); reintroduce;
    destructor Destroy; override;
    { public declarations }

  published

    { published declarations }

  end;

implementation

{ TiFood }

class function TiFood.Authentication(
  const Credential: TCredential): TAuthentication;
begin
  FResquest.Method := rmPOST;
  FResquest.Resource := '/oauth/token';
  FResquest.AddParameter('client_id', Credential.client_id);
  FResquest.AddParameter('client_secret', Credential.client_secret);
  FResquest.AddParameter('grant_type', Credential.grant_type);
  FResquest.AddParameter('username', Credential.username);
  FResquest.AddParameter('password', Credential.password);
  FResquest.Execute;
  FRe

end;

constructor TiFood.Create(const BaseUrl: String);
begin
  FClient := TRESTClient.Create(BaseUrl);
  FResquest := TRESTRequest.Create(nil);
  FResponse := TRestResponse.Create(nil);

  FResquest.Client := FClient;
  FResquest.Response := FResponse;
end;

destructor TiFood.Destroy;
begin

  inherited;
end;

end.
