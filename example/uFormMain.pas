unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage, System.Actions,
  Vcl.ActnList, REST.Types, Vcl.Buttons, REST.Client, uIfood.Credential,
  Vcl.ComCtrls, Vcl.WinXCtrls, Vcl.WinXPanels, System.Generics.Collections,
  uIfood, uIfood.Authentication, uIfood.Merchant, uIfood.Unavailability,
  uIfood.Availability, uIfood.Polling, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, uiFood.OrderDetail;

type
  TFormMain = class(TForm)
    Memo1: TMemo;
    btnGetToken: TSpeedButton;
    btnClear: TSpeedButton;
    btnMerchants: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    SplitView1: TSplitView;
    Label1: TLabel;
    Label2: TLabel;
    btnPostUnavailabilities: TSpeedButton;
    btnDeleteUnavailabilities: TSpeedButton;
    btnGetUnavailabilities: TSpeedButton;
    Label3: TLabel;
    btnMerchantAvailability: TSpeedButton;
    pHeader: TPanel;
    cbRestaurant: TComboBox;
    tsStatus: TToggleSwitch;
    btnPolling: TSpeedButton;
    BtnAcknow: TSpeedButton;
    btnDispatch: TSpeedButton;
    btnConfirmation: TSpeedButton;
    btnIntegration: TSpeedButton;
    btnOrderDetail: TSpeedButton;
    Label5: TLabel;
    btnCancellationDenied: TSpeedButton;
    btnCancellationRequest: TSpeedButton;
    btnReadyDelivery: TSpeedButton;
    btnCancellationAccepted: TSpeedButton;
    ScrollBox1: TScrollBox;
    pPrincipal: TPanel;
    DBGrid1: TDBGrid;
    pLog: TPanel;
    dsPolling: TDataSource;
    cdsPolling: TClientDataSet;
    cdsPollingcode: TStringField;
    cdsPollingcorrelationId: TStringField;
    cdsPollingcreatedAt: TStringField;
    cdsPollingid: TStringField;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure CloseButtonClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnGetTokenClick(Sender: TObject);
    procedure btnMerchantsClick(Sender: TObject);
    procedure btnGetUnavailabilitiesClick(Sender: TObject);
    procedure btnDeleteUnavailabilitiesClick(Sender: TObject);
    procedure btnPostUnavailabilitiesClick(Sender: TObject);
    procedure btnMerchantAvailabilityClick(Sender: TObject);
    procedure btnPollingClick(Sender: TObject);
    procedure btnOrderDetailClick(Sender: TObject);
    procedure btnIntegrationClick(Sender: TObject);
    procedure btnConfirmationClick(Sender: TObject);
    procedure btnDispatchClick(Sender: TObject);
    procedure btnReadyDeliveryClick(Sender: TObject);
    procedure btnCancellationRequestClick(Sender: TObject);
    procedure btnCancellationDeniedClick(Sender: TObject);
    procedure btnCancellationAcceptedClick(Sender: TObject);
  private
    FCredential: TCredential;
    FMerchants: TObjectList<TMerchant>;
    FAuth: TAuthentication;
    FUnavailabilities: TObjectList<TUnavailability>;

    procedure Log(AString: String);
    procedure SetStatusRestaurant(AAvailabilities: TObjectList<TAvailability>);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;
    
implementation

uses
  System.JSON, REST.JSON;

{$R *.dfm}

procedure TFormMain.CloseButtonClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  sEnv: TStringStream;
  sPath: String;
  joJson: TJSONObject;
  jvJson: TJsonValue;
begin

  try
    sEnv := TStringStream.Create;
    joJson := TJSONObject.Create;
    try
      sPath := ExtractFilePath(Application.ExeName);
      sEnv.LoadFromFile(sPath + '\.env.json');

      { Convertendo o .env e procurando as credenciais de homologacao }
      joJson := TJSONObject.ParseJSONValue(sEnv.DataString) as TJSONObject;
      jvJson := joJson.FindValue('credenciais.ifood.homologacao');
      FCredential := TCredential.Create;
      FCredential := TJson.JsonToObject<TCredential>(jvJson as TJSONObject);

      FMerchants := TObjectList<TMerchant>.Create;
      FAuth := TAuthentication.Create;
      FUnavailabilities := TObjectList<TUnavailability>.Create;
    except
      on E: Exception do
        raise Exception.Create(E.Message);
    end;
  finally
    FreeAndNil(sEnv);
    FreeAndNil(joJson);
  end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCredential);
  FreeAndNil(FMerchants);
  FreeAndNil(FAuth);
  FreeAndNil(FUnavailabilities);
end;

procedure TFormMain.Log(AString: String);
begin
  Memo1.Lines.Add(AString);
  Memo1.Lines.Add('');
end;

procedure TFormMain.SetStatusRestaurant(AAvailabilities
  : TObjectList<TAvailability>);
var
  oAvailability: TAvailability;
