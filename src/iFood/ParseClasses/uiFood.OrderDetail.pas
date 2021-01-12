unit uiFood.OrderDetail;

interface

uses
  SysUtils, Classes, uiFood.MerchantDetail, uiFood.Payment, uiFood.Customer,
  uiFood.Item, uiFood.DeliveryAddress, uiFood.SubItem,
  uiFood.PickupAreaAssigned, uiFood.Localizer, uiFood.Benefits,
  uiFood.DeliveryMethod, uiFood.ReplacementOptions;

Type
  TOrderDetail = class(TObject)
  private

    FtakeOutTimeInSeconds: Integer;
    FtakeOutDateTime: String;
    FdeliveryDateTime: String;
    FsubTotal: String;
    FshortReference: String;
    Fid: String;
    FpreparationStartDateTime: String;
    FtotalPrice: String;
    FcreatedAt: String;
    FisTest: Boolean;
    FpreparationTimeInSeconds: String;
    Fscheduled: Boolean;
    FdeliveryFee: String;
    Freference: String;
    Fmerchant: TMerchantDetail;
    FdeliveryMethod: TDeliveryMethod;
    Flocalizer: TLocalizer;
    FreplacementOptions: TReplacementOptions;
    Fitems: TArray<TItem>;
    FdeliveryAddress: TDeliveryAddress;
    Fcustomer: TCustomer;
    Ftags: TArray<String>;
    Fbenefits: TArray<TBenefits>;
    FpickupAreaAssigned: TPickupAreaAssigned;
    Fpayments: TArray<TPayment>;
  public
    property id: String read Fid write Fid;
    property reference: String read Freference write Freference;
    property shortReference: String read FshortReference write FshortReference;
    property createdAt: String read FcreatedAt write FcreatedAt;
    property scheduled: Boolean read Fscheduled write Fscheduled;
    property merchant: TMerchantDetail read Fmerchant write Fmerchant;
    property payments: TArray<TPayment> read Fpayments write Fpayments;
    property Customer: TCustomer read Fcustomer write Fcustomer;
    property items: TArray<TItem> read Fitems write Fitems;
    property subTotal: String read FsubTotal write FsubTotal;
    property totalPrice: String read FtotalPrice write FtotalPrice;
    property deliveryFee: String read FdeliveryFee write FdeliveryFee;
    property DeliveryAddress: TDeliveryAddress read FdeliveryAddress
      write FdeliveryAddress;
    property deliveryDateTime: String read FdeliveryDateTime
      write FdeliveryDateTime;
    property preparationTimeInSeconds: String read FpreparationTimeInSeconds
      write FpreparationTimeInSeconds;
    property preparationStartDateTime: String read FpreparationStartDateTime
      write FpreparationStartDateTime;
    property takeOutTimeInSeconds: Integer read FtakeOutTimeInSeconds
      write FtakeOutTimeInSeconds;
    property takeOutDateTime: String read FtakeOutDateTime
      write FtakeOutDateTime;
    property pickup_area_assigned: TPickupAreaAssigned read FpickupAreaAssigned
      write FpickupAreaAssigned;
    property Localizer: TLocalizer read Flocalizer write Flocalizer;
    property isTest: Boolean read FisTest write FisTest;
    property Benefits: TArray<TBenefits> read Fbenefits write Fbenefits;
    property DeliveryMethod: TDeliveryMethod read FdeliveryMethod
      write FdeliveryMethod;
    property ReplacementOptions: TReplacementOptions read FreplacementOptions
      write FreplacementOptions;
    property tags: TArray<String> read Ftags write Ftags;

    constructor Create;
    destructor Destroy; override;
  published

  end;

implementation

{ TOrderDetail }

constructor TOrderDetail.Create;
begin

  Fmerchant := TMerchantDetail.Create;
  FdeliveryMethod := TDeliveryMethod.Create;
  Flocalizer := TLocalizer.Create;
  FreplacementOptions := TReplacementOptions.Create;
  FdeliveryAddress := TDeliveryAddress.Create;
  Fcustomer := TCustomer.Create;
  FpickupAreaAssigned := TPickupAreaAssigned.Create;

  Fitems := TArray<TItem>.Create();
  Ftags := TArray<String>.Create();
  Fbenefits := TArray<TBenefits>.Create();
  Fpayments := TArray<TPayment>.Create();

end;

destructor TOrderDetail.Destroy;
begin

  FreeAndNil(Fmerchant);
  FreeAndNil(FdeliveryMethod);
  FreeAndNil(Flocalizer);
  FreeAndNil(FreplacementOptions);
  FreeAndNil(FdeliveryAddress);
  FreeAndNil(Fcustomer);
  FreeAndNil(FpickupAreaAssigned);

  Finalize(Ftags);
  Finalize(Fbenefits);
  Finalize(Fitems);
  Finalize(Fpayments);
  inherited;
end;

end.
