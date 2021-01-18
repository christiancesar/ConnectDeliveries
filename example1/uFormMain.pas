unit uFormMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, FMX.Types, FMX.Controls, FMX.Graphics,
  FMX.Dialogs, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Layouts,
  FMX.ExtCtrls, FMX.MultiView, System.ImageList, FMX.ImgList, FMX.TabControl,
  FMX.Objects, FMX.Edit, REST.Types, REST.Client, uIfood.Credential, uIfood,
  uIfood.Authentication, uIfood.Merchant, uIfood.Unavailability,
  uIfood.Availability, uIfood.Polling, Datasnap.DBClient, uIfood.OrderDetail,
  System.JSON, REST.JSON, FMX.Forms, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.Menus, FMX.ListView,
  uReturnMessage, FMX.ComboEdit, System.Generics.Collections, FMX.ScrollBox,
  FMX.Memo;

type
  TFormMain = class(TForm)
    lHeader: TLayout;
    lblRestaurantName: TLabel;
    lPolling: TLayout;
    sStatus: TSwitch;
    ImageList: TImageList;
    Layout4: TLayout;
    lMenuLeft: TLayout;
    MultiView1: TMultiView;
    bntSettings: TSpeedButton;
    tcInitial: TTabControl;
    tiHome: TTabItem;
    tiSettings: TTabItem;
    btnHome: TSpeedButton;
    Image1: TImage;
    StyleBook1: TStyleBook;
    btnOrders: TSpeedButton;
    tiOrders: TTabItem;
    Layout7: TLayout;
    Layout8: TLayout;
    TabControl1: TTabControl;
    OrdersList: TTabItem;
    OrderDetail: TTabItem;
    ListView1: TListView;
    ppStatusOrder: TPopupMenu;
    miConfirmation: TMenuItem;
    miDispatch: TMenuItem;
    miReadyToDeliver: TMenuItem;
    miCancellation: TMenuItem;
    miCancellationRequested: TMenuItem;
    CancellationAccepted: TMenuItem;
    miCancellationDenied: TMenuItem;
    tPolling: TTimer;
    VertScrollBox1: TVertScrollBox;
    lAuthentication: TLayout;
    edtLogin: TEdit;
    ClearEditButton2: TClearEditButton;
    edtPassword: TEdit;
    ClearEditButton1: TClearEditButton;
    lLogin: TLayout;
    btnLogin: TSpeedButton;
    lblAuth: TLabel;
    lblLogin: TLabel;
    lblPassword: TLabel;
    lMerchantAvailability: TLayout;
    lblMerchantAvailability: TLabel;
    lMerchants: TLayout;
    lblMerchants: TLabel;
    ceMerchants: TComboEdit;
    lblUnavailabilities: TLabel;
    lDeleteUnavailability: TLayout;
    btnDelete: TSpeedButton;
    ceUnavailabilities: TComboEdit;
    lCreateUnavailability: TLayout;
    btn: TSpeedButton;
    edtDescriptionUnavailability: TEdit;
    edtMinutesUnavailability: TEdit;
    lblCreateUnavailability: TLabel;
    mMerchantAvailability: TMemo;
    lblPolling: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure sStatusClick(Sender: TObject);
    procedure btnHomeClick(Sender: TObject);
    procedure bntSettingsClick(Sender: TObject);
    procedure btnOrdersClick(Sender: TObject);
    procedure sStatusExit(Sender: TObject);
    procedure tPollingTimer(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    FCredential: TCredential;
    FAuth: TAuthentication;
    FMerchants: TObjectList<TMerchant>;
    FUnavailabilities: TObjectList<TUnavailability>;
    FMerchantAvailability: TObjectList<TAvailability>;

    FTimeExp: TDateTime;
    FToken: String;
    FRestaurantStatus: Boolean;

    procedure ErrorMessage(AErrorMessage: String);
    procedure SetLogin;
    procedure Login;
    procedure ChangeStatusRestaurant(AEnable: Boolean);

    function Authentication: Boolean;
    function Polling: Boolean;
    function Merchants: Boolean;
    procedure FillMerchants;
    function GetUnavailabilities: Boolean;
    procedure FillUnavailability;
    function MerchantAvailability: Boolean;
    procedure FillMerchantAvailability;
    function DeleteUnavailability: Boolean;
    function CreateUnavailability(ADescription: String;
      AMinute: Integer): Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

uses
  System.DateUtils, REST.HttpClient, System.Net.HttpClient;

{$R *.fmx}

function TFormMain.Authentication: Boolean;
var
  oIfood: Tifood;
  oReturnMessage: TReturnMessage;
begin
  Result := False;
  { Caso o token não tenha expirado, não será requisitado outro token.
    Requisitar Tokens de mais, causa restrições a loja. }
  if not(FTimeExp < Now) then
  begin
    Result := True;
    Exit;
  end;

  try
    try
      oIfood := Tifood.Create(FCredential.baseURL);
      oReturnMessage := oIfood.Authentication(FCredential, FAuth);
      if oReturnMessage.success then
      begin
        FTimeExp := IncSecond(Now, FAuth.expires_in);
        FToken := FAuth.access_token;
        Result := True;
      end;
    except
      on E: EHTTPProtocolException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.ErrorCode, E.Message]));
      on E: ENetHTTPClientException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.Message]));
    end;

  finally
    oIfood.Free;
  end;
