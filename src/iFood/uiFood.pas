unit uiFood;

interface

uses
  uiFood.Authentication, uiFood.Credential, uBaseDelivery, REST.Types,
  uiFood.Merchant, System.Generics.Collections, uiFood.Unavailability,
  uiFood.Availability, uiFood.Polling, System.Classes, System.SysUtils,
  REST.Json, System.Json;

Type
  TiFood = class(TBaseDelivery)
  private
    { private declarations }
  protected
    function ReturnMessage: TJSONValue;
    { protected declarations }
  public
    { Authentication }

    /// <summary>
    /// Emite um token de acesso para comunicação de todos os endpoints, necessário em todas as chamadas da API.
    /// </summary>
    function Authentication(const Credential: TCredential;
      out OAuthentication: TAuthentication): TJSONValue;

    { Merchant v1 }

    /// <summary>
    /// Lista os merchants que o usuário tem permissão incluindo o merchant_uuid
    /// </summary>
    function Merchants(out AMerchant: TObjectList<TMerchant>): TJSONValue;

    /// <summary>
    /// Lista todas as indisponibilidades cadastradas para um merchant.
    /// Consulte as indisponibilidades e obtenha o id da indisponibilidade
    /// para removê-la
    /// </summary>
    function Unavailabilities(AMerchantUUID: String;
      out AUnavailabilities: TObjectList<TUnavailability>): TJSONValue;
      Overload;

    /// <summary>
    /// Remove indisponibilidades cadastradas
    /// </summary>
    function Unavailabilities(AMerchantUUID, AUnavailabilityId: String;
      out ADelete: Boolean): TJSONValue; Overload;

    /// <summary>
    /// Cadastra uma indisponibilidade para o merchant.
    /// </summary>
    function Unavailabilities(AMerchantUUID, ADescription: String;
      AMinutes: Integer; AUnavailability: TUnavailability): TJSONValue;
      Overload;

    { Merchant v2 }
    /// <summary>
    /// Retorna o status do merchant na plataforma
    /// </summary>
    function MerchantAvailability(AMerchantUUID: String;
      out AAvailabilities: TObjectList<TAvailability>): TJSONValue;

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
  uReturnMessage;

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

function TiFood.Authentication(const Credential: TCredential;
  out OAuthentication: TAuthentication): TJSONValue;
var
  bSuccess: Boolean;
begin

  if not Assigned(Credential) then
    raise Exception.Create('Credencial fazia!');

  FRequest.Method := rmPOST;
  FRequest.Resource := '/oauth/token';
  FRequest.AddParameter('client_id', Credential.client_id);
  FRequest.AddParameter('client_secret', Credential.client_secret);
  FRequest.AddParameter('grant_type', Credential.grant_type);
  FRequest.AddParameter('username', Credential.username);
  FRequest.AddParameter('password', Credential.password);
  FRequest.Execute;

  OAuthentication.CleanupInstance;

  if FResponse.Status.Success then
  begin
    OAuthentication := TJson.JsonToObject<TAuthentication>
      (FResponse.JSONValue as TJSONObject);
  end;

  Result := ReturnMessage;

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

function TiFood.MerchantAvailability(AMerchantUUID: String;
  out AAvailabilities: TObjectList<TAvailability>): TJSONValue;
var
  I: Integer;
  jaAvailabilities: TJSONArray;
  joAvailability: TJSONObject;
begin
  try
    FRequest.Method := rmGET;
    FRequest.Resource := Format('/merchant/v2.0/merchants/%s/availabilities',
      [AMerchantUUID]);
    FRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
    FRequest.Execute;
    FRequest.Params.Clear;

    if FResponse.Status.Success then
    begin
      jaAvailabilities := TJSONArray.Create;
      jaAvailabilities := (FResponse.JSONValue as TJSONArray);

      for I := 0 to jaAvailabilities.Count - 1 do
      begin
        joAvailability.CleanupInstance;
        joAvailability := (jaAvailabilities.Items[I] as TJSONObject);
        AAvailabilities.Add(TJson.JsonToObject<TAvailability>(joAvailability));
      end;

    end;

    Result := ReturnMessage;
  finally
    FreeAndNil(jaAvailabilities);
    FreeAndNil(joAvailability);
  end;
end;

function TiFood.Merchants(out AMerchant: TObjectList<TMerchant>): TJSONValue;
var
  I: Integer;
begin
  FRequest.Method := rmGET;
  FRequest.Resource := '/v1.0/merchants';
  FRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
  FRequest.Execute;
  FRequest.Params.Clear;

  if FResponse.Status.Success then
  begin

    for I := 0 to (FResponse.JSONValue as TJSONArray).Count - 1 do
    begin
      AMerchant.Add(TJson.JsonToObject<TMerchant>
        (((FResponse.JSONValue as TJSONArray).Items[I] as TJSONObject)));
    end;

  end;

  Result := ReturnMessage;

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

function TiFood.ReturnMessage: TJSONValue;
begin
  Result := TReturnMessage.Create(FResponse.Status.Success, FResponse.JSONText,
    FResponse.StatusCode, FResponse.StatusText).AsJson;
end;

function TiFood.Unavailabilities(AMerchantUUID, ADescription: String;
  AMinutes: Integer; AUnavailability: TUnavailability): TJSONValue;
var
  joUnavailability: TJSONObject;
  jvUnavailability: TJSONValue;
begin
  { Cria Objeto Json }
  joUnavailability := TJSONObject.Create;
  jvUnavailability := TJSONValue.Create;

  try
    joUnavailability.AddPair('description', TJSONString(ADescription));
    joUnavailability.AddPair('minutes', TJSONNumber.Create(AMinutes));

    jvUnavailability := (joUnavailability as TJSONValue);
    FRequest.Method := rmPOST;
    FRequest.Resource := Format('/v1.0/merchants/%s/unavailabilities:now',
      [AMerchantUUID]);

    FRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
    FRequest.Params.AddBody(joUnavailability.ToJSON, ctAPPLICATION_JSON);
    FRequest.Execute;
    FRequest.Params.Clear;

    if FResponse.Status.Success then
    begin
      AUnavailability := TJson.JsonToObject<TUnavailability>
        (FResponse.JSONValue as TJSONObject);
    end;

    Result := ReturnMessage;

  finally
    FreeAndNil(joUnavailability);
    FreeAndNil(jvUnavailability);
  end;

end;

function TiFood.Unavailabilities(AMerchantUUID, AUnavailabilityId: String;
  out ADelete: Boolean): TJSONValue;
var
  I: Integer;
begin

  FRequest.Method := rmDELETE;
  FRequest.Resource := Format('/v1.0/merchants/%s/unavailabilities/%s',
    [AMerchantUUID, AUnavailabilityId]);

  FRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
  FRequest.Execute;
  FRequest.Params.Clear;

  ADelete := FResponse.Status.Success;

  Result := ReturnMessage;
end;

function TiFood.Unavailabilities(AMerchantUUID: String;
  out AUnavailabilities: TObjectList<TUnavailability>): TJSONValue;
var
  I: Integer;
begin
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
      AUnavailabilities.Add(TJson.JsonToObject<TUnavailability>
        (((FResponse.JSONValue as TJSONArray).Items[I] as TJSONObject)));
    end;

  end;

  Result := ReturnMessage;
end;

end.
