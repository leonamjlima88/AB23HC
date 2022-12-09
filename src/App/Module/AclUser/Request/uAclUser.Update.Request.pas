unit uAclUser.Update.Request;

interface

uses
  uBase.Request,
  uAclUser,
  Horse.Response,
  Horse.Request;

type
  IAclUserUpdateRequest = interface
    ['{78D43670-BD67-48F3-BAB3-6BD91563C672}']
    function ValidateAndMapToEntity: TAclUser;
  end;

  TAclUserUpdateRequest = class(TBaseRequest, IAclUserUpdateRequest)
  private
    procedure HandleAttributes; override;
    procedure HandleAclUser;
    Constructor Create(const AReq: THorseRequest; const ARes: THorseResponse);
  public
    class function Make(const AReq: THorseRequest; const ARes: THorseResponse): IAclUserUpdateRequest;
    function ValidateAndMapToEntity: TAclUser;
  end;

implementation

uses
  System.SysUtils,
  XSuperObject,
  uRes,
  uApplication.Types,
  uHlp,
  uMyClaims;

{ TAclUserUpdateRequest }

procedure TAclUserUpdateRequest.HandleAclUser;
begin
  Self
    .AddRule('name',           'required|string|max:100')
    .AddRule('login',          'required|string|max:100')
    .AddRule('acl_role_id',    'required|integer|min:1')
    .AddRule('is_superuser',   'nullable|integer')
    .ExecuteRules;
end;

function TAclUserUpdateRequest.ValidateAndMapToEntity: TAclUser;
var
  lAclUser: TAclUser;
begin
  Result := Nil;

  // Validar requisição
  if not Validate.IsEmpty then
  begin
    TRes.Error(Res, VALIDATION_ERROR, Errors);
    Exit;
  end;

  // Mapear Body para Entity
  lAclUser := TAclUser.FromJSON(Body);
  Result := lAclUser;
end;

constructor TAclUserUpdateRequest.Create(const AReq: THorseRequest; const ARes: THorseResponse);
begin
  inherited Create(AReq, ARes);
end;

procedure TAclUserUpdateRequest.HandleAttributes;
begin
  HandleAclUser;
end;

class function TAclUserUpdateRequest.Make(const AReq: THorseRequest; const ARes: THorseResponse): IAclUserUpdateRequest;
begin
  Result := Self.Create(AReq, ARes);
end;

end.
