unit uAclRole.Request;

interface

uses
  Horse.Request,
  Horse.Response,
  uAclRole;

type
  IAclRoleRequest = Interface
    ['{C05C2347-3044-49F4-94EE-8008C36C2156}']
    function Validate: String;
    function ValidateAndMapToEntity: TAclRole;
  end;

  TAclRoleRequest = class(TInterfacedObject, IAclRoleRequest)
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FErrors: String;
    FExitOnError: Boolean;
    function HandleAttributes: IAclRoleRequest;
    function Handlebrand: IAclRoleRequest;
    constructor Create(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean);
  public
    class function Make(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean = True): IAclRoleRequest;
    function Validate: String;
    function ValidateAndMapToEntity: TAclRole;
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

{ TAclRoleRequest }

class function TAclRoleRequest.Make(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean): IAclRoleRequest;
begin
  Result := Self.Create(AReq, ARes, AExitOnError);
end;

constructor TAclRoleRequest.Create(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean);
begin
  inherited Create;
  FReq         := AReq;
  FRes         := ARes;
  FExitOnError := AExitOnError;
end;

function TAclRoleRequest.HandleAttributes: IAclRoleRequest;
begin
  Result := Self;
  Handlebrand;
end;

function TAclRoleRequest.Handlebrand: IAclRoleRequest;
begin
  Result := Self;

  // Validar Requisição
  FErrors := FErrors + TFormRequest.Make(FReq.Body)
    .AddRule('name', 'required|string|max:100')
    .Validate;
end;

function TAclRoleRequest.Validate: String;
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

function TAclRoleRequest.ValidateAndMapToEntity: TAclRole;
begin
  Result := Nil;
  Validate;
  if FExitOnError and (FErrors.Trim > EmptyStr) then
    Exit;

  // Mapear Body para Entity
  Result := TAclRole.FromJSON(FReq.Body);
end;

end.
