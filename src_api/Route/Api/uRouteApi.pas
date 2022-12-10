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
  Horse.RateLimit;

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

  TBrandController.Registry;
  TAclRoleController.Registry;
  TAclUserController.Registry;
end;

end.
