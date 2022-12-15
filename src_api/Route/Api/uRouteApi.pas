unit uRouteApi;

interface

uses
  Horse;

type
  TRouteApi = class
  public
    class procedure Registry;
  end;

implementation

uses
  uStorageLocation.Controller,
  uUnit.Controller,
  uBrand.Controller,
  uAclRole.Controller,
  uAclUser.Controller,
  System.SysUtils,
  Horse.RateLimit,
  Horse.GBSwagger,
  uAclUser.Auth.Controller,
  uCategory.Controller,
  uCostCenter.Controller,
  uSize.Controller;

{ TRouteApi }

class procedure TRouteApi.Registry;
begin
  // Método de Teste - PING
  THorse
    .Get(
      'ping',
      procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
      begin
        Res.Send('pong');
      end
    );

  THorseGBSwaggerRegister.RegisterPath(TStorageLocationController);
  THorseGBSwaggerRegister.RegisterPath(TUnitController);
  THorseGBSwaggerRegister.RegisterPath(TAclRoleController);
  THorseGBSwaggerRegister.RegisterPath(TAclUserController);
  THorseGBSwaggerRegister.RegisterPath(TAclUserAuthController);
  THorseGBSwaggerRegister.RegisterPath(TBrandController);
  THorseGBSwaggerRegister.RegisterPath(TCategoryController);
  THorseGBSwaggerRegister.RegisterPath(TCostCenterController);
  THorseGBSwaggerRegister.RegisterPath(TSizeController);
end;

end.
