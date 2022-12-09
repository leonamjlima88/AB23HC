unit uAclRole.Request;

interface

uses
  uBase.Request,
  uAclRole,
  Horse.Response,
  Horse.Request;

type
  IAclRoleRequest = interface
    ['{3DEA66F3-080A-4386-A202-AE6FDF63AD9B}']
    function ValidateAndMapToEntity: TAclRole;
  end;

  TAclRoleRequest = class(TBaseRequest, IAclRoleRequest)
  private
    procedure HandleAttributes; override;
    procedure HandleAclRole;
    Constructor Create(const AReq: THorseRequest; const ARes: THorseResponse);
  public
    class function Make(const AReq: THorseRequest; const ARes: THorseResponse): IAclRoleRequest;
    function ValidateAndMapToEntity: TAclRole;
  end;

implementation

uses
  System.SysUtils,
  XSuperObject,
  uRes,
  uApplication.Types,
  uHlp,
  uMyClaims;

{ TAclRoleRequest }

procedure TAclRoleRequest.HandleAclRole;
begin
  Self
    .AddRule('name', 'required|string|max:100')
    .ExecuteRules;
end;

function TAclRoleRequest.ValidateAndMapToEntity: TAclRole;
var
  lAclRole: TAclRole;
begin
  Result := Nil;

  // Validar requisição
  if not Validate.IsEmpty then
  begin
    TRes.Error(Res, VALIDATION_ERROR, Errors);
    Exit;
  end;

  // Mapear Body para Entity
  lAclRole := TAclRole.FromJSON(Body);
  Result := lAclRole;
end;

constructor TAclRoleRequest.Create(const AReq: THorseRequest; const ARes: THorseResponse);
begin
  inherited Create(AReq, ARes);
end;

procedure TAclRoleRequest.HandleAttributes;
begin
  HandleAclRole;
end;

class function TAclRoleRequest.Make(const AReq: THorseRequest; const ARes: THorseResponse): IAclRoleRequest;
begin
  Result := Self.Create(AReq, ARes);
end;

end.