end;

procedure TFormMain.bntSettingsClick(Sender: TObject);
begin
  tcInitial.ActiveTab := tiSettings;
end;

procedure TFormMain.FillMerchantAvailability;
var
  oMerchantAvailability: TAvailability;
begin
  for oMerchantAvailability in FMerchantAvailability do
  begin
    mMerchantAvailability.Lines.Add
      ((TJson.ObjectToJsonObject(oMerchantAvailability) as TJsonObject).Format);
  end;

end;

procedure TFormMain.FillMerchants;
var
  oMerchant: TMerchant;
begin
  ceMerchants.Clear;
  for oMerchant in FMerchants do
  begin
    ceMerchants.Items.Add(oMerchant.name);
  end;

  { Caso tiver um restaurante seta para o primeiro }
  if ceMerchants.Items.Count >= 0 then
    ceMerchants.ItemIndex := 0;

end;

procedure TFormMain.FillUnavailability;
var
  oUnavailability: TUnavailability;
begin
  if not(FUnavailabilities.Count > 0) then
    ceUnavailabilities.Text := 'Não foram encontradas indisponibilidades.'
  else
  begin
    ceUnavailabilities.Clear;
    for oUnavailability in FUnavailabilities do
    begin
      ceUnavailabilities.Items.Add(oUnavailability.description);
    end;
  end;

end;

procedure TFormMain.FormCreate(Sender: TObject);
var
  sEnv: TStringStream;
  sPath: String;
  joJson: TJsonObject;
  jvJson: TJsonValue;
begin

  try
    tcInitial.TabPosition := TTabPosition.None;
    tcInitial.ActiveTab := tiHome;
    sEnv := TStringStream.Create;
    joJson := TJsonObject.Create;
    try
      sPath := ExtractFilePath(System.SysUtils.GetCurrentDir);
      sEnv.LoadFromFile(sPath + '.env.json');

      { Convertendo o .env e procurando as credenciais de homologacao }
      joJson := TJsonObject.ParseJSONValue(sEnv.DataString) as TJsonObject;
      jvJson := joJson.FindValue('credenciais.ifood.homologacao');
      FCredential := TCredential.Create;
      FCredential := TJson.JsonToObject<TCredential>(jvJson as TJsonObject);

      FAuth := TAuthentication.Create;
      FMerchants := TObjectList<TMerchant>.Create;
      FUnavailabilities := TObjectList<TUnavailability>.Create;
      FMerchantAvailability := TObjectList<TAvailability>.Create;

      SetLogin;
      FTimeExp := Now;
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
  FAuth.Free;
  FCredential.Free;
  FUnavailabilities.Free;
  FMerchantAvailability.Free;
end;

function TFormMain.MerchantAvailability: Boolean;
var
  oIfood: Tifood;
begin
  oIfood := Tifood.Create('https://pos-api.ifood.com.br');
  try
    try
      oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
      if oIfood.MerchantAvailability(FMerchants.Items[ceMerchants.ItemIndex].id,
        FMerchantAvailability).success then
        FillMerchantAvailability;

    except
      on E: EHTTPProtocolException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.ErrorCode, E.Message]));
      on E: ENetHTTPClientException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.Message]));
    end;
  finally
    FreeAndNil(oIfood);
  end;
end;

function TFormMain.Merchants: Boolean;
var
  oIfood: Tifood;
  name: String;
begin
  Result := False;
  oIfood := Tifood.Create('https://pos-api.ifood.com.br');
  try
    try
      oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
      Result := oIfood.Merchants(FMerchants).success;
    except
      on E: EHTTPProtocolException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.ErrorCode, E.Message]));
      on E: ENetHTTPClientException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.Message]));
    end;
  finally
    oIfood.Free
  end;
end;

function TFormMain.Polling: Boolean;
var
  oIfood: Tifood;
  oReturnMessage: TReturnMessage;
  { por algum motivo o delphi não compilou
    olPollings: TObjectList<TPolling>
  }
  olPollings: TObjectList<uIfood.Polling.tPolling>;
