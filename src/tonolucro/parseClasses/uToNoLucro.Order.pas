unit uToNoLucro.Order;
    
interface
    
uses
    SysUtils, Classes, uToNoLucro.Status;
Type 

  TOrder = class(TObject)
  private
    { private declarations }
        
  public
    { public declarations }
    property orderId: Integer read ForderId write ForderId;
    property orderUid: String read ForderUid write ForderUid;
    property orderExternalId: String read ForderExternalId write ForderExternalId;
    property merchantId: Integer read FmerchantId write FmerchantId;
    property merchantUid: String read FmerchantUid write FmerchantUid;
    property merchantExternalId: String read FmerchantExternalId write FmerchantExternalId;
    property startedAt: String read FstartedAt write FstartedAt;
    property status: String read Fstatus write Fstatus;
    property workflowAction: TStrings read FworkflowAction write FworkflowAction;
    property &object: String read Fobject write Fobject;

    constructor Create;
    destructor Destroy; override;
  end;
    
implementation
    

    
end.