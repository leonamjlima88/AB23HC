unit uAclUser.Store.Request;

interface

uses
  Horse.Request,
  Horse.Response,
  uAclUser;

type
  IAclUserStoreRequest = Interface
    ['{87CEAD93-4034-4B52-AC61-7ADECA1A6E1B}']
    function Validate: String;
    function ValidateAndMapToEntity: TAclUser;
  end;

  TAclUserStoreRequest = class(TInterfacedObject, IAclUserStoreRequest)
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FErrors: String;
    FExitOnError: Boolean;
    function HandleAttributes: IAclUserStoreRequest;
    function Handlebrand: IAclUserStoreRequest;
    constructor Create(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean);
  public
    class function Make(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean = True): IAclUserStoreRequest;
    function Validate: String;
    function ValidateAndMapToEntity: TAclUser;
  end;

implementation

uses
  uFormRequest,
  System.SysUtils,
  uRes,
  uApplication.Types,
  XSuperObject,
  uHlp,
  uMyClaims;

{ TAclUserStoreRequest }

class function TAclUserStoreRequest.Make(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean): IAclUserStoreRequest;
begin
  Result := Self.Create(AReq, ARes, AExitOnError);
end;

constructor TAclUserStoreRequest.Create(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean);
begin
  inherited Create;
  FReq         := AReq;
  FRes         := ARes;
  FExitOnError := AExitOnError;
end;

function TAclUserStoreRequest.HandleAttributes: IAclUserStoreRequest;
begin
  Result := Self;
  Handlebrand;
end;

function TAclUserStoreRequest.Handlebrand: IAclUserStoreRequest;
begin
  Result := Self;

  // Validar Requisição
  FErrors := FErrors + TFormRequest.Make(FReq.Body)
    .AddRule('name',           'required|string|max:100')
    .AddRule('login',          'required|string|max:100')
    .AddRule('login_password', 'required|string|max:100')
    .AddRule('acl_role_id',    'required|integer|min:1')
    .AddRule('is_superuser',   'nullable|integer')
    .Validate;
end;

function TAclUserStoreRequest.Validate: String;
begin
  FErrors := EmptyStr;
  HandleAttributes;

  // Exibir erros de validação se existir
  if FExitOnError and (FErrors.Trim > EmptyStr) then
  begin
    TRes.Error(FRes, VALIDATION_ERROR, FErrors);
    Exit;
  end;
end;

function TAclUserStoreRequest.ValidateAndMapToEntity: TAclUser;
begin
  Result := Nil;
  Validate;
  if FExitOnError and (FErrors.Trim > EmptyStr) then
    Exit;

  // Mapear Body para Entity
  Result := TAclUser.FromJSON(FReq.Body);
end;

end.
