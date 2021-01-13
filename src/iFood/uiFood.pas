unit uiFood;

interface

uses
  REST.Json, System.Json, REST.Types, System.Generics.Collections,
  uiFood.Authentication, uiFood.Credential, uBaseDelivery, uiFood.Merchant,
  uiFood.Unavailability, uiFood.Availability, uiFood.Polling, System.Classes,
  System.SysUtils, uiFood.OrderDetail;

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
    /// <summary>
    /// Receber novos pedidos: Obtém todos os eventos ainda não recebidos
    /// </summary>
    function Polling(out APolling: TObjectList<TPolling>): TJSONValue;

    /// <summary>
    /// Após o PDV/POS receber os eventos de pedido via polling, é necessário
    /// que se faça o acknowledgement para o iFood saber que os eventos foram
    /// recebidos e o e-PDV não precisa mais receber esses eventos nas próximas
    /// requests de polling. A request de acknowledgment aceita uma lista de no
    /// máximo 2000 ids de eventos. Faça uma request de acknowledgment para cada
    /// request de polling com resultados.
    /// </summary>
    function Acknowledgment(AIdProcess: TStrings): Boolean;

    /// <summary>
    /// Obtém os detalhes do pedido
    /// </summary>
    function OrderDetail(ACorrelationId: String; out AOrderDetail: TOrderDetail)
      : TJSONValue;

    function StatusOrder(ACorrelationId, AStatus: String; AAccepted: Boolean)
      : TJSONValue;

    constructor Create(ABaseUrl: String);
    destructor Destroy; override;
    { public declarations }

  published

    { published declarations }

  end;

const
  Integration = 'integration';
  Conformation = 'confirmation';
  Dispatchh = 'dispatch';
  ReadyToDeliver = 'readyToDeliver';
  CancellationRequested = 'cancellationRequested';
  CancellationAccepted = 'consumerCancellationAccepted';
  CancellationDenied = 'consumerCancellationDenied';

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

constructor TiFood.Create(ABaseUrl: String);
begin
  inherited Create(ABaseUrl);
  FRequest.Accept := CONTENTTYPE_APPLICATION_JSON;
end;

destructor TiFood.Destroy;
begin

  inherited;
end;

function TiFood.StatusOrder(ACorrelationId, AStatus: String; AAccepted: Boolean)
  : TJSONValue;
var
  sVersion: String;
begin

  if AStatus.Equals(Integration) or AStatus.Equals(Conformation) or AStatus.Equals(Dispatchh) then
    sVersion := 'v1.0'
  else if AStatus.Equals(ReadyToDeliver) or AStatus.Equals(CancellationAccepted) or
    AStatus.Equals(CancellationDenied) then
    sVersion := 'v2.0'
  else
    sVersion := 'v3.0';

  FRequest.Method := rmPOST;
  FRequest.Resource := Format('/%s/orders/%s/statuses/%s',
    [sVersion, ACorrelationId, AStatus]);
  FRequest.Execute;
  FRequest.Params.Clear;

  AAccepted := FResponse.Status.Success;

  Result := ReturnMessage;

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
  end;
end;

function TiFood.Merchants(out AMerchant: TObjectList<TMerchant>): TJSONValue;
var
  I: Integer;
begin
  FRequest.Method := rmGET;
  FRequest.Resource := '/v1.0/merchants';

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

function TiFood.OrderDetail(ACorrelationId: String;
  out AOrderDetail: TOrderDetail): TJSONValue;
var
  I: Integer;
begin
  FRequest.Method := rmGET;
  FRequest.Resource := Format('/v3.0/orders/%s', [ACorrelationId]);

  FRequest.Execute;
  FRequest.Params.Clear;

  if FResponse.Status.Success then
  begin
    AOrderDetail := TJson.JsonToObject<TOrderDetail>
      (FResponse.JSONValue as TJSONObject);
  end;

  Result := ReturnMessage;
end;

function TiFood.Polling(out APolling: TObjectList<TPolling>): TJSONValue;
var
  I: Integer;
begin
  FRequest.Method := rmGET;
  FRequest.Resource := '/v3.0/events:polling';

  FRequest.Execute;
  FRequest.Params.Clear;

  if FResponse.Status.Success then
  begin

    for I := 0 to (FResponse.JSONValue as TJSONArray).Count - 1 do
    begin
      APolling.Add(TJson.JsonToObject<TPolling>
        (((FResponse.JSONValue as TJSONArray).Items[I] as TJSONObject)));
    end;
  end;

  Result := ReturnMessage;

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
