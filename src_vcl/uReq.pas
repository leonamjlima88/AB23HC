unit uReq;

interface

uses
  RESTRequest4D,
  System.SysUtils,
  System.JSON,
  System.Classes;


type
  {$REGION 'Response and Interfaces'}
  TReqType = (rtGet, rtPost, rtPut, rtDelete, rtPatch);

  IRes = interface
    ['{B3D84739-10E8-413A-9668-568C05194FFD}']
    function Content: string;
    function ContentLength: Cardinal;
    function ContentType: string;
    function ContentEncoding: string;
    function ContentStream: TStream;
    function StatusCode: Integer;
    function StatusText: string;
    function RawBytes: TBytes;
    function JSONValue: TJSONValue;
    function Headers: TStrings;
  end;

  TRes = class(TInterfacedObject, IRes)
  private
    FResponse: IResponse;
    constructor Create(AResponse: IResponse);
  public
    class function Make(AResponse: IResponse): IRes;
    function Content: string;
    function ContentLength: Cardinal;
    function ContentType: string;
    function ContentEncoding: string;
    function ContentStream: TStream;
    function StatusCode: Integer;
    function StatusText: string;
    function RawBytes: TBytes;
    function JSONValue: TJSONValue;
    function Headers: TStrings;
  end;

  IReq = Interface
    ['{50C68531-0FE0-4960-8A31-B6C4C00A9C0A}']
    function Execute(AReqType: TReqType): IRes;
  end;
  {$ENDREGION}

  TReq = class(TInterfacedObject, IReq)
  private
    FRequest: IRequest;
    constructor Create(AEndPoint, ABody: String);
  public
    class function Make(AEndPoint: String; ABody: String = ''): IReq;
    function Execute(AReqType: TReqType): IRes;
  end;

implementation

uses
  uEnv,
  uUserLogged,
  XSuperObject,
  uAclUser;

{ TReq }

constructor TReq.Create(AEndPoint, ABody: String);
var
  lURI: String;
begin
  inherited Create;

  // Evitar erro de URI
  lURI := ENV.APP_BASE_URI;
  if not AEndPoint.Trim.IsEmpty then
  begin
    if (Copy(lURI, lURI.Length, 1) = '/') then lURI      := Copy(lURI, 1, lURI.Length-1);
    if (Copy(AEndPoint, 1, 1) = '/')      then AEndPoint := Copy(AEndPoint, 2, AEndPoint.Length);
    lURI := lURI + '/' + AEndPoint;
  end;

  // Configuração Default
  FRequest  := TRequest.New.BaseURL(lURI)
    .TokenBearer (UserLogged.Current.last_token)
    .Accept      ('application/json')
    .AddHeader   ('Content-Type', 'application/json')
    .AddHeader   ('Accept',       'application/json');

  // Body
  if not ABody.Trim.IsEmpty then
    FRequest.AddBody(ABody);
end;

function TReq.Execute(AReqType: TReqType): IRes;
const
  LBODY = '{"login":"%s","login_password":"%s"}';
var
  lTokenIsExpired: Boolean;
  lLoginResponse: IResponse;
  lAclUser: TAclUser;
  lResponse: IResponse;
  lLastExpiration: TDateTime;
begin
  // Gerar novo token se tiver sido expirado
  lLastExpiration := UserLogged.Current.last_expiration;
  lTokenIsExpired := Now > lLastExpiration;
  if lTokenIsExpired then
  begin
    // Efetuar Requisição de login
    lLoginResponse := TRequest.New.BaseURL(ENV.APP_BASE_URI + '/auth/login')
      .AddHeader ('Content-Type', 'application/json')
      .AddHeader ('Accept', 'application/json')
      .Accept    ('application/json')
      .AddBody   (Format(LBODY, [UserLogged.Current.login, UserLogged.Current.login_password]))
    .Post;
    if not (lLoginResponse.StatusCode = 200) then
      raise Exception.Create('Tentativa de login falhou!' + #13 + SO(lLoginResponse.Content).S['message']);

    // Carregar dados do usuário com novo token
    lAclUser := TAclUser.FromJSON(SO(lLoginResponse.Content).O['data']);
    lAclUser.login_password := UserLogged.Current.login_password;
    UserLogged.Current(lAclUser);

    // Trocar token do Request
    FRequest.TokenBearer(UserLogged.Current.last_token);
  end;

  // Efetuar Requisição
  case AReqType of
    rtGet:    lResponse := FRequest.Get;
    rtPost:   lResponse := FRequest.Post;
    rtPut:    lResponse := FRequest.Put;
    rtDelete: lResponse := FRequest.Delete;
    rtPatch:  lResponse := FRequest.Patch;
  end;
  Result := TRes.Make(lResponse);
end;

class function TReq.Make(AEndPoint, ABody: String): IReq;
begin
  Result := Self.Create(AEndPoint, ABody);
end;




{ TRes }
function TRes.Content: string;
begin
  Result := FResponse.Content;
end;

function TRes.ContentEncoding: string;
begin
  Result := FResponse.ContentEncoding;
end;

function TRes.ContentLength: Cardinal;
begin
  Result := FResponse.ContentLength;
end;

function TRes.ContentStream: TStream;
begin
  Result := FResponse.ContentStream;
end;

function TRes.ContentType: string;
begin
  Result := FResponse.ContentType;
end;

constructor TRes.Create(AResponse: IResponse);
begin
  inherited Create;
  FResponse := AResponse;
end;

function TRes.Headers: TStrings;
begin
  Result := FResponse.Headers;
end;

function TRes.JSONValue: TJSONValue;
begin
  Result := FResponse.JSONValue;
end;

class function TRes.Make(AResponse: IResponse): IRes;
begin
  Result := Self.Create(AResponse);
end;

function TRes.RawBytes: TBytes;
begin
  Result := FResponse.RawBytes;
end;

function TRes.StatusCode: Integer;
begin
  Result := FResponse.StatusCode;
end;

function TRes.StatusText: string;
begin
  Result := FResponse.StatusText;
end;

end.
