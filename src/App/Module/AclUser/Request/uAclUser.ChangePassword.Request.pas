unit uAclUser.ChangePassword.Request;

interface

uses
  uBase.Request,
  uAclUser,
  uAclUser.ChangePassword.DTO,
  Horse.Request,
  Horse.Response;

type
  IAclUserChangePasswordRequest = interface
    ['{040A0253-7193-4C40-85B0-88981B5B5FA0}']
    function ValidateAndMapToEntity: TAclUserChangePasswordDTO;
  end;

  TAclUserChangePasswordRequest = class(TBaseRequest, IAclUserChangePasswordRequest)
  private
    procedure HandleAttributes; override;
    procedure HandleAclUser;
    Constructor Create(const AReq: THorseRequest; const ARes: THorseResponse);
  public
    class function Make(const AReq: THorseRequest; const ARes: THorseResponse): IAclUserChangePasswordRequest;
    function ValidateAndMapToEntity: TAclUserChangePasswordDTO;
  end;

implementation

uses
  System.SysUtils,
  XSuperObject,
  uRes,
  uApplication.Types,
  uHlp,
  uMyClaims;

{ TAclUserChangePasswordRequest }

procedure TAclUserChangePasswordRequest.HandleAclUser;
begin
  Self
    .AddRule('login',            'required|string|max:100')
    .AddRule('current_password', 'required|string|max:100')
    .AddRule('new_password',     'required|string|max:100')
    .ExecuteRules;
end;

function TAclUserChangePasswordRequest.ValidateAndMapToEntity: TAclUserChangePasswordDTO;
var
  lAclUserPk: Int64;
begin
  Result := Nil;

  // Validar requisição
  if not Validate.IsEmpty then
  begin
    TRes.Error(Res, VALIDATION_ERROR, Errors);
    Exit;
  end;

  // Mapear Body para Entity
  Result := TAclUserChangePasswordDTO.FromJSON(Body);
end;

procedure TAclUserChangePasswordRequest.HandleAttributes;
begin
  HandleAclUser;
end;

class function TAclUserChangePasswordRequest.Make(const AReq: THorseRequest; const ARes: THorseResponse): IAclUserChangePasswordRequest;
begin
  Result := Self.Create(AReq, ARes);
end;

constructor TAclUserChangePasswordRequest.Create(const AReq: THorseRequest; const ARes: THorseResponse);
begin
  inherited Create(AReq, ARes);
end;

end.
