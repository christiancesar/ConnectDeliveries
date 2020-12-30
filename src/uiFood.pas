unit uiFood;

interface
uses
  uIfood.Authentication, uIfood.Credential, uClassBaseDelivery, REST.Types;

Type
  TiFood = class(TClassBaseDelivery)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    function Authentication(const Credential: TCredential): TAuthentication;
    constructor Create(ABaseUrl, AContentType: String);
    destructor Destroy; override;
    { public declarations }

  published

    { published declarations }

  end;

implementation

uses
  System.SysUtils, REST.Json, System.Json;

{ TiFood }

function TiFood.Authentication(const Credential: TCredential): TAuthentication;
begin
  Result := TAuthentication.Create;

  FResquest.Method := rmPOST;
  FResquest.Resource := '/oauth/token';
  FResquest.AddParameter('client_id', Credential.client_id);
  FResquest.AddParameter('client_secret', Credential.client_secret);
  FResquest.AddParameter('grant_type', Credential.grant_type);
  FResquest.AddParameter('username', Credential.username);
  FResquest.AddParameter('password', Credential.password);
  FResquest.Execute;

  if FResponse.Status.Success then
  begin
    Result := TJson.JsonToObject<TAuthentication>(FResponse.JSONValue as TJSONObject);
  end
  else
    raise Exception.Create(Format('Code: %s %s Message: %s', [FResponse.StatusCode.ToString, FResponse.StatusText, FResponse.JSONText]));

end;

constructor TiFood.Create(ABaseUrl, AContentType: String);
begin
    inherited Create(ABaseUrl, AContentType);
end;

destructor TiFood.Destroy;
begin

  inherited;
end;

end.
