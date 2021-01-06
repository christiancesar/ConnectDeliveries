unit uToNoLucro.FoodService;
    
interface
    
uses
    SysUtils, Classes, uToNoLucro.CommonObject;
Type

  TFoodService = class(TObject)
  private
    { private declarations }
        
  public
    property cuisine: TCommonObject read Fcuisine write Fcuisine;
    property preparationTime: TCommonObject read FpreparationTime write FpreparationTime;
    property priceRange: TCommonObject read FpriceRange write FpriceRange;
    property foodCourt: TCommonObject read FfoodCourt write FfoodCourt;
    property &object: String read Fobject write Fobject;

    constructor Create; override;
    destructor Destroy; override;
    { public declarations }
  end;

    
implementation
    

    
end.