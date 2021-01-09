unit uReturnMessage;

interface

uses
  SysUtils, Classes, System.JSON, REST.JSON;

Type

  TReturnMessage = class(TObject)
  private
    Fsuccess: Boolean;
    Fcode: Integer;
    FcodeDescription: String;
    Fobject: String;
    { private declarations }

  protected
    { protected declarations }

  public
    function AsJson: TJSONValue;
    function AsObject: TReturnMessage;

    constructor Create(ASuccess: Boolean; AObject: String;
      ACode: Integer; ACodeDescription: String); reintroduce;
    { public declarations }

  end;

implementation

{ TReturnMessage }

{ TReturnMessage }

function TReturnMessage.AsJson: TJSONValue;
begin
  Result:= (TJson.ObjectToJsonObject(Self) as TJSONValue);
end;

function TReturnMessage.AsObject: TReturnMessage;
begin
  Result := Self;
end;

constructor TReturnMessage.Create(ASuccess: Boolean; AObject: String;
  ACode: Integer; ACodeDescription: String);
begin
  Fsuccess := ASuccess;
  Fcode := ACode;
  FcodeDescription := ACodeDescription;
  Fobject := AObject;
end;

end.
