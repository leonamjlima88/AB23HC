unit uAclUser.ChangePassword.Request;

interface

uses
  Horse.Request,
  Horse.Response,
  uAclUser.ChangePassword.DTO;

type
  IAclUserChangePasswordRequest = Interface
    ['{FAD130CF-00A2-4DBB-A0DC-4E906EE0FB18}']
    function Validate: String;
    function ValidateAndMapToEntity: TAclUserChangePasswordDTO;
  end;

  TAclUserChangePasswordRequest = class(TInterfacedObject, IAclUserChangePasswordRequest)
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FErrors: String;
    FExitOnError: Boolean;
    function HandleAttributes: IAclUserChangePasswordRequest;
    function Handlebrand: IAclUserChangePasswordRequest;
    constructor Create(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean);
  public
    class function Make(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean = True): IAclUserChangePasswordRequest;
    function Validate: String;
    function ValidateAndMapToEntity: TAclUserChangePasswordDTO;
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

{ TAclUserChangePasswordRequest }

class function TAclUserChangePasswordRequest.Make(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean): IAclUserChangePasswordRequest;
begin
  Result := Self.Create(AReq, ARes, AExitOnError);
end;

constructor TAclUserChangePasswordRequest.Create(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean);
begin
  inherited Create;
  FReq         := AReq;
  FRes         := ARes;
  FExitOnError := AExitOnError;
end;

function TAclUserChangePasswordRequest.HandleAttributes: IAclUserChangePasswordRequest;
begin
  Result := Self;
  Handlebrand;
end;

function TAclUserChangePasswordRequest.Handlebrand: IAclUserChangePasswordRequest;
begin
  Result := Self;

  // Validar Requisição
  FErrors := FErrors + TFormRequest.Make(FReq.Body)
    .AddRule('login',            'required|string|max:100')
    .AddRule('current_password', 'required|string|max:100')
    .AddRule('new_password',     'required|string|max:100')
    .Validate;
end;

function TAclUserChangePasswordRequest.Validate: String;
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

function TAclUserChangePasswordRequest.ValidateAndMapToEntity: TAclUserChangePasswordDTO;
begin
  Result := Nil;
  Validate;
  if FExitOnError and (FErrors.Trim > EmptyStr) then
    Exit;

  // Mapear Body para Entity
  Result := TAclUserChangePasswordDTO.FromJSON(FReq.Body);
end;

end.
