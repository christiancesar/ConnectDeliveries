unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Imaging.pngimage, System.Actions,
  Vcl.ActnList, REST.Types, Vcl.Buttons, REST.Client, uIfood.Credential,
  Vcl.ComCtrls, Vcl.WinXCtrls, Vcl.WinXPanels, System.Generics.Collections,
  uIfood, uIfood.Authentication, uIfood.Merchant, uIfood.Unavailability;

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
    Panel1: TPanel;
    cbRestaurant: TComboBox;
    SpeedButton1: TSpeedButton;
    procedure FormCreate(Sender: TObject);

    procedure CloseButtonClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnGetTokenClick(Sender: TObject);
    procedure btnMerchantsClick(Sender: TObject);
    procedure btnGetUnavailabilitiesClick(Sender: TObject);
  private
    FCredential: TCredential;
    FMerchants: TObjectList<TMerchant>;
    FAuth: TAuthentication;
    FUnavailabilities: TObjectList<TUnavailability>;

    procedure Log(AString: String);
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
  sEnv := TStringStream.Create;
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
end;

procedure TFormMain.Log(AString: String);
begin
  Memo1.Lines.Add(AString);
  Memo1.Lines.Add('');
end;

procedure TFormMain.btnGetTokenClick(Sender: TObject);
var
  oIfood: Tifood;
begin
  try
    try
      oIfood := Tifood.Create(FCredential.baseURL,
        CONTENTTYPE_MULTIPART_FORM_DATA);

      Log(oIfood.Authentication(FCredential, FAuth).Format);
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
      oIfood := Tifood.Create('https://pos-api.ifood.com.br',
        CONTENTTYPE_APPLICATION_JSON);
      oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
      log(oIfood.Unavailabilities
        (FMerchants.Items[cbRestaurant.ItemIndex].id, FUnavailabilities).Format);
      if Assigned(FUnavailabilities) then
        Log('Não foram encontradas indisponibilidades.');

    except
      on E: Exception do
    end;
  finally
    FreeAndNil(oIfood);
  end;

end;

procedure TFormMain.btnClearClick(Sender: TObject);
begin
  Memo1.Lines.Clear;
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
      oIfood := Tifood.Create('https://pos-api.ifood.com.br',
        CONTENTTYPE_APPLICATION_JSON);
      oIfood.addHeader('Authorization', 'Bearer ' + FAuth.access_token);
      Log(oIfood.Merchants(FMerchants).Format);
      for oMerchant in FMerchants do
      begin
        cbRestaurant.Items.Add(oMerchant.name);
      end;

      Log(Format
        ('Foram encontrados %d restaurante(s) cadastrados com essas credenciais!',
        [FMerchants.Count]));
    except
      on E: Exception do
    end;
  finally
    FreeAndNil(oIfood);
    // FreeAndNil(oMerchant);
  end;
end;

end.
