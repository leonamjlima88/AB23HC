unit uAclUser.Update.Request;

interface

uses
  Horse.Request,
  Horse.Response,
  uAclUser;

type
  IAclUserUpdateRequest = Interface
    ['{2A7B4859-6A78-44DA-8761-986152C9A140}']
    function Validate: String;
    function ValidateAndMapToEntity: TAclUser;
  end;

  TAclUserUpdateRequest = class(TInterfacedObject, IAclUserUpdateRequest)
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FErrors: String;
    FExitOnError: Boolean;
    function HandleAttributes: IAclUserUpdateRequest;
    function Handlebrand: IAclUserUpdateRequest;
    constructor Create(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean);
  public
    class function Make(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean = True): IAclUserUpdateRequest;
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

{ TAclUserUpdateRequest }

class function TAclUserUpdateRequest.Make(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean): IAclUserUpdateRequest;
begin
  Result := Self.Create(AReq, ARes, AExitOnError);
end;

constructor TAclUserUpdateRequest.Create(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean);
begin
  inherited Create;
  FReq         := AReq;
  FRes         := ARes;
  FExitOnError := AExitOnError;
end;

function TAclUserUpdateRequest.HandleAttributes: IAclUserUpdateRequest;
begin
  Result := Self;
  Handlebrand;
end;

function TAclUserUpdateRequest.Handlebrand: IAclUserUpdateRequest;
begin
  Result := Self;

  // Validar Requisição
  FErrors := FErrors + TFormRequest.Make(FReq.Body)
    .AddRule('name',           'required|string|max:100')
    .AddRule('login',          'required|string|max:100')
    .AddRule('acl_role_id',    'required|integer|min:1')
    .AddRule('is_superuser',   'nullable|integer')
    .Validate;
end;

function TAclUserUpdateRequest.Validate: String;
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

function TAclUserUpdateRequest.ValidateAndMapToEntity: TAclUser;
begin
  Result := Nil;
  Validate;
  if FExitOnError and (FErrors.Trim > EmptyStr) then
    Exit;

  // Mapear Body para Entity
  Result := TAclUser.FromJSON(FReq.Body);
end;

end.
