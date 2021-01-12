unit uiFood.DeliveryMethod;

interface

uses
  SysUtils, Classes;

Type
  TDeliveryMethod = class(TObject)
  private
    Fmode: String;
    Fid: String;
    FmaxTime: Integer;
    FdeliveredBy: String;
    Fvalue: Currency;
    FminTime: Integer;

  protected

  public
    property id: String read Fid write Fid;
    property value: Currency read Fvalue write Fvalue;
    property minTime: Integer read FminTime write FminTime;
    property maxTime: Integer read FmaxTime write FmaxTime;
    property mode: String read Fmode write Fmode;
    property deliveredBy: String read FdeliveredBy write FdeliveredBy;
  published

  end;

implementation

end.
