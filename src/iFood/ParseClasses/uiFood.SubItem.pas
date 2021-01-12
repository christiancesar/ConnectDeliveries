unit uiFood.SubItem;

interface

uses
  SysUtils, Classes;

Type
  TSubItem = class(TObject)
  private
    Fname: String;
    FexternalId: String;
    Fprice: Currency;
    Faddition: Currency;
    Fid: String;
    Fdiscount: Currency;
    Fquantity: Integer;
    FtotalPrice: Currency;
    FexternalCode: String;

  protected

  public
    property id: String read Fid write Fid;
    property name: String read Fname write Fname;
    property quantity: Integer read Fquantity write Fquantity;
    property price: Currency read Fprice write Fprice;
    property totalPrice: Currency read FtotalPrice write FtotalPrice;
    property discount: Currency read Fdiscount write Fdiscount;
    property addition: Currency read Faddition write Faddition;
    property externalId: String read FexternalId write FexternalId;
    property externalCode: String read FexternalCode write FexternalCode;

  published

  end;

implementation

end.
