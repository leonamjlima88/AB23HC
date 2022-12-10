unit uBrand.Resource;

interface

uses
  uBrand,
  XSuperObject,
  System.TypInfo;

type
  IBrandResource = Interface
    ['{CA9FC614-BA3B-4F45-B55C-C44B24D53D9C}']
    function Execute: ISuperObject;
  end;

  TBrandResource = class(TInterfacedObject, IBrandResource)
  private
    FSObj: ISuperObject;
    FBrand: TBrand;
    constructor Create(ABrand: TBrand);
    function HandleAttributes: IBrandResource;
    function HandleBrand: IBrandResource;
  public
    class function Make(ABrand: TBrand): IBrandResource;
    function Execute: ISuperObject;
  end;

implementation

uses
  System.Classes,
  System.SysUtils;

{ TBrandResource }

constructor TBrandResource.Create(ABrand: TBrand);
begin
  inherited Create;
  FBrand := ABrand;
end;

function TBrandResource.Execute: ISuperObject;
begin
  FSObj := FBrand.AsJSONObject;
  HandleAttributes;

  Result := FSObj;
end;

function TBrandResource.HandleAttributes: IBrandResource;
begin
  Result := Self;
  HandleBrand;
end;

function TBrandResource.HandleBrand: IBrandResource;
begin
  Result := Self;

  if (FSObj['updated_at'].AsDateTime <= 0) then
    FSObj.Null['updated_at'] := jNull;

  FSObj.S['created_by_acl_user_name'] := FSObj.O['created_by_acl_user'].S['name'];
  FSObj.S['updated_by_acl_user_name'] := FSObj.O['updated_by_acl_user'].S['name'];
  FSObj.Null['created_by_acl_user']   := jUnAssigned;
  FSObj.Null['updated_by_acl_user']   := jUnAssigned;
end;

class function TBrandResource.Make(ABrand: TBrand): IBrandResource;
begin
  Result := Self.Create(ABrand);
end;

end.
