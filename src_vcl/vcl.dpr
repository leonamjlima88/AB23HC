program vcl;

uses
  Vcl.Forms,
  System.UITypes,
  uBrand.CreateUpdate.View in 'App\Module\Brand\View\uBrand.CreateUpdate.View.pas',
  uBrand.MTB in 'App\Module\Brand\MemTable\uBrand.MTB.pas',
  uBrand.Service in 'App\Module\Brand\Service\uBrand.Service.pas',
  uBrand.Index.View in 'App\Module\Brand\View\uBrand.Index.View.pas',
  uPerson.MTB in 'App\Module\Person\MemTable\uPerson.MTB.pas',
  uHlp in 'App\Shared\Infra\uHlp.pas',
  uPerson.CreateUpdate.View in 'App\Module\Person\View\uPerson.CreateUpdate.View.pas',
  uBase.Index.View in 'App\Shared\Presentation\uBase.Index.View.pas' {BaseIndexView},
  uEntity.MemTable.Interfaces in 'App\Shared\Domain\Entity\uEntity.MemTable.Interfaces.pas',
  uPersonContact.CreateUpdate.View in 'App\Module\Person\View\uPersonContact.CreateUpdate.View.pas',
  uSession.DTM in 'Config\Infra\uSession.DTM.pas' {SessionDTM: TDataModule},
  uPerson.Service in 'App\Module\Person\Service\uPerson.Service.pas',
  uPerson.Index.View in 'App\Module\Person\View\uPerson.Index.View.pas' {PersonIndexView},
  uMain.View in 'App\Shared\Presentation\uMain.View.pas' {MainView},
  uApplication.Types in 'App\Shared\Infra\uApplication.Types.pas',
  uNotificationView in 'App\Shared\Presentation\uNotificationView.pas' {NotificationView},
  uYesOrNo.View in 'App\Shared\Presentation\uYesOrNo.View.pas' {YesOrNoView},
  uAlert.View in 'App\Shared\Presentation\uAlert.View.pas' {AlertView},
  uBase.CreateUpdate.View in 'App\Shared\Presentation\uBase.CreateUpdate.View.pas' {BaseCreateUpdateView},
  uLogin.View in 'App\Module\AclUser\View\uLogin.View.pas' {LoginView},
  uBase.Entity in 'App\Shared\Domain\Entity\uBase.Entity.pas',
  uIndexResult in 'App\Shared\Infra\uIndexResult.pas',
  uHandle.Exception in 'App\Shared\Infra\uHandle.Exception.pas',
  uPageFilter in 'App\Shared\Infra\uPageFilter.pas',
  uReq in 'App\Shared\Infra\uReq.pas',
  uObservable in 'App\Shared\Domain\Entity\uObservable.pas',
  uObserver in 'App\Shared\Domain\Entity\uObserver.pas',
  uMemTable.Factory in 'App\Shared\Infra\uMemTable.Factory.pas',
  uEnv in 'App\Shared\Infra\uEnv.pas',
  uUserLogged in 'App\Module\AclUser\Entity\uUserLogged.pas',
  uAclUser in 'App\Module\AclUser\Entity\uAclUser.pas',
  uAclRole in 'App\Module\AclRole\Entity\uAclRole.pas',
  uEither in 'App\Shared\Infra\uEither.pas',
  uSearchColumns in 'App\Shared\Infra\uSearchColumns.pas',
  uCity.Index.View in 'App\Module\City\View\uCity.Index.View.pas' {CityIndexView},
  uCity.CreateUpdate.View in 'App\Module\City\View\uCity.CreateUpdate.View.pas' {CityCreateUpdateView},
  uCity.Service in 'App\Module\City\Service\uCity.Service.pas',
  uCity.MTB in 'App\Module\City\MemTable\uCity.MTB.pas',
  uSearchLegalEntityNumber.Lib in 'App\Shared\Lib\uSearchLegalEntityNumber.Lib.pas',
  uSearchZipCode.Lib in 'App\Shared\Lib\uSearchZipCode.Lib.pas',
  uAppParam.Service in 'App\Module\AppParam\Service\uAppParam.Service.pas',
  uAppParam.MTB in 'App\Module\AppParam\MemTable\uAppParam.MTB.pas',
  uAppParam in 'App\Module\AppParam\Entity\uAppParam.pas',
  uCategory.Index.View in 'App\Module\Category\View\uCategory.Index.View.pas' {CategoryIndexView},
  uCategory.CreateUpdate.View in 'App\Module\Category\View\uCategory.CreateUpdate.View.pas' {CategoryCreateUpdateView},
  uCategory.Service in 'App\Module\Category\Service\uCategory.Service.pas',
  uCategory.MTB in 'App\Module\Category\MemTable\uCategory.MTB.pas',
  uSize.Index.View in 'App\Module\Size\View\uSize.Index.View.pas' {SizeIndexView},
  uSize.CreateUpdate.View in 'App\Module\Size\View\uSize.CreateUpdate.View.pas' {SizeCreateUpdateView},
  uSize.Service in 'App\Module\Size\Service\uSize.Service.pas',
  uSize.MTB in 'App\Module\Size\MemTable\uSize.MTB.pas',
  uUnit.Index.View in 'App\Module\Unit\View\uUnit.Index.View.pas' {UnitIndexView},
  uUnit.CreateUpdate.View in 'App\Module\Unit\View\uUnit.CreateUpdate.View.pas' {UnitCreateUpdateView},
  uUnit.Service in 'App\Module\Unit\Service\uUnit.Service.pas',
  uUnit.MTB in 'App\Module\Unit\MemTable\uUnit.MTB.pas',
  uStorageLocation.Index.View in 'App\Module\StorageLocation\View\uStorageLocation.Index.View.pas' {StorageLocationIndexView},
  uStorageLocation.CreateUpdate.View in 'App\Module\StorageLocation\View\uStorageLocation.CreateUpdate.View.pas' {StorageLocationCreateUpdateView},
  uStorageLocation.Service in 'App\Module\StorageLocation\Service\uStorageLocation.Service.pas',
  uStorageLocation.MTB in 'App\Module\StorageLocation\MemTable\uStorageLocation.MTB.pas',
  uNCM.Index.View in 'App\Module\NCM\View\uNCM.Index.View.pas' {NCMIndexView},
  uNCM.CreateUpdate.View in 'App\Module\NCM\View\uNCM.CreateUpdate.View.pas' {NCMCreateUpdateView},
  uNCM.Service in 'App\Module\NCM\Service\uNCM.Service.pas',
  uNCM.MTB in 'App\Module\NCM\MemTable\uNCM.MTB.pas',
  uCostCenter.Index.View in 'App\Module\CostCenter\View\uCostCenter.Index.View.pas' {CostCenterIndexView},
  uCostCenter.CreateUpdate.View in 'App\Module\CostCenter\View\uCostCenter.CreateUpdate.View.pas' {CostCenterCreateUpdateView},
  uCostCenter.Service in 'App\Module\CostCenter\Service\uCostCenter.Service.pas',
  uCostCenter.MTB in 'App\Module\CostCenter\MemTable\uCostCenter.MTB.pas',
  uBank.Index.View in 'App\Module\Bank\View\uBank.Index.View.pas' {BankIndexView},
  uBank.CreateUpdate.View in 'App\Module\Bank\View\uBank.CreateUpdate.View.pas' {BankCreateUpdateView},
  uBank.Service in 'App\Module\Bank\Service\uBank.Service.pas',
  uBank.MTB in 'App\Module\Bank\MemTable\uBank.MTB.pas',
  uBankAccount.Index.View in 'App\Module\BankAccount\View\uBankAccount.Index.View.pas' {BankAccountIndexView},
  uBankAccount.CreateUpdate.View in 'App\Module\BankAccount\View\uBankAccount.CreateUpdate.View.pas' {BankAccountCreateUpdateView},
  uBankAccount.Service in 'App\Module\BankAccount\Service\uBankAccount.Service.pas',
  uBankAccount.MTB in 'App\Module\BankAccount\MemTable\uBankAccount.MTB.pas',
  uDocument.Index.View in 'App\Module\Document\View\uDocument.Index.View.pas' {DocumentIndexView},
  uDocument.CreateUpdate.View in 'App\Module\Document\View\uDocument.CreateUpdate.View.pas' {DocumentCreateUpdateView},
  uDocument.Service in 'App\Module\Document\Service\uDocument.Service.pas',
  uDocument.MTB in 'App\Module\Document\MemTable\uDocument.MTB.pas',
  uPaymentTerm.Index.View in 'App\Module\PaymentTerm\View\uPaymentTerm.Index.View.pas' {PaymentTermIndexView},
  uPaymentTerm.CreateUpdate.View in 'App\Module\PaymentTerm\View\uPaymentTerm.CreateUpdate.View.pas' {PaymentTermCreateUpdateView},
  uPaymentTerm.Service in 'App\Module\PaymentTerm\Service\uPaymentTerm.Service.pas',
  uPaymentTerm.MTB in 'App\Module\PaymentTerm\MemTable\uPaymentTerm.MTB.pas',
  uChartOfAccount.Index.View in 'App\Module\ChartOfAccount\View\uChartOfAccount.Index.View.pas' {ChartOfAccountIndexView},
  uChartOfAccount.CreateUpdate.View in 'App\Module\ChartOfAccount\View\uChartOfAccount.CreateUpdate.View.pas' {ChartOfAccountCreateUpdateView},
  uChartOfAccount.Service in 'App\Module\ChartOfAccount\Service\uChartOfAccount.Service.pas',
  uChartOfAccount.MTB in 'App\Module\ChartOfAccount\MemTable\uChartOfAccount.MTB.pas',
  uOperationType.Index.View in 'App\Module\OperationType\View\uOperationType.Index.View.pas' {OperationTypeIndexView},
  uOperationType.CreateUpdate.View in 'App\Module\OperationType\View\uOperationType.CreateUpdate.View.pas' {OperationTypeCreateUpdateView},
  uOperationType.Service in 'App\Module\OperationType\Service\uOperationType.Service.pas',
  uOperationType.MTB in 'App\Module\OperationType\MemTable\uOperationType.MTB.pas',
  uCFOP.Index.View in 'App\Module\CFOP\View\uCFOP.Index.View.pas' {CFOPIndexView},
  uCFOP.CreateUpdate.View in 'App\Module\CFOP\View\uCFOP.CreateUpdate.View.pas' {CFOPCreateUpdateView},
  uCFOP.Service in 'App\Module\CFOP\Service\uCFOP.Service.pas',
  uCFOP.MTB in 'App\Module\CFOP\MemTable\uCFOP.MTB.pas',
  uTaxRuleState.CreateUpdate.View in 'App\Module\TaxRule\View\uTaxRuleState.CreateUpdate.View.pas' {TaxRuleStateCreateUpdateView},
  uTaxRule.CreateUpdate.View in 'App\Module\TaxRule\View\uTaxRule.CreateUpdate.View.pas' {TaxRuleCreateUpdateView},
  uTaxRule.MTB in 'App\Module\TaxRule\MemTable\uTaxRule.MTB.pas',
  uTaxRule.Index.View in 'App\Module\TaxRule\View\uTaxRule.Index.View.pas' {TaxRuleIndexView},
  uTaxRule.Service in 'App\Module\TaxRule\Service\uTaxRule.Service.pas',
  uProduct.Index.View in 'App\Module\Product\View\uProduct.Index.View.pas' {ProductIndexView},
  uProduct.CreateUpdate.View in 'App\Module\Product\View\uProduct.CreateUpdate.View.pas' {ProductCreateUpdateView},
  uProduct.Service in 'App\Module\Product\Service\uProduct.Service.pas',
  uProduct.MTB in 'App\Module\Product\MemTable\uProduct.MTB.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSessionDTM, SessionDTM);
  Application.CreateForm(TMainView, MainView);
  Application.CreateForm(TNotificationView, NotificationView);
  Application.Run;
end.
