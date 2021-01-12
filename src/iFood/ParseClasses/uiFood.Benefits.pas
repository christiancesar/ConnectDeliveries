unit uiFood.Benefits;

interface

uses
  SysUtils, Classes, uiFood.SponsorshipValues;

Type
  TBenefits = class(TObject)
  private
    FtargetId: String;
    FsponsorshipValues: TSponsorshipValues;
    Ftarget: String;
    Fid: Integer;

  protected

  public
    property value: Integer read Fid write Fid;
    property SponsorshipValues: TSponsorshipValues read FsponsorshipValues
      write FsponsorshipValues;
    property target: String read Ftarget write Ftarget;
    property targetId: String read FtargetId write FtargetId;

    constructor Create;
    destructor Destroy; override;

  published

  end;

implementation

{ TBenefits }

constructor TBenefits.Create;
begin
  FsponsorshipValues := TSponsorshipValues.Create;
end;

destructor TBenefits.Destroy;
begin
  FreeAndNil(FsponsorshipValues);
  inherited;
end;

end.
