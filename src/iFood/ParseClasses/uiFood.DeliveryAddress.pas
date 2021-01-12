unit uiFood.DeliveryAddress;

interface

uses
  SysUtils, Classes, uiFood.Coordinates;

Type
  TDeliveryAddress = class(TObject)
  private
    FformattedAddress: String;
    FstreetName: String;
    Fcoordinates: TCoordinates;
    FpostalCode: String;
    Fstate: String;
    Fcountry: String;
    FstreetNumber: String;
    Fneighborhood: String;
    Fcity: String;

  protected

  public
    property formattedAddress: String read FformattedAddress
      write FformattedAddress;
    property country: String read Fcountry write Fcountry;
    property state: String read Fstate write Fstate;
    property city: String read Fcity write Fcity;
    property coordinates: TCoordinates read Fcoordinates write Fcoordinates;
    property neighborhood: String read Fneighborhood write Fneighborhood;
    property streetName: String read FstreetName write FstreetName;
    property streetNumber: String read FstreetNumber write FstreetNumber;
    property postalCode: String read FpostalCode write FpostalCode;

    constructor Create;
    destructor Destroy; override;

  published

  end;

implementation

{ TDeliveryAddress }

constructor TDeliveryAddress.Create;
begin

  Fcoordinates := TCoordinates.Create;

end;

destructor TDeliveryAddress.Destroy;
begin
  FreeAndNil(Fcoordinates);
  inherited;
end;

end.
