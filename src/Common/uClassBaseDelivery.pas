unit uClassBaseDelivery;

interface
uses
  REST.Client, REST.Types;
Type
  TClassBaseDelivery = class(TObject)
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

procedure TClassBaseDelivery.addHeader(AName, AValue: String);
begin
  FRequest.Params.AddHeader(AName, AValue);
end;

constructor TClassBaseDelivery.Create(const ABaseUrl: String);
begin
  FClient := TRESTClient.Create(ABaseUrl);
  FRequest := TRESTRequest.Create(nil);
  FResponse := TRestResponse.Create(nil);

  FRequest.Client := FClient;
  FRequest.Response := FResponse;
end;

destructor TClassBaseDelivery.Destroy;
begin
  FreeAndNil(FClient);
  FreeAndNil(FRequest);
  FreeAndNil(FResponse);

  inherited;
end;

end.