begin
  Result := False;

  olPollings := TObjectList<uIfood.Polling.tPolling>.Create;
  oIfood := Tifood.Create(FCredential.baseURL);
  try
    try
      oReturnMessage := oIfood.Polling(olPollings);
      if oReturnMessage.success then
      begin
        { Lista a lista de Pollings }
        Result := True;
      end;
    except
      on E: EHTTPProtocolException do
      begin
        if E.ErrorCode = 404 then
          Abort
        else
          ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
            [E.ClassName, E.ErrorCode, E.Message]));
      end;
      on E: ENetHTTPClientException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.Message]));
    end;
  finally
    olPollings.Free;
    oIfood.Free;
  end;

end;

procedure TFormMain.SetLogin;
begin
  edtLogin.Text := FCredential.username;
  edtPassword.Text := FCredential.password;
  Login;
end;

procedure TFormMain.btnClick(Sender: TObject);
begin
  if edtDescriptionUnavailability.Text.IsEmpty then
    raise Exception.Create('Description cannot be empty!');
  if StrToIntDef(edtMinutesUnavailability.Text, 0) = 0 then
    raise Exception.Create('Minutes cannot equal 0!');

  CreateUnavailability(edtDescriptionUnavailability.Text,
    StrToIntDef(edtMinutesUnavailability.Text, 0));

end;

procedure TFormMain.btnDeleteClick(Sender: TObject);
begin
  if ceUnavailabilities.ItemIndex < 0 then
    Exit
  else
  begin
    DeleteUnavailability;
  end;
end;

procedure TFormMain.btnHomeClick(Sender: TObject);
begin
  tcInitial.ActiveTab := tiHome;
end;

procedure TFormMain.btnLoginClick(Sender: TObject);
begin
  Login;
end;

procedure TFormMain.btnOrdersClick(Sender: TObject);
begin
  tcInitial.ActiveTab := tiOrders;
end;

procedure TFormMain.ChangeStatusRestaurant(AEnable: Boolean);
begin
  sStatus.IsChecked := AEnable;
end;

function TFormMain.CreateUnavailability(ADescription: String;
  AMinute: Integer): Boolean;
begin

end;

function TFormMain.DeleteUnavailability: Boolean;
var
  oIfood: Tifood;
begin
  Result := False;
  oIfood := Tifood.Create('https://pos-api.ifood.com.br');
  try
    try
      oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
      Result := oIfood.Unavailabilities(FMerchants.Items[ceMerchants.ItemIndex]
        .id, FUnavailabilities.Items[ceUnavailabilities.ItemIndex].id).success;
    except
      on E: EHTTPProtocolException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.ErrorCode, E.Message]));
      on E: ENetHTTPClientException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.Message]));
    end;
  finally
    oIfood.Free;
  end;

end;

procedure TFormMain.ErrorMessage(AErrorMessage: String);
begin
  ShowMessage(AErrorMessage);
end;

procedure TFormMain.sStatusClick(Sender: TObject);
begin
  FRestaurantStatus := Authentication;
end;

procedure TFormMain.sStatusExit(Sender: TObject);
begin
  sStatus.IsChecked := FRestaurantStatus;
  tPolling.Enabled := sStatus.IsChecked;
end;

procedure TFormMain.tPollingTimer(Sender: TObject);
var
  bEnable: Boolean;
begin
  bEnable := tPolling.Enabled;
  try
    try
      bEnable := Authentication;
      if bEnable then
      begin
        bEnable := Polling;
      end;

      { Caso ocorrer algum erro muda o status do restaurante para off.
        O Polling para de ser feito. }
      if not bEnable then
        ChangeStatusRestaurant(bEnable);

    except
      on E: EHTTPProtocolException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.ErrorCode, E.Message]));
      on E: ENetHTTPClientException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.Message]));
    end;
  finally
    tPolling.Enabled := bEnable;
  end;
end;

function TFormMain.GetUnavailabilities: Boolean;
var
  oIfood: Tifood;
begin
  Result := False;
  oIfood := Tifood.Create('https://pos-api.ifood.com.br');
  try
    try
      oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
      Result := oIfood.Unavailabilities(FMerchants.Items[ceMerchants.ItemIndex]
        .id, FUnavailabilities).success;
    except
      on E: EHTTPProtocolException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.ErrorCode, E.Message]));
      on E: ENetHTTPClientException do
        ErrorMessage(Format('ClassName: %s | Code: %d | Message: %s',
          [E.ClassName, E.Message]));
    end;
  finally
    oIfood.Free;
  end;

end;

procedure TFormMain.Login;
begin
  if Authentication then
  begin
    // ShowMessage('Authenticated!');
    if Merchants then
    begin
      FillMerchants;
      if GetUnavailabilities then
        FillUnavailability;
      if MerchantAvailability then
        FillMerchantAvailability
    end;
  end;
end;

end.
