unit uSQLBuilder.Factory;

interface

uses
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
  uConnection.Types;

type
  ISQLBuilderFactory = interface
    ['{865EBE81-EE3C-4E9B-A2CE-0DC3EAB7749F}']
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
    FDriverDB: TDriverDB;
    constructor Create(ADriverDB: TDriverDB);
  public
    class function Make(ADriverDB: TDriverDB = ddDefault): ISQLBuilderFactory;

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

constructor TSQLBuilderFactory.Create(ADriverDB: TDriverDB);
begin
  inherited Create;

  FDriverDB := ADriverDB;
  if (FDriverDB = ddDefault) then
    FDriverDB := Env.DriverDB;
end;

class function TSQLBuilderFactory.Make(ADriverDB: TDriverDB): ISQLBuilderFactory;
begin
  Result := Self.Create(ADriverDB);
end;

function TSQLBuilderFactory.Person: IPersonSQLBuilder;
begin
  case FDriverDB of
    ddMySql: Result := TPersonSQLBuilderMySQL.Make;
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

end.
