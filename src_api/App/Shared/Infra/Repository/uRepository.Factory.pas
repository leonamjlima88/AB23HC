unit uRepository.Factory;

interface

uses
  uTenant.Repository.Interfaces,
  uTaxRule.Repository.Interfaces,
  uNCM.Repository.Interfaces,
  uChartOfAccount.Repository.Interfaces,
  uOperationType.Repository.Interfaces,
  uCFOP.Repository.Interfaces,
  uPaymentTerm.Repository.Interfaces,
  uDocument.Repository.Interfaces,
  uBankAccount.Repository.Interfaces,
  uBank.Repository.Interfaces,
  uProduct.Repository.Interfaces,
  uPerson.Repository.Interfaces,
  uCity.Repository.Interfaces,
  uStorageLocation.Repository.Interfaces,
  uUnit.Repository.Interfaces,
  uSize.Repository.Interfaces,
  uAclRole.Repository.Interfaces,
  uAclUser.Repository.Interfaces,
  uBrand.Repository.Interfaces,
  uCostCenter.Repository.Interfaces,
  uCategory.Repository.Interfaces,
  uZLConnection.Interfaces,
  uZLConnection.Types;

type
  IRepositoryFactory = Interface
    ['{4360ECF9-C170-41B5-8E9B-74C58AE06AA2}']

    function Tenant: ITenantRepository;
    function TaxRule: ITaxRuleRepository;
    function NCM: INCMRepository;
    function ChartOfAccount: IChartOfAccountRepository;
    function OperationType: IOperationTypeRepository;
    function CFOP: ICFOPRepository;
    function PaymentTerm: IPaymentTermRepository;
    function Document: IDocumentRepository;
    function BankAccount: IBankAccountRepository;
    function Bank: IBankRepository;
    function Product: IProductRepository;
    function Person: IPersonRepository;
    function City: ICityRepository;
    function StorageLocation: IStorageLocationRepository;
    function &Unit: IUnitRepository;
    function Size: ISizeRepository;
    function AclRole: IAclRoleRepository;
    function AclUser: IAclUserRepository;
    function Brand: IBrandRepository;
    function CostCenter: ICostCenterRepository;
    function Category: ICategoryRepository;
  end;

  TRepositoryFactory = class(TInterfacedObject, IRepositoryFactory)
  private
    FConn: IZLConnection;
    FRepoType: TZLRepositoryType;
    FDriverDB: TZLDriverDB;
    constructor Create(AConn: IZLConnection; ARepoType: TZLRepositoryType; ADriverDB: TZLDriverDB);
  public
    class function Make(AConn: IZLConnection = nil; ARepoType: TZLRepositoryType = rtDefault; ADriverDB: TZLDriverDB = ddDefault): IRepositoryFactory;

    function Tenant: ITenantRepository;
    function TaxRule: ITaxRuleRepository;
    function NCM: INCMRepository;
    function ChartOfAccount: IChartOfAccountRepository;
    function OperationType: IOperationTypeRepository;
    function CFOP: ICFOPRepository;
    function PaymentTerm: IPaymentTermRepository;
    function Document: IDocumentRepository;
    function BankAccount: IBankAccountRepository;
    function Bank: IBankRepository;
    function Product: IProductRepository;
    function Person: IPersonRepository;
    function City: ICityRepository;
    function StorageLocation: IStorageLocationRepository;
    function &Unit: IUnitRepository;
    function Size: ISizeRepository;
    function AclRole: IAclRoleRepository;
    function AclUser: IAclUserRepository;
    function Brand: IBrandRepository;
    function CostCenter: ICostCenterRepository;
    function Category: ICategoryRepository;
  end;

implementation

uses
  uTenant.Repository.SQL,
  uTaxRule.Repository.SQL,
  uNCM.Repository.SQL,
  uChartOfAccount.Repository.SQL,
  uOperationType.Repository.SQL,
  uCFOP.Repository.SQL,
  uPaymentTerm.Repository.SQL,
  uDocument.Repository.SQL,
  uBankAccount.Repository.SQL,
  uBank.Repository.SQL,
  uProduct.Repository.SQL,
  uPerson.Repository.SQL,
  uCity.Repository.SQL,
  uStorageLocation.Repository.SQL,
  uUnit.Repository.SQL,
  uSize.Repository.SQL,
  uAclRole.Repository.SQL,
  uAclUser.Repository.SQL,
  uBrand.Repository.SQL,
  uCostCenter.Repository.SQL,
  uCategory.Repository.SQL,
  uSQLBuilder.Factory,
  uEnv,
  uConnection.Factory;

{ TRepositoryFactory }

