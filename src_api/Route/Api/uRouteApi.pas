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
  uBrand.Controller,
  uAclRole.Controller,
  uAclUser.Controller,
  System.SysUtils,
  Horse.RateLimit,
  Horse.GBSwagger,
  uAclUser.Auth.Controller;

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

  THorseGBSwaggerRegister.RegisterPath(TBrandController);
  THorseGBSwaggerRegister.RegisterPath(TAclRoleController);
  THorseGBSwaggerRegister.RegisterPath(TAclUserController);
  THorseGBSwaggerRegister.RegisterPath(TAclUserAuthController);
end;

end.
