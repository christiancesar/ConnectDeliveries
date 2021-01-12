unit uiFood.MetaData;

interface

uses
  SysUtils, Classes;

Type
  TMetaData = class(TObject)
  private
    FPICKUP_AREA_CODE: String;
    FPICKUP_AREA_TYPE: String;

  protected

  public
    property PICKUP_AREA_CODE: String read FPICKUP_AREA_CODE write FPICKUP_AREA_CODE;
    property PICKUP_AREA_TYPE: String read FPICKUP_AREA_TYPE write FPICKUP_AREA_TYPE;

  published

  end;

implementation

end.
