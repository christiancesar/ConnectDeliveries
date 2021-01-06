unit uToNoLucro.Cart;
    
interface
    
uses
    SysUtils, Classes, uToNoLucro.Item;
Type 

  TCart = class(TObject)
  private
    { private declarations }
        
  public
    { public declarations }
    property amountCart: Currency read FamountCart write FamountCart;
    property amountCartDiscount: Currency read FamountCartDiscount write FamountCartDiscount;
    property amountCartTotal: Currency read FamountCartTotal write FamountCartTotal;
    property items: TObjectList<TItem> read Fitems write Fitems;
    
    property &object: String read Fobject write Fobject;

    constructor Create;
    destructor Destroy; override;

  end;
    
implementation
    

    
end.