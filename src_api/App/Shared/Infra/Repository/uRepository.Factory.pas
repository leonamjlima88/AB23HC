unit uRepository.Factory;

interface

uses
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
  uConnection.Interfaces,
  uConnection.Types;

type
  IRepositoryFactory = Interface
    ['{4360ECF9-C170-41B5-8E9B-74C58AE06AA2}']
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
    FConn: IConnection;
    FRepoType: TRepositoryType;
    FDriverDB: TDriverDB;
    constructor Create(AConn: IConnection; ARepoType: TRepositoryType; ADriverDB: TDriverDB);
  public
    class function Make(AConn: IConnection = nil; ARepoType: TRepositoryType = rtDefault; ADriverDB: TDriverDB = ddDefault): IRepositoryFactory;

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

constructor TRepositoryFactory.Create(AConn: IConnection; ARepoType: TRepositoryType; ADriverDB: TDriverDB);
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

class function TRepositoryFactory.Make(AConn: IConnection; ARepoType: TRepositoryType; ADriverDB: TDriverDB): IRepositoryFactory;
begin
  Result := Self.Create(AConn, ARepoType, ADriverDB);
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

end.
