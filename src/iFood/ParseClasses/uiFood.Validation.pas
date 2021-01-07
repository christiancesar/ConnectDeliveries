unit uiFood.Validation;

interface

uses
  SysUtils, Classes, uiFood.Message;

Type

  TValidation = class(TObject)
  private
    Fcode: String;
    Fmessage: TMessage;
    Fstate: String;
    Fid: String;
    { private declarations }

  public
    property id: String read Fid write Fid;
    property code: String read Fcode write Fcode;
    property state: String read Fstate write Fstate;
    property &message: TMessage read Fmessage write Fmessage;

    constructor Create;
    destructor Destroy; override;
    { public declarations }

  end;

implementation

{ TValidation }

constructor TValidation.Create;
begin
  Fmessage := TMessage.Create;
end;

destructor TValidation.Destroy;
begin
  FreeAndNil(Fmessage);
  inherited;
end;

end.
