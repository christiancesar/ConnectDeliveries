unit uClassBaseDelivery;

interface
uses
  REST.Client, REST.Types;
Type
  TClassBaseDelivery = class(TObject)
  private

  protected
    FClient: TRESTClient;
    FResquest: TRESTRequest;
    FResponse: TRestResponse;
    { protected declarations }

  public
    constructor Create(const ABaseUrl, AContentType: String);
    destructor Destroy; override;

  published

  end;

implementation
uses
  System.SysUtils;

{ TClassBaseDelivery }

constructor TClassBaseDelivery.Create(const ABaseUrl, AContentType: String);
begin
  FClient := TRESTClient.Create(ABaseUrl);
  FClient.ContentType := AContentType;
  FResquest := TRESTRequest.Create(nil);
  FResponse := TRestResponse.Create(nil);

  FResquest.Client := FClient;
  FResquest.Response := FResponse;
end;

destructor TClassBaseDelivery.Destroy;
begin
  FreeAndNil(FClient);
  FreeAndNil(FResquest);
  FreeAndNil(FResponse);

  inherited;
end;

end.
