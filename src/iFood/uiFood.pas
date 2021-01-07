unit uiFood;

interface

uses
  uiFood.Authentication, uiFood.Credential, uClassBaseDelivery, REST.Types,
  uiFood.Merchant, System.Generics.Collections, uiFood.Unavailability,
  uiFood.Availability, uiFood.Polling, System.Classes;

Type
  TiFood = class(TClassBaseDelivery)
  private
    { private declarations }
  protected
    { protected declarations }
  public
    { Authentication }
    function Authentication(const Credential: TCredential): TAuthentication;

    { Merchant v1 }
    function Merchants: TObjectList<TMerchant>;

    function Unavailabilities(AMerchantUUID: String)
      : TObjectList<TUnavailability>; Overload;
    function Unavailabilities(AMerchantUUID, AUnavailabilityId: String)
      : Boolean; Overload;
    function Unavailabilities(AMerchantUUID, ADescription: String;
      AMinutes: Integer): TUnavailability; Overload;

    { Merchant v2 }
    function MerchantAvailability(AMerchantUUID: String)
      : TObjectList<TAvailability>;

    { Orders }

    function Polling: TObjectList<TPolling>;
    function Acknowledgment(AIdProcess: TStrings): Boolean;

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

function TiFood.Acknowledgment(AIdProcess: TStrings): Boolean;
var
  joAcknowledgment: TJSONObject;
  jaAcknowledgment: TJSONArray;
  Id: String;
begin
  Result := False;

  joAcknowledgment := TJSONObject.Create;
  jaAcknowledgment := TJSONArray.Create;
  try
    { Cria Objeto Json }
    for Id in AIdProcess do
    begin
      joAcknowledgment.AddPair('id', TJSONString(Id));
      jaAcknowledgment.AddElement(joAcknowledgment as TJSONValue);
      joAcknowledgment.Free;
    end;

    FRequest.Method := rmPOST;
    FRequest.Resource := '/v1.0/events/acknowledgment';
    FRequest.Params.AddBody(jaAcknowledgment);
    FRequest.Params.Clear;

  if FResponse.Status.Success then
  begin

    Result := True;

  end
  else
    raise Exception.Create(Format('Code: %s %s Message: %s',
      [FResponse.StatusCode.ToString, FResponse.StatusText,
      FResponse.JSONText]));

  finally
    FreeAndNil(joAcknowledgment);
    FreeAndNil(jaAcknowledgment);
  end;

end;

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
    Result := TJson.JsonToObject<TAuthentication>
      (FResponse.JSONValue as TJSONObject);
  end
  else
    raise Exception.Create(Format('Code: %s %s Message: %s',
      [FResponse.StatusCode.ToString, FResponse.StatusText,
      FResponse.JSONText]));

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

function TiFood.MerchantAvailability(AMerchantUUID: String)
  : TObjectList<TAvailability>;
var
  I: Integer;
begin
  Result := TObjectList<TAvailability>.Create;
  FRequest.Method := rmGET;
  FRequest.Resource := Format('/v2.0/merchants/%s/availabilities',
    [AMerchantUUID]);
  FRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
  FRequest.Execute;
  FRequest.Params.Clear;

  if FResponse.Status.Success then
  begin

    for I := 0 to (FResponse.JSONValue as TJSONArray).Count - 1 do
    begin
      Result.Add(TJson.JsonToObject<TAvailability>
        (((FResponse.JSONValue as TJSONArray).Items[I] as TJSONObject)));
    end;

  end
  else
    raise Exception.Create(Format('Code: %s %s Message: %s',
      [FResponse.StatusCode.ToString, FResponse.StatusText,
      FResponse.JSONText]));
end;

function TiFood.Merchants: TObjectList<TMerchant>;
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
      Result.Add(TJson.JsonToObject<TMerchant>
        (((FResponse.JSONValue as TJSONArray).Items[I] as TJSONObject)));
    end;

  end
  else
    raise Exception.Create(Format('Code: %s %s Message: %s',
      [FResponse.StatusCode.ToString, FResponse.StatusText,
      FResponse.JSONText]));
end;

function TiFood.Polling: TObjectList<TPolling>;
var
  I: Integer;
begin
  Result := TObjectList<TPolling>.Create;
  FRequest.Method := rmGET;
  FRequest.Resource := '/v3.0/events:polling';
  FRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
  FRequest.Execute;
  FRequest.Params.Clear;

  if FResponse.Status.Success then
  begin

    for I := 0 to (FResponse.JSONValue as TJSONArray).Count - 1 do
    begin
      Result.Add(TJson.JsonToObject<TPolling>
        (((FResponse.JSONValue as TJSONArray).Items[I] as TJSONObject)));
    end;

  end
  else
    raise Exception.Create(Format('Code: %s %s Message: %s',
      [FResponse.StatusCode.ToString, FResponse.StatusText,
      FResponse.JSONText]));

end;

function TiFood.Unavailabilities(AMerchantUUID, ADescription: String;
  AMinutes: Integer): TUnavailability;
var
  joUnavailability: TJSONObject;
begin
  { Cria Objeto Json }
  joUnavailability := TJSONObject.Create;
  try
    joUnavailability.AddPair('description', TJSONString(ADescription));
    joUnavailability.AddPair('minutes', TJSONNumber.Create(AMinutes));

    Result := TUnavailability.Create;
    FRequest.Method := rmPOST;
    FRequest.Resource := Format('/v1.0/merchants/%s/unavailabilities:now',
      [AMerchantUUID]);

    FRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
    FRequest.Params.AddBody(joUnavailability);
    FRequest.Execute;
    FRequest.Params.Clear;

    if FResponse.Status.Success then
    begin
      Result := TJson.JsonToObject<TUnavailability>
        (FResponse.JSONValue as TJSONObject);
    end
    else
      raise Exception.Create(Format('Code: %s %s Message: %s',
        [FResponse.StatusCode.ToString, FResponse.StatusText,
        FResponse.JSONText]));

  finally
    FreeAndNil(joUnavailability);
  end;

end;

function TiFood.Unavailabilities(AMerchantUUID, AUnavailabilityId
  : String): Boolean;
var
  I: Integer;
begin
  Result := False;

  FRequest.Method := rmDELETE;
  FRequest.Resource := Format('/v1.0/merchants/%s/unavailabilities/%s',
    [AMerchantUUID, AUnavailabilityId]);

  FRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
  FRequest.Execute;
  FRequest.Params.Clear;

  if FResponse.Status.Success then
  begin
    Result := True;
  end
  else
    raise Exception.Create(Format('Code: %s %s Message: %s',
      [FResponse.StatusCode.ToString, FResponse.StatusText,
      FResponse.JSONText]));
end;

function TiFood.Unavailabilities(AMerchantUUID: String)
  : TObjectList<TUnavailability>;
var
  I: Integer;
begin
  Result := TObjectList<TUnavailability>.Create;
  FRequest.Method := rmGET;
  FRequest.Resource := Format('/v1.0/merchants/%s/unavailabilities',
    [AMerchantUUID]);

  FRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
  FRequest.Execute;
  FRequest.Params.Clear;

  if FResponse.Status.Success then
  begin

    for I := 0 to (FResponse.JSONValue as TJSONArray).Count - 1 do
    begin
      Result.Add(TJson.JsonToObject<TUnavailability>
        (((FResponse.JSONValue as TJSONArray).Items[I] as TJSONObject)));
    end;

  end
  else
    raise Exception.Create(Format('Code: %s %s Message: %s',
      [FResponse.StatusCode.ToString, FResponse.StatusText,
      FResponse.JSONText]));

end;

end.
