unit uBaseDelivery;

interface
uses
  REST.Client, REST.Types;
Type
  TBaseDelivery = class(TObject)
  private

  protected
    FClient: TRESTClient;
    FRequest: TRESTRequest;
    FResponse: TRestResponse;
    { protected declarations }

  public
    procedure addHeader(AName, AValue: String);
    constructor Create(const ABaseUrl: String);
    destructor Destroy; override;

  published

  end;

implementation
uses
  System.SysUtils;

{ TClassBaseDelivery }

procedure TBaseDelivery.addHeader(AName, AValue: String);
begin
  FRequest.Params.AddHeader(AName, AValue);
  FRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
end;

constructor TBaseDelivery.Create(const ABaseUrl: String);
begin
  if ABaseUrl.IsEmpty then
    raise Exception.Create('Url base não pode ser vazia!');

  FClient := TRESTClient.Create(ABaseUrl);
  FRequest := TRESTRequest.Create(nil);
  FResponse := TRestResponse.Create(nil);

  FRequest.Client := FClient;
  FRequest.Response := FResponse;
end;

destructor TBaseDelivery.Destroy;
begin
  FreeAndNil(FClient);
  FreeAndNil(FRequest);
  FreeAndNil(FResponse);

  inherited;
end;

end.
