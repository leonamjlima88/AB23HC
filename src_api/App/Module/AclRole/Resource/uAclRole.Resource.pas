unit uAclRole.Resource;

interface

uses
  uAclRole,
  XSuperObject,
  System.TypInfo;

type
  IAclRoleResource = Interface
    ['{1DE499A1-E666-4E46-B699-4F29916FA852}']
    function Execute: ISuperObject;
  end;

  TAclRoleResource = class(TInterfacedObject, IAclRoleResource)
  private
    FSObj: ISuperObject;
    FAclRole: TAclRole;
    constructor Create(AAclRole: TAclRole);
    function HandleAttributes: IAclRoleResource;
    function HandleAclRole: IAclRoleResource;
  public
    class function Make(AAclRole: TAclRole): IAclRoleResource;
    function Execute: ISuperObject;
  end;

implementation

uses
  System.Classes,
  System.SysUtils;

{ TAclRoleResource }

constructor TAclRoleResource.Create(AAclRole: TAclRole);
begin
  inherited Create;
  FAclRole := AAclRole;
end;

function TAclRoleResource.Execute: ISuperObject;
begin
  FSObj := FAclRole.AsJSONObject;
  HandleAttributes;

  Result := FSObj;
end;

function TAclRoleResource.HandleAttributes: IAclRoleResource;
begin
  Result := Self;
  HandleAclRole;
end;

function TAclRoleResource.HandleAclRole: IAclRoleResource;
begin
  Result := Self;
end;

class function TAclRoleResource.Make(AAclRole: TAclRole): IAclRoleResource;
begin
  Result := Self.Create(AAclRole);
end;

end.
