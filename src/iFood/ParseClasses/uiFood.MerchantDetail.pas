unit uiFood.MerchantDetail;

interface

uses
  SysUtils, Classes, uiFood.Address;

Type
  TMerchantDetail = class(TObject)
  private
    Fname: String;
    Fid: String;
    Faddress: TAddress;

  protected

  public
    property id: String read Fid write Fid;
    property name: String read Fname write Fname;
    property Address: TAddress read Faddress write Faddress;

    constructor Create;
    destructor Destroy; override;
  published

  end;

implementation

{ TMerchantDetail }

constructor TMerchantDetail.Create;
begin
    Faddress := TAddress.Create;
end;

destructor TMerchantDetail.Destroy;
begin

  inherited;
end;

end.
