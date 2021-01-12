unit uiFood.Coordinates;

interface

uses
  SysUtils, Classes;

Type
  TCoordinates = class(TObject)
  private
    Flatitude: Integer;
    Flongitude: Integer;

  protected

  public
    property latitude: Integer read Flatitude write Flatitude;
    property longitude: Integer read Flongitude write Flongitude;

  published

  end;

implementation

end.
