unit uAclUser.Resource;

interface

uses
  uAclUser,
  XSuperObject,
  System.TypInfo;

type
  IAclUserResource = Interface
    ['{CA9FC614-BA3B-4F45-B55C-C44B24D53D9C}']
    function Execute: ISuperObject;
  end;

  TAclUserResource = class(TInterfacedObject, IAclUserResource)
  private
    FSObj: ISuperObject;
    FAclUser: TAclUser;
    constructor Create(AAclUser: TAclUser);
    function HandleAttributes: IAclUserResource;
    function HandleAclUser: IAclUserResource;
  public
    class function Make(AAclUser: TAclUser): IAclUserResource;
    function Execute: ISuperObject;
  end;

implementation

uses
  System.Classes,
  System.SysUtils;

{ TAclUserResource }

constructor TAclUserResource.Create(AAclUser: TAclUser);
begin
  inherited Create;
  FAclUser := AAclUser;
end;

function TAclUserResource.Execute: ISuperObject;
var
  lAux: String;
begin
  FSObj := FAclUser.AsJSONObject;
  lAux := FSObj.AsJSON;
  HandleAttributes;

  Result := FSObj;
end;

function TAclUserResource.HandleAttributes: IAclUserResource;
begin
  Result := Self;
  HandleAclUser;
end;

function TAclUserResource.HandleAclUser: IAclUserResource;
begin
  Result := Self;
  FSObj.Null['login_password']  := jUnAssigned;
  FSObj.Null['last_token']      := jUnAssigned;
  FSObj.Null['last_expiration'] := jUnAssigned;
end;

class function TAclUserResource.Make(AAclUser: TAclUser): IAclUserResource;
begin
  Result := Self.Create(AAclUser);
end;

end.
