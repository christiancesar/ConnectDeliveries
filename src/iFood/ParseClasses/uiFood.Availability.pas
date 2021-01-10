unit uiFood.Availability;

interface

uses
  SysUtils, Classes, uiFood.Reopenable, uiFood.Validation, uiFood.Message,
  System.Generics.Collections;

Type

  TAvailability = class(TObject)
  private
    Fvalidations: TArray<TValidation>;
    Fmessage: TMessage;
    Fcontext: String;
    Fstate: String;
    Freopenable: TReopenable;
    Favailable: Boolean;
    { private declarations }

  public
    property context: String read Fcontext write Fcontext;
    property available: Boolean read Favailable write Favailable;
    property state: String read Fstate write Fstate;
    property reopenable: TReopenable read Freopenable write Freopenable;
    property validations: TArray<TValidation> read Fvalidations
      write Fvalidations;
    property message: TMessage read Fmessage write Fmessage;

    constructor Create;
    destructor Destroy; override;
    { public declarations }

  end;

implementation

{ TAvailability }

constructor TAvailability.Create;
begin
  Fvalidations := TArray<TValidation>.Create();
  Freopenable := TReopenable.Create;
  Fmessage := TMessage.Create;
end;

destructor TAvailability.Destroy;
begin
  FreeAndNil(Fvalidations);
  FreeAndNil(Freopenable);
  FreeAndNil(Fmessage);
  inherited;
end;

end.