function TRepositoryFactory.&Unit: IUnitRepository;
begin
  case FRepoType of
    rtSQL: Result := TUnitRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).&Unit);
  end;
end;

function TRepositoryFactory.AclRole: IAclRoleRepository;
begin
  case FRepoType of
    rtSQL: Result := TAclRoleRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).AclRole);
  end;
end;

function TRepositoryFactory.AclUser: IAclUserRepository;
begin
  case FRepoType of
    rtSQL: Result := TAclUserRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).AclUser);
  end;
end;

function TRepositoryFactory.Bank: IBankRepository;
begin
  case FRepoType of
    rtSQL: Result := TBankRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).Bank);
  end;
end;

function TRepositoryFactory.BankAccount: IBankAccountRepository;
begin
  case FRepoType of
    rtSQL: Result := TBankAccountRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).BankAccount);
  end;
end;

function TRepositoryFactory.Brand: IBrandRepository;
begin
  case FRepoType of
    rtSQL: Result := TBrandRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).Brand);
  end;
end;

function TRepositoryFactory.Category: ICategoryRepository;
begin
  case FRepoType of
    rtSQL: Result := TCategoryRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).Category);
  end;
end;

function TRepositoryFactory.CFOP: ICFOPRepository;
begin
  case FRepoType of
    rtSQL: Result := TCFOPRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).CFOP);
  end;
end;

function TRepositoryFactory.ChartOfAccount: IChartOfAccountRepository;
begin
  case FRepoType of
    rtSQL: Result := TChartOfAccountRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).ChartOfAccount);
  end;
end;

function TRepositoryFactory.City: ICityRepository;
begin
  case FRepoType of
    rtSQL: Result := TCityRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).City);
  end;
end;

function TRepositoryFactory.CostCenter: ICostCenterRepository;
begin
  case FRepoType of
    rtSQL: Result := TCostCenterRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).CostCenter);
  end;
end;

constructor TRepositoryFactory.Create(AConn: IZLConnection; ARepoType: TZLRepositoryType; ADriverDB: TZLDriverDB);
begin
  inherited Create;

  // Driver do Banco de Dados
  FDriverDB := ADriverDB;
  if (FDriverDB = ddDefault) then
    FDriverDB := Env.DriverDB;

  // Tipo de Repositório
  FRepoType := ARepoType;
  if (FRepoType = rtDefault) then
    FRepoType := Env.DefaultRepoType;

  // Conexão
  case Assigned(AConn) of
    True:  FConn := AConn;
    False: FConn := TConnectionFactory.Make;
  end;
end;

function TRepositoryFactory.Document: IDocumentRepository;
begin
  case FRepoType of
    rtSQL: Result := TDocumentRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).Document);
  end;
end;

class function TRepositoryFactory.Make(AConn: IZLConnection; ARepoType: TZLRepositoryType; ADriverDB: TZLDriverDB): IRepositoryFactory;
begin
  Result := Self.Create(AConn, ARepoType, ADriverDB);
end;

function TRepositoryFactory.NCM: INCMRepository;
begin
  case FRepoType of
    rtSQL: Result := TNCMRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).NCM);
  end;
end;

function TRepositoryFactory.OperationType: IOperationTypeRepository;
begin
  case FRepoType of
    rtSQL: Result := TOperationTypeRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).OperationType);
  end;
end;

function TRepositoryFactory.PaymentTerm: IPaymentTermRepository;
begin
  case FRepoType of
    rtSQL: Result := TPaymentTermRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).PaymentTerm);
  end;
end;

function TRepositoryFactory.Person: IPersonRepository;
begin
  case FRepoType of
    rtSQL: Result := TPersonRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).Person);
  end;
end;

function TRepositoryFactory.Product: IProductRepository;
begin
  case FRepoType of
    rtSQL: Result := TProductRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).Product);
  end;
end;

function TRepositoryFactory.Size: ISizeRepository;
begin
  case FRepoType of
    rtSQL: Result := TSizeRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).Size);
  end;
end;

function TRepositoryFactory.StorageLocation: IStorageLocationRepository;
begin
  case FRepoType of
    rtSQL: Result := TStorageLocationRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).StorageLocation);
  end;
end;

function TRepositoryFactory.TaxRule: ITaxRuleRepository;
begin
  case FRepoType of
    rtSQL: Result := TTaxRuleRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).TaxRule);
  end;
end;

function TRepositoryFactory.Tenant: ITenantRepository;
begin
  case FRepoType of
    rtSQL: Result := TTenantRepositorySQL.Make(FConn, TSQLBuilderFactory.Make(FDriverDB).Tenant);
  end;
end;

end.
