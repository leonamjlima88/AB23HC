unit uAclUser.Store.Request;

interface

uses
  uBase.Request,
  uAclUser,
  Horse.Response,
  Horse.Request;

type
  IAclUserStoreRequest = interface
    ['{772C8728-C2A2-4E5D-81D6-25ED802810C7}']
    function ValidateAndMapToEntity: TAclUser;
  end;

  TAclUserStoreRequest = class(TBaseRequest, IAclUserStoreRequest)
  private
    procedure HandleAttributes; override;
    procedure HandleAclUser;
    Constructor Create(const AReq: THorseRequest; const ARes: THorseResponse);
  public
    class function Make(const AReq: THorseRequest; const ARes: THorseResponse): IAclUserStoreRequest;
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

{ TAclUserStoreRequest }

procedure TAclUserStoreRequest.HandleAclUser;
begin
  Self
    .AddRule('name',           'required|string|max:100')
    .AddRule('login',          'required|string|max:100')
    .AddRule('login_password', 'required|string|max:100')
    .AddRule('acl_role_id',    'required|integer|min:1')
    .AddRule('is_superuser',   'nullable|integer')
    .ExecuteRules;
end;

function TAclUserStoreRequest.ValidateAndMapToEntity: TAclUser;
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

constructor TAclUserStoreRequest.Create(const AReq: THorseRequest; const ARes: THorseResponse);
begin
  inherited Create(AReq, ARes);
end;

procedure TAclUserStoreRequest.HandleAttributes;
begin
  HandleAclUser;
end;

class function TAclUserStoreRequest.Make(const AReq: THorseRequest; const ARes: THorseResponse): IAclUserStoreRequest;
begin
  Result := Self.Create(AReq, ARes);
end;

end.
