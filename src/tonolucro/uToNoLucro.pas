unit uToNoLucro;

interface
uses

Type
  TToNoLucro = class(TClassBaseDelivery)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    {Authentication}
    function Authentication(const Credential: TCredential): TAuthentication;

    {Merchants}
    function Merchant: TObjectList<TMerchant>;

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

  if Assigned(Credential) then
    raise Exception.Create('Credencial fazia!');

  Result := TAuthentication.Create;

  FRequest.Method := rmPOST;
  FRequest.Resource := '/oauth/token';
  FRequest.AddParameter('client_id', Credential.client_id);
  FRequest.AddParameter('client_secret', Credential.client_secret);
  FRequest.AddParameter('grant_type', Credential.grant_type);
  FRequest.AddParameter('username', Credential.username);
  FRequest.AddParameter('password', Credential.password);
  FRequest.Execute;

  if FResponse.Status.Success then
  begin
    Result := TJson.JsonToObject<TAuthentication>(FResponse.JSONValue as TJSONObject);
  end
  else
    raise Exception.Create(Format('Code: %s %s Message: %s', [FResponse.StatusCode.ToString, FResponse.StatusText, FResponse.JSONText]));

end;

constructor TiFood.Create(ABaseUrl, AContentType: String);
begin
    inherited Create(ABaseUrl);
    FClient.Accept := 'application/json';
    FClient.AcceptCharset := 'utf-8';
    FClient.ContentType := AContentType;
end;

destructor TiFood.Destroy;
begin

  inherited;
end;

function TiFood.Merchant: TObjectList<TMerchant>;
var
  I: Integer;
begin
  Result := TObjectList<TMerchant>.Create;
  FRequest.Method := rmGET;
  FRequest.Resource := '/v1.0/merchants';
  FRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
  FRequest.Execute;
  FRequest.Params.Clear;

  if FResponse.Status.Success then
  begin

    for I := 0 to (FResponse.JSONValue as TJSONArray).Count - 1 do
    begin
      Result.Add(TJson.JsonToObject<TMerchant>(((FResponse.JSONValue as TJSONArray).Items[I] as TJSONObject)));
    end;

  end
  else
    raise Exception.Create(Format('Code: %s %s Message: %s', [FResponse.StatusCode.ToString, FResponse.StatusText, FResponse.JSONText]));
end;

end.
