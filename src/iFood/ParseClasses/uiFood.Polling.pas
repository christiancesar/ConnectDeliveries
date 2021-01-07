unit uiFood.Polling;

interface

uses
    SysUtils, Classes;

Type
  TPolling = class(TObject)
  private
    Fcode: String;
    FcorrelationId: String;
    Fid: String;
    FcreatedAt: String;
    { private declarations }

  public
    property code: String read Fcode write Fcode;
    property correlationId: String read FcorrelationId write FcorrelationId;
    property createdAt: String read FcreatedAt write FcreatedAt;
    property id: String read Fid write Fid;
    { public declarations }

  end;

implementation



end.