begin

  for oAvailability in AAvailabilities do
  begin
    Log(oAvailability.Message.title);

    if oAvailability.available then
    begin
      tsStatus.FrameColor := clGreen;
      tsStatus.ThumbColor := clGreen;
      tsStatus.State := tssOn;
    end
    else
    begin
      tsStatus.FrameColor := clRed;
      tsStatus.ThumbColor := clRed;
      tsStatus.State := tssOff;
    end;
  end;

end;

procedure TFormMain.btnConfirmationClick(Sender: TObject);
var
  oIfood: Tifood;
  bAccepted: Boolean;
begin

  try
    oIfood := Tifood.Create('https://pos-api.ifood.com.br');
    oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
    oIfood.StatusOrder(cdsPollingcorrelationId.AsString , Conformation, bAccepted);

    Log(Format('Pedido %s foi %s', [cdsPollingcorrelationId.AsString, Conformation]));
  finally
    FreeAndNil(oIfood);
  end;
end;

procedure TFormMain.btnDeleteUnavailabilitiesClick(Sender: TObject);
var
  oIfood: Tifood;
  bDelete: Boolean;
  oUnavailability: TUnavailability;
begin
  if FUnavailabilities.Count = 0 then
    Log('Não existem indisponibilidades para serem removidas!');
  oUnavailability := TUnavailability.Create;
  try
    try
      oIfood := Tifood.Create('https://pos-api.ifood.com.br');
      oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);

      for oUnavailability in FUnavailabilities do
      begin
        Log(oIfood.Unavailabilities(FMerchants.Items[cbRestaurant.ItemIndex].id,
          oUnavailability.id, bDelete).Format);

        if bDelete then
          Log(Format('Indisponibilidades %s removida.', [oUnavailability.id]));
      end;

    except
      on E: Exception do
    end;
  finally
    FreeAndNil(oIfood);
    FreeAndNil(oUnavailability);
  end;

end;

procedure TFormMain.btnDispatchClick(Sender: TObject);
var
  oIfood: Tifood;
  bAccepted: Boolean;
begin

  try
    oIfood := Tifood.Create('https://pos-api.ifood.com.br');
    oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
    oIfood.StatusOrder(cdsPollingcorrelationId.AsString , Dispatchh, bAccepted);

    Log(Format('Pedido %s foi %s', [cdsPollingcorrelationId.AsString, Dispatch]));
  finally
    FreeAndNil(oIfood);
  end;
end;

procedure TFormMain.btnGetTokenClick(Sender: TObject);
var
  oIfood: Tifood;
begin
  try
    try
      oIfood := Tifood.Create(FCredential.baseURL);

      oIfood.Authentication(FCredential, FAuth);
      Log('Token de acesso: ' + FAuth.access_token);

    except
      on E: Exception do
    end;
  finally
    FreeAndNil(oIfood);
  end;
end;

procedure TFormMain.btnGetUnavailabilitiesClick(Sender: TObject);
var
  oIfood: Tifood;
begin
  try
    try
      oIfood := Tifood.Create('https://pos-api.ifood.com.br');
      oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
      oIfood.Unavailabilities(FMerchants.Items[cbRestaurant.ItemIndex].id,
        FUnavailabilities);
      if Assigned(FUnavailabilities) then
        Log('Não foram encontradas indisponibilidades.');

    except
      on E: Exception do
    end;
  finally
    FreeAndNil(oIfood);
  end;

end;

procedure TFormMain.btnIntegrationClick(Sender: TObject);
var
  oIfood: Tifood;
  bAccepted: Boolean;
begin

  try
    oIfood := Tifood.Create('https://pos-api.ifood.com.br');
    oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
    oIfood.StatusOrder(cdsPollingcorrelationId.AsString , Integration, bAccepted);

    Log(Format('Pedido %s foi %s', [cdsPollingcorrelationId.AsString, Integration]));
  finally
    FreeAndNil(oIfood);
  end;

end;

procedure TFormMain.btnCancellationAcceptedClick(Sender: TObject);
var
  oIfood: Tifood;
  bAccepted: Boolean;
begin

  try
    oIfood := Tifood.Create('https://pos-api.ifood.com.br');
    oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
    oIfood.StatusOrder(cdsPollingcorrelationId.AsString , CancellationAccepted, bAccepted);

    Log(Format('O %s do seu pedido %s foi %b', [CancellationAccepted, cdsPollingcorrelationId.AsString, bAccepted]));
  finally
    FreeAndNil(oIfood);
  end;
end;

procedure TFormMain.btnCancellationDeniedClick(Sender: TObject);
var
  oIfood: Tifood;
  bAccepted: Boolean;
begin

  try
    oIfood := Tifood.Create('https://pos-api.ifood.com.br');
    oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
    oIfood.StatusOrder(cdsPollingcorrelationId.AsString , CancellationDenied, bAccepted);

    Log(Format('O %s do seu pedido %s foi %b', [CancellationDenied, cdsPollingcorrelationId.AsString, bAccepted]));
  finally
    FreeAndNil(oIfood);
  end;
