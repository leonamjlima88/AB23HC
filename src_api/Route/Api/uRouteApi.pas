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
  uTenant.Controller,
  uTaxRule.Controller,
  uNCM.Controller,
  uChartOfAccount.Controller,
  uCFOP.Controller,
  uOperationType.Controller,
  uPaymentTerm.Controller,
  uDocument.Controller,
  uBankAccount.Controller,
  uBank.Controller,
  uPerson.Controller,
  uCity.Controller,
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
  uSize.Controller,
  uProduct.Controller;

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

  THorseGBSwaggerRegister.RegisterPath(TTenantController);
  THorseGBSwaggerRegister.RegisterPath(TTaxRuleController);
  THorseGBSwaggerRegister.RegisterPath(TNCMController);
  THorseGBSwaggerRegister.RegisterPath(TChartOfAccountController);
  THorseGBSwaggerRegister.RegisterPath(TCFOPController);
  THorseGBSwaggerRegister.RegisterPath(TOperationTypeController);
  THorseGBSwaggerRegister.RegisterPath(TPaymentTermController);
  THorseGBSwaggerRegister.RegisterPath(TDocumentController);
  THorseGBSwaggerRegister.RegisterPath(TBankAccountController);
  THorseGBSwaggerRegister.RegisterPath(TBankController);
  THorseGBSwaggerRegister.RegisterPath(TProductController);
  THorseGBSwaggerRegister.RegisterPath(TPersonController);
  THorseGBSwaggerRegister.RegisterPath(TCityController);
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
