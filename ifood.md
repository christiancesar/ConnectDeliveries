<style> 
    .container {
        display:flex;
        align-items: center;        
        border-radius: 5px;
        height: 30px;
        padding: 5px;
        margin: 10px        
    }
    .verb {
        margin: 5px;
        font-weight: 500;
    }
    .endpoint {
        margin: 5px; 
    }
    .get {
        background: MediumSeaGreen;
    }
    .post {
        background: blue;
    }

</style>

# iFood

Na pasta do projeto contém um arquivo `.env.json` contendo uma estrutura com os campos necessarios para cada api. Preencha o de acordo com as credenciais que o time do iFood lhe envio. Abaixo um exemplo de como obter as infomações deste arquivo.

A variavel `FCredentials` neste caso declarei no Form principal de teste onde mantenho vivo durante a aplicação, caso precisar de alguma informação. 

> Resalvo que para questões de testes ser salvo em um arquivo de texto local o acesso é rápido porém menos sguro, seria interessante ao desenvolver a aplicação para produção essas variaveis serem colocadas para o banco de dados.

```pascal
var
sEnv := TStringStream.Create;
  try
    sPath := ExtractFilePath(Application.ExeName);
    sEnv.LoadFromFile(sPath + '\.env.json');

    { Convertendo o .env e procurando as credenciais }
    joJson := TJSONObject.ParseJSONValue(sEnv.DataString) as TJSONObject;
    jvJson := joJson.FindValue('credenciais.ifood.homologacao');
    FCredential := TCredential.Create;
    FCredential := TJson.JsonToObject<TCredential>(jvJson as TJSONObject);
  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
```

# End points
> Nessa seção conterá uma breve explicação das rotas, sequencias e suas usabilidades, recomendo que leia a [documentação do ifood](https://developer.ifood.com.br/reference#oauthtoken) atentamente.

## Autenticação
Primeira etapa a ser feita é fazer requisição no endpoint `oauth/token` onde será retornado um token que será usado em todas as outras rotas.
<div class="container post"> 
    <p class="verb">POST</p>
    <p class="endpoint"> | https://pos-api.ifood.com.br/oauth/token <p>
</div>

Use a função `Authentication` passando como parametro um objeto com as credenciais.


```pascal
function TiFood.Authentication(const ACredential: TCredential;
  out OAuthentication: TAuthentication): TReturnMessage;
begin

  if not Assigned(ACredential) then
    raise Exception.Create('Credencial fazia!');

  FRequest.Method := rmPOST;
  FRequest.Resource := '/oauth/token';
  FRequest.AddParameter('client_id', ACredential.client_id);
  FRequest.AddParameter('client_secret', ACredential.client_secret);
  FRequest.AddParameter('grant_type', ACredential.grant_type);
  FRequest.AddParameter('username', ACredential.username);
  FRequest.AddParameter('password', ACredential.password);
  FRequest.Execute;

  if Assigned(OAuthentication) then
    OAuthentication.CleanupInstance;

  if FResponse.Status.Success then
  begin
    OAuthentication := TJson.JsonToObject<TAuthentication>
      (FResponse.JSONValue as TJSONObject);
  end;

  Result := ReturnMessageObject;

end;
```

## Polling
Envie um `ObjectList<TPolling>` como parametro para a função, caso for bem sucessidida a requisição e tiver pedidos novos, o objeto retornará preenchido com os atendimento.

`Status Code 404: Significa que não contém novos pedidos`

<div class="container get"> 
    <p class="verb">GET</p>
    <p class="endpoint"> | https://pos-api.ifood.com.br/v3.0/events:polling <p>
</div>

```pascal
function TiFood.Polling(out APolling: TObjectList<TPolling>): TReturnMessage;
var
  I: Integer;
begin
  FRequest.Method := rmGET;
  FRequest.Resource := '/v3.0/events:polling';

  FRequest.Execute;
  FRequest.Params.Clear;

  if FResponse.Status.Success then
  begin

    for I := 0 to (FResponse.JSONValue as TJSONArray).Count - 1 do
    begin
      APolling.Add(TJson.JsonToObject<TPolling>
        (((FResponse.JSONValue as TJSONArray).Items[I] as TJSONObject)));
    end;
    Result := ReturnMessageObject;
  end
  else if FResponse.StatusCode = 404 then
  begin
    Result := ReturnMessageObject;
    Abort;
  end;
end;
```

## Detalhe do pedido