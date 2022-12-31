unit uSQLBuilder.Factory;

interface

uses
  uAppParam.SQLBuilder.Interfaces,
  uTenant.SQLBuilder.Interfaces,
  uTaxRuleState.SQLBuilder.Interfaces,
  uTaxRule.SQLBuilder.Interfaces,
  uNCM.SQLBuilder.Interfaces,
  uChartOfAccount.SQLBuilder.Interfaces,
  uOperationType.SQLBuilder.Interfaces,
  uCFOP.SQLBuilder.Interfaces,
  uPaymentTerm.SQLBuilder.Interfaces,
  uDocument.SQLBuilder.Interfaces,
  uBankAccount.SQLBuilder.Interfaces,
  uBank.SQLBuilder.Interfaces,
  uProduct.SQLBuilder.Interfaces,
  uPersonContact.SQLBuilder.Interfaces,
  uPerson.SQLBuilder.Interfaces,
  uCity.SQLBuilder.Interfaces,
  uStorageLocation.SQLBuilder.Interfaces,
  uUnit.SQLBuilder.Interfaces,
  uSize.SQLBuilder.Interfaces,
  uAclRole.SQLBuilder.Interfaces,
  uAclUser.SQLBuilder.Interfaces,
  uBrand.SQLBuilder.Interfaces,
  uCostCenter.SQLBuilder.Interfaces,
  uCategory.SQLBuilder.Interfaces,
  uZLConnection.Types;

type
  ISQLBuilderFactory = interface
    ['{865EBE81-EE3C-4E9B-A2CE-0DC3EAB7749F}']

    function AppParam: IAppParamSQLBuilder;
    function Tenant: ITenantSQLBuilder;
    function TaxRuleState: ITaxRuleStateSQLBuilder;
    function TaxRule: ITaxRuleSQLBuilder;
    function NCM: INCMSQLBuilder;
    function ChartOfAccount: IChartOfAccountSQLBuilder;
    function OperationType: IOperationTypeSQLBuilder;
    function CFOP: ICFOPSQLBuilder;
    function PaymentTerm: IPaymentTermSQLBuilder;
    function Document: IDocumentSQLBuilder;
    function BankAccount: IBankAccountSQLBuilder;
    function Bank: IBankSQLBuilder;
    function Product: IProductSQLBuilder;
    function PersonContact: IPersonContactSQLBuilder;
    function Person: IPersonSQLBuilder;
    function City: ICitySQLBuilder;
    function StorageLocation: IStorageLocationSQLBuilder;
    function &Unit: IUnitSQLBuilder;
    function Size: ISizeSQLBuilder;
    function AclRole: IAclRoleSQLBuilder;
    function AclUser: IAclUserSQLBuilder;
    function Brand: IBrandSQLBuilder;
    function CostCenter: ICostCenterSQLBuilder;
    function Category: ICategorySQLBuilder;
  end;

  TSQLBuilderFactory = class(TInterfacedObject, ISQLBuilderFactory)
  private
    FDriverDB: TZLDriverDB;
    constructor Create(ADriverDB: TZLDriverDB);
  public
    class function Make(ADriverDB: TZLDriverDB = ddDefault): ISQLBuilderFactory;

    function AppParam: IAppParamSQLBuilder;
    function Tenant: ITenantSQLBuilder;
    function TaxRuleState: ITaxRuleStateSQLBuilder;
    function TaxRule: ITaxRuleSQLBuilder;
    function NCM: INCMSQLBuilder;
    function ChartOfAccount: IChartOfAccountSQLBuilder;
    function OperationType: IOperationTypeSQLBuilder;
    function CFOP: ICFOPSQLBuilder;
    function PaymentTerm: IPaymentTermSQLBuilder;
    function Document: IDocumentSQLBuilder;
    function BankAccount: IBankAccountSQLBuilder;
    function Bank: IBankSQLBuilder;
    function Product: IProductSQLBuilder;
    function PersonContact: IPersonContactSQLBuilder;
    function Person: IPersonSQLBuilder;
    function City: ICitySQLBuilder;
    function StorageLocation: IStorageLocationSQLBuilder;
    function &Unit: IUnitSQLBuilder;
    function Size: ISizeSQLBuilder;
    function AclRole: IAclRoleSQLBuilder;
    function AclUser: IAclUserSQLBuilder;
    function Brand: IBrandSQLBuilder;
    function CostCenter: ICostCenterSQLBuilder;
    function Category: ICategorySQLBuilder;
  end;

implementation

uses
  uAppParam.SQLBuilder.MySQL,
  uTenant.SQLBuilder.MySQL,
  uTaxRuleState.SQLBuilder.MySQL,
  uTaxRule.SQLBuilder.MySQL,
  uNCM.SQLBuilder.MySQL,
  uChartOfAccount.SQLBuilder.MySQL,
  uOperationType.SQLBuilder.MySQL,
  uCFOP.SQLBuilder.MySQL,
  uPaymentTerm.SQLBuilder.MySQL,
  uDocument.SQLBuilder.MySQL,
  uBankAccount.SQLBuilder.MySQL,
  uBank.SQLBuilder.MySQL,
  uProduct.SQLBuilder.MySQL,
  uPersonContact.SQLBuilder.MySQL,
  uPerson.SQLBuilder.MySQL,
  uCity.SQLBuilder.MySQL,
  uStorageLocation.SQLBuilder.MySQL,
  uUnit.SQLBuilder.MySQL,
  uSize.SQLBuilder.MySQL,
  uAclRole.SQLBuilder.MySQL,
  uAclUser.SQLBuilder.MySQL,
  uBrand.SQLBuilder.MySQL,
  uCostCenter.SQLBuilder.MySQL,
  uCategory.SQLBuilder.MySQL,
  uEnv;

{ TSQLBuilderFactory }

function TSQLBuilderFactory.&Unit: IUnitSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TUnitSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.AclRole: IAclRoleSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TAclRoleSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.AclUser: IAclUserSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TAclUserSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.AppParam: IAppParamSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TAppParamSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.Bank: IBankSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TBankSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.BankAccount: IBankAccountSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TBankAccountSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.Brand: IBrandSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TBrandSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.Category: ICategorySQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TCategorySQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.CFOP: ICFOPSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TCFOPSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.ChartOfAccount: IChartOfAccountSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TChartOfAccountSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.City: ICitySQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TCitySQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.CostCenter: ICostCenterSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TCostCenterSQLBuilderMySQL.Make;
  end;
end;

constructor TSQLBuilderFactory.Create(ADriverDB: TZLDriverDB);
begin
  inherited Create;

  FDriverDB := ADriverDB;
  if (FDriverDB = ddDefault) then
    FDriverDB := Env.DriverDB;
end;

function TSQLBuilderFactory.Document: IDocumentSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TDocumentSQLBuilderMySQL.Make;
  end;
end;

class function TSQLBuilderFactory.Make(ADriverDB: TZLDriverDB): ISQLBuilderFactory;
begin
  Result := Self.Create(ADriverDB);
end;

function TSQLBuilderFactory.NCM: INCMSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TNCMSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.OperationType: IOperationTypeSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TOperationTypeSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.PaymentTerm: IPaymentTermSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TPaymentTermSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.Person: IPersonSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TPersonSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.PersonContact: IPersonContactSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TPersonContactSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.Product: IProductSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TProductSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.Size: ISizeSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TSizeSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.StorageLocation: IStorageLocationSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TStorageLocationSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.TaxRule: ITaxRuleSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TTaxRuleSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.TaxRuleState: ITaxRuleStateSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TTaxRuleStateSQLBuilderMySQL.Make;
  end;
end;

function TSQLBuilderFactory.Tenant: ITenantSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TTenantSQLBuilderMySQL.Make;
  end;
end;

end.