end;

procedure TFormMain.btnCancellationRequestClick(Sender: TObject);
var
  oIfood: Tifood;
  bAccepted: Boolean;
begin

  try
    oIfood := Tifood.Create('https://pos-api.ifood.com.br');
    oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
    oIfood.StatusOrder(cdsPollingcorrelationId.AsString , CancellationRequested, bAccepted);

    Log(Format('O %s do seu pedido %s foi %b', [CancellationRequested, cdsPollingcorrelationId.AsString, bAccepted]));
  finally
    FreeAndNil(oIfood);
  end;
end;

procedure TFormMain.btnClearClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TFormMain.btnMerchantAvailabilityClick(Sender: TObject);
var
  oIfood: Tifood;
  oAvailabilities: TObjectList<TAvailability>;
begin
  try
    oAvailabilities := TObjectList<TAvailability>.Create;
    try
      oIfood := Tifood.Create('https://pos-api.ifood.com.br');
      oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
      Log(oIfood.MerchantAvailability(FMerchants.Items[cbRestaurant.ItemIndex]
        .id, oAvailabilities).Format);

      SetStatusRestaurant(oAvailabilities);

    except
      on E: Exception do
    end;
  finally
    FreeAndNil(oIfood);
    FreeAndNil(oAvailabilities);
  end;
end;

procedure TFormMain.btnMerchantsClick(Sender: TObject);
var
  oIfood: Tifood;
  oMerchant: TMerchant;
  name: String;
begin
  try
    oMerchant := TMerchant.Create;
    try
      oIfood := Tifood.Create('https://pos-api.ifood.com.br');
      oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
      Log(oIfood.Merchants(FMerchants).Format);
      for oMerchant in FMerchants do
      begin
        cbRestaurant.Items.Add(oMerchant.name);
      end;

      if cbRestaurant.Items.Count >= 0 then
        cbRestaurant.ItemIndex := 0;

      Log(Format
        ('Foram encontrados %d restaurante(s) cadastrados com essas credenciais!',
        [FMerchants.Count]));
    except
      on E: Exception do
    end;
  finally
    FreeAndNil(oIfood);
  end;
end;

procedure TFormMain.btnOrderDetailClick(Sender: TObject);
var
  oIfood: Tifood;
  oOrderDetail: TOrderDetail;
begin
  try
    oOrderDetail := TOrderDetail.Create;
    oIfood := Tifood.Create('https://pos-api.ifood.com.br');
    oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);

    oIfood.OrderDetail(cdsPollingcorrelationId.AsString, oOrderDetail);
  finally
    FreeAndNil(oIfood);
    FreeAndNil(oOrderDetail)
  end;
  
end;

procedure TFormMain.btnPostUnavailabilitiesClick(Sender: TObject);
var
  oIfood: Tifood;
  sDescricao: String;
  iMinuto: Integer;
  oUnavailability: TUnavailability;
begin

  oUnavailability := TUnavailability.Create;
  try
    sDescricao := 'Erro na internet';
    iMinuto := 30;
    try
      oIfood := Tifood.Create('https://pos-api.ifood.com.br');
      oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);

      Log(oIfood.Unavailabilities(FMerchants.Items[cbRestaurant.ItemIndex].id,
        sDescricao, iMinuto, oUnavailability).Format);

    except
      on E: Exception do
    end;
  finally
    FreeAndNil(oIfood);
    FreeAndNil(oUnavailability);
  end;

end;

procedure TFormMain.btnReadyDeliveryClick(Sender: TObject);
var
  oIfood: Tifood;
  bAccepted: Boolean;
begin

  try
    oIfood := Tifood.Create('https://pos-api.ifood.com.br');
    oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
    oIfood.StatusOrder(cdsPollingcorrelationId.AsString , ReadyToDeliver, bAccepted);

    Log(Format('Pedido %s foi %s', [cdsPollingcorrelationId.AsString, ReadyToDeliver]));
  finally
    FreeAndNil(oIfood);
  end;
end;

procedure TFormMain.btnPollingClick(Sender: TObject);
var
  oIfood: Tifood;
  olPolling: TObjectList<TPolling>;
  oPolling: TPolling;
begin
  try
    olPolling := TObjectList<TPolling>.Create;
    oIfood := Tifood.Create('https://pos-api.ifood.com.br');
    oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);

    oIfood.Polling(olPolling);

    cdsPolling.Open;  

    for oPolling in olPolling do
    begin
      cdsPolling.Insert;
      cdsPollingcode.AsString := oPolling.code;
      cdsPollingcorrelationId.AsString := oPolling.correlationId;
      cdsPollingcreatedAt.AsString := oPolling.createdAt;
      cdsPollingid.AsString := oPolling.id;
      cdsPolling.Post;      
    end;



  finally
    FreeAndNil(oIfood);
    FreeAndNil(oPolling);
  end;
end;

end.
