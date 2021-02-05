unit uiFood;

interface

uses
  REST.Json, System.Json, REST.Types, System.Generics.Collections,
  uiFood.Authentication, uiFood.Credential, uBaseDelivery, uiFood.Merchant,
  uiFood.Unavailability, uiFood.Availability, uiFood.Polling, System.Classes,
  System.SysUtils, uiFood.OrderDetail, uReturnMessage;

Type
  TiFood = class(TBaseDelivery)
  private
    { private declarations }
  protected
    function ReturnMessageObject: TReturnMessage;

    function ReturnMessage: TJSONValue; overload;
    { protected declarations }
  public
    { Authentication }

    /// <summary>
    /// Emite um token de acesso para comunicação de todos os endpoints, necessário em todas as chamadas da API.
    /// </summary>
    function Authentication(const ACredential: TCredential;
      out OAuthentication: TAuthentication): TReturnMessage;

    { Merchant v1 }

    /// <summary>
    /// Lista os merchants que o usuário tem permissão incluindo o merchant_uuid
    /// </summary>
    function Merchants(out AMerchant: TObjectList<TMerchant>): TReturnMessage;

    /// <summary>
    /// Lista todas as indisponibilidades cadastradas para um merchant.
    /// Consulte as indisponibilidades e obtenha o id da indisponibilidade
    /// para removê-la
    /// </summary>
    function Unavailabilities(AMerchantUUID: String;
      out AUnavailabilities: TObjectList<TUnavailability>)
      : TReturnMessage; Overload;

    /// <summary>
    /// Remove indisponibilidades cadastradas
    /// </summary>
    function Unavailabilities(AMerchantUUID, AUnavailabilityId: String)
      : TReturnMessage; Overload;

    /// <summary>
    /// Cadastra uma indisponibilidade para o merchant.
    /// </summary>
    function Unavailabilities(AMerchantUUID, ADescription: String;
      AMinutes: Integer; AUnavailability: TUnavailability)
      : TReturnMessage; Overload;

    { Merchant v2 }
    /// <summary>
    /// Retorna o status do merchant na plataforma
    /// </summary>
    function MerchantAvailability(AMerchantUUID: String;
      out AAvailabilities: TObjectList<TAvailability>): TReturnMessage;

    { Orders }
    /// <summary>
    /// Receber novos pedidos: Obtém todos os eventos ainda não recebidos
    /// </summary>
    function Polling(out APolling: TObjectList<TPolling>): TReturnMessage;

    /// <summary>
    /// Após o PDV/POS receber os eventos de pedido via polling, é necessário
    /// que se faça o acknowledgement para o iFood saber que os eventos foram
    /// recebidos e o e-PDV não precisa mais receber esses eventos nas próximas
    /// requests de polling. A request de acknowledgment aceita uma lista de no
    /// máximo 2000 ids de eventos. Faça uma request de acknowledgment para cada
    /// request de polling com resultados.
    /// </summary>
    function Acknowledgment(AIdProcess: TStringList): Boolean;

    /// <summary>
    /// Obtém os detalhes do pedido
    /// </summary>
    function OrderDetail(ACorrelationId: String; out AOrderDetail: TOrderDetail)
      : TReturnMessage;

    function StatusOrder(ACorrelationId, AStatus: String; AAccepted: Boolean)
      : TReturnMessage;

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
  FMX.Dialogs, REST.HttpClient;

{ TiFood }

function TiFood.Acknowledgment(AIdProcess: TStringList): Boolean;
var
  joAcknowledgment: TJSONObject;
  jaAcknowledgment: TJSONArray;
  ssData: TStringStream;
  Id: String;
begin
  Result := False;

  jaAcknowledgment := TJSONArray.Create;
  try
    { Cria Array Json }
    for Id in AIdProcess do
    begin
      joAcknowledgment := TJSONObject.Create(TJSONPair.Create('id', TJSONString.Create(Id)));
      jaAcknowledgment.AddElement(joAcknowledgment as TJSONValue);
    end;

    ssData := TStringStream.Create(jaAcknowledgment.Format);

    FRequest.Method := rmPOST;
    FRequest.Resource := '/v1.0/events/acknowledgment';
    FRequest.Params.AddBody(ssData, ctAPPLICATION_JSON);
    FRequest.Execute;
    FRequest.Params.Clear;

    if FResponse.Status.Success then
    begin
      Result := True;
    end

  finally
    FreeAndNil(jaAcknowledgment);
    FreeAndNil(ssData);
  end;

end;

function TiFood.Authentication(const ACredential: TCredential;
  out OAuthentication: TAuthentication): TReturnMessage;
