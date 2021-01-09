unit uiFood.Address;

interface

uses
  SysUtils, Classes;

Type
  TAddress = class(TObject)
  private
    FformattedAddress: String;
    FstreetName: String;
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
    property neighborhood: String read Fneighborhood write Fneighborhood;
    property streetName: String read FstreetName write FstreetName;
    property streetNumber: String read FstreetNumber write FstreetNumber;
    property postalCode: String read FpostalCode write FpostalCode;

  published

  end;

implementation

end.
