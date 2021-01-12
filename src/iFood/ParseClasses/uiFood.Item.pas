unit uiFood.Item;

interface

uses
  SysUtils, Classes, uiFood.SubItem;

Type
  TItem = class(TObject)
  private
    Fname: String;
    FexternalId: String;
    FsubItems: TArray<TSubItem>;
    Fprice: Currency;
    Faddition: Currency;
    Fid: String;
    FsubItemsPrice: Currency;
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
    property subItemsPrice: Currency read FsubItemsPrice write FsubItemsPrice;
    property totalPrice: Currency read FtotalPrice write FtotalPrice;
    property discount: Currency read Fdiscount write Fdiscount;
    property addition: Currency read Faddition write Faddition;
    property externalId: String read FexternalId write FexternalId;
    property externalCode: String read FexternalCode write FexternalCode;
    property subItems: TArray<TSubItem> read FsubItems write FsubItems;

    constructor Create;
    destructor Destroy; override;

  published

  end;

implementation

{ TItem }

constructor TItem.Create;
begin
  FsubItems := TArray<TSubItem>.Create();
end;

destructor TItem.Destroy;
begin
  FreeAndNil(FsubItems);
  inherited;
end;

end.