begin

  if not Assigned(ACredential) then
    raise Exception.Create('Credencial fazia!');

  FRequest.Method := rmPOST;
  FRequest.Resource := '/oauth/token';
  FRequest.AddParameter('client_id', ACredential.client_id);
  FRequest.AddParameter('client_secret', ACredential.client_secret);
  FRequest.AddParameter('grant_type', ACredential.grant_type);
  FRequest.AddParameter('username', ACredential.username);
  FRequest.AddParameter('password', ACredential.password);
  FRequest.Execute;

  if Assigned(OAuthentication) then
    OAuthentication.CleanupInstance;

  if FResponse.Status.Success then
  begin
    OAuthentication := TJson.JsonToObject<TAuthentication>
      (FResponse.JSONValue as TJSONObject);
  end;

  Result := ReturnMessageObject;

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
  : TReturnMessage;
var
  sVersion: String;
begin

  if AStatus.Equals(Integration) or AStatus.Equals(Conformation) or
    AStatus.Equals(Dispatchh) then
    sVersion := 'v1.0'
  else if AStatus.Equals(ReadyToDeliver) or AStatus.Equals(CancellationAccepted)
    or AStatus.Equals(CancellationDenied) then
    sVersion := 'v2.0'
  else
    sVersion := 'v3.0';

  FRequest.Method := rmPOST;
  FRequest.Resource := Format('/%s/orders/%s/statuses/%s',
    [sVersion, ACorrelationId, AStatus]);
  FRequest.Execute;
  FRequest.Params.Clear;

  AAccepted := FResponse.Status.Success;

  Result := ReturnMessageObject;

end;

function TiFood.MerchantAvailability(AMerchantUUID: String;
  out AAvailabilities: TObjectList<TAvailability>): TReturnMessage;
var
  I: Integer;
  jaAvailabilities: TJSONArray;
  joAvailability: TJSONObject;
begin

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

  Result := ReturnMessageObject;
end;

function TiFood.Merchants(out AMerchant: TObjectList<TMerchant>)
  : TReturnMessage;
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

  Result := ReturnMessageObject;

end;

function TiFood.OrderDetail(ACorrelationId: String;
  out AOrderDetail: TOrderDetail): TReturnMessage;
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

  Result := ReturnMessageObject;
end;

function TiFood.Polling(out APolling: TObjectList<TPolling>): TReturnMessage;
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
    Result := ReturnMessageObject;
  end
  else if FResponse.StatusCode = 404 then
  begin
    Result := ReturnMessageObject;
    Abort;
  end;
end;

function TiFood.ReturnMessage: TJSONValue;
begin
  Result := TReturnMessage.Create(FResponse.Status.Success, FResponse.JSONText,
    FResponse.StatusCode, FResponse.StatusText).AsJson;
end;

function TiFood.ReturnMessageObject: TReturnMessage;
begin
  Result := TReturnMessage.Create(FResponse.Status.Success, FResponse.JSONText,
    FResponse.StatusCode, FResponse.StatusText).AsObject;
end;

function TiFood.Unavailabilities(AMerchantUUID, ADescription: String;
  AMinutes: Integer; AUnavailability: TUnavailability): TReturnMessage;
var
  joUnavailability: TJSONObject;
begin

  joUnavailability := TJSONObject.Create();

  joUnavailability.AddPair('description', TJSONString.Create(ADescription));
  joUnavailability.AddPair('minutes', TJSONNumber.Create(AMinutes));
  FRequest.Method := rmPOST;
  FRequest.Resource := Format('/v1.0/merchants/%s/unavailabilities:now',
    [AMerchantUUID]);

  FRequest.AddBody(joUnavailability);
  FRequest.Execute;
  FRequest.Params.Clear;

  if FResponse.Status.Success then
  begin
    AUnavailability := TJson.JsonToObject<TUnavailability>
      (FResponse.JSONValue as TJSONObject);
  end;

  Result := ReturnMessageObject;
end;

function TiFood.Unavailabilities(AMerchantUUID, AUnavailabilityId: String)
  : TReturnMessage;
var
  I: Integer;
begin

  FRequest.Method := rmDELETE;
  FRequest.Resource := Format('/v1.0/merchants/%s/unavailabilities/%s',
    [AMerchantUUID, AUnavailabilityId]);

  FRequest.Execute;
  FRequest.Params.Clear;

  Result := ReturnMessageObject;
end;

function TiFood.Unavailabilities(AMerchantUUID: String;
  out AUnavailabilities: TObjectList<TUnavailability>): TReturnMessage;
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

  Result := ReturnMessageObject;
end;

end.
