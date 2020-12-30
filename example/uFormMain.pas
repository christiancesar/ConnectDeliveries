unit uFormMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, System.Actions, Vcl.ActnList, Vcl.Touch.GestureMgr,
  REST.Types, Vcl.Buttons, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Authenticator.OAuth, uIfood.Credential;

type
  TFormMain = class(TForm)
    AppBar: TPanel;
    CloseButton: TImage;
    ActionList1: TActionList;
    Action1: TAction;
    GestureManager1: TGestureManager;
    rRequest: TRESTRequest;
    rClient: TRESTClient;
    Memo1: TMemo;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    rResponse: TRESTResponse;
    SpeedButton3: TSpeedButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FToken: String;
    FCredential: TCredential;

    { Private declarations }
  public
    { Public declarations }
  end;


var
  FormMain: TFormMain;

implementation
uses
  System.JSON, REST.Json, uIfood;

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
  sPath := ExtractFilePath(Application.ExeName);
  sEnv := TStringStream.Create;
  sEnv.LoadFromFile(sPath + '\.env.json');

  {Convertendo o .env e procurando as credenciais de homologacao}
  joJson := TJSONObject.ParseJSONValue(sEnv.DataString) as TJSONObject;
  jvJson := joJson.FindValue('credenciais.ifood.homologacao');
  FCredential := TCredential.Create;
  FCredential := TJson.JsonToObject<TCredential>(jvJson as TJSONObject);
end;

procedure TFormMain.SpeedButton1Click(Sender: TObject);
var
  jvJson: TJSONValue;
  oIfood: Tifood;
begin

  oIfood.Create('https://pos-api.ifood.com.br');
  oIfood.Authentication(FCredential);



//  rClient.BaseURL := 'https://pos-api.ifood.com.br';
//  rClient.Accept := 'application/json';
//  rClient.AcceptCharset := 'utf-8';
//  rClient.ContentType :=  CONTENTTYPE_MULTIPART_FORM_DATA;
//
//  rRequest.Method := rmPOST;
//  rRequest.Resource := '/oauth/token';
//  rRequest.AddParameter('client_id', FCredential.Fclient_id);
//  rRequest.AddParameter('client_secret', FCredential.client_secret);
//  rRequest.AddParameter('grant_type', FCredential.grant_type);
//  rRequest.AddParameter('username', FCredential.username);
//  rRequest.AddParameter('password', FCredential.password);
//  rRequest.Execute;
//
//  Memo1.Lines.Add(format('Code: %s %s Message: %s', [rResponse.StatusCode.ToString, rResponse.StatusText, rResponse.JSONText]));
//  jvJson := rResponse.JSONValue;

  {Exemplo de buscando um valor dentro de um objetoJson}
//  FToken := jvJson.GetValue<string>('access_token','');

  {Exemplo de parse de Json para Objeto Delphi}
//  oAuth := TAuth.Create;
//  oAuth := TJson.JsonToObject<TAuth>(rResponse.JSONValue as TJSONObject);



end;

procedure TFormMain.SpeedButton2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
end;

procedure TFormMain.SpeedButton3Click(Sender: TObject);
begin
//  rRequest.Params.Clear;
    rRequest.Method := rmGET;
    rRequest.Resource := '/v1.0/merchants';
    rRequest.Params.AddHeader('Authorization', 'Bearer ' + FToken);
    rRequest.Params.ParameterByName('Authorization').Options := [poDoNotEncode];
    rRequest.Execute;
    Memo1.Lines.Add(format('Code: %s %s Message: %s', [rResponse.StatusCode.ToString, rResponse.StatusText, rResponse.JSONText]));
end;

end.
