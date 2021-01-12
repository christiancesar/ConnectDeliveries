unit uiFood.PickupAreaAssigned;

interface

uses
  SysUtils, Classes, uiFood.MetaData;

Type
  TPickupAreaAssigned = class(TObject)
  private
    Fcode: String;
    FcorrelationId: String;
    Fid: String;
    FcreatedAt: String;
    FmetaData: TMetaData;

  protected

  public
    property id: String read Fid write Fid;
    property code: String read Fcode write Fcode;
    property correlationId: String read FcorrelationId write FcorrelationId;
    property createdAt: String read FcreatedAt write FcreatedAt;
    property MetaData: TMetaData read FmetaData write FmetaData;

    constructor Create;
    destructor Destroy; override;

  published

  end;

implementation

{ TPickupAreaAssigned }

constructor TPickupAreaAssigned.Create;
begin
  FmetaData := TMetaData.Create
end;

destructor TPickupAreaAssigned.Destroy;
begin
  FreeAndNil(FmetaData);
  inherited;
end;

end.
