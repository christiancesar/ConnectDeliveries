unit uToNoLucro.SubItem;
    
interface
    
uses
    SysUtils, Classes;
Type 

  TSubItem = class(TObject)
  private
    { private declarations }

  public
    { public declarations }
    property productId: Integer read FproductId write FproductId;
    property productUid: String read FproductUid write FproductUid;
    property productExternalId: String read FproductExternalId write FproductExternalId;
    property quantity: Integer read Fquantity write Fquantity;
    property amountUnit: Currency read FamountUnit write FamountUnit;
    property amountTotal: Currency read FamountTotal write FamountTotal;
    property title: String read Ftitle write Ftitle;
    property titleInternalOrder: String read FtitleInternalOrder write FtitleInternalOrder;
    property productGroupId: Integer read FproductGroupId write FproductGroupId;
    property productGroupUid: String read FproductGroupUid write FproductGroupUid;
    property productGroupTitle: String read FproductGroupTitle write FproductGroupTitle;
    property productGroupTitleProductChoice: String read FproductGroupTitleProductChoice write FproductGroupTitleProductChoice;
    property &object: String read Fobject write Fobject;
  end;
    
implementation
    

    
end.