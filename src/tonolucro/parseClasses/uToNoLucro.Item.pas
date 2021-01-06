unit uToNoLucro.Item;
    
interface
    
uses
    SysUtils, Classes;
Type 

  TItem = class(TObject)
  private
    { private declarations }
    property adId: Integer read FadId write FadId
    property adUid: String read FadUid write FadUid
    property adExternalId: String read FadExternalId write FadExternalId
    property pricingId: Integer read FpricingId write FpricingId
    property notes: String read Fnotes write Fnotes
    property quantity: Integer read Fquantity write Fquantity
    property amountUnit: Currency read FamountUnit write FamountUnit
    property amountTotal: Currency read FamountTotal write FamountTotal
    property title: String read Ftitle write Ftitle
    property titleInternal: String read FtitleInternal write FtitleInternal

    property items: TObjectList<TSubItem> read Fitems write Fitems;

    constructor Create;
    destructor Destroy; override;
  public
    { public declarations }
  end;
    
implementation
    

    
end.