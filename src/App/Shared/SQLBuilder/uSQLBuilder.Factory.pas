unit uSQLBuilder.Factory;

interface

uses
  uConnection.Types,
  uAclRole.SQLBuilder.Interfaces,
  uAclUser.SQLBuilder.Interfaces,
  uBrand.SQLBuilder.Interfaces;

type
  ISQLBuilderFactory = interface
    ['{865EBE81-EE3C-4E9B-A2CE-0DC3EAB7749F}']
    function AclRole: IAclRoleSQLBuilder;
    function AclUser: IAclUserSQLBuilder;
    function Brand: IBrandSQLBuilder;
  end;

  TSQLBuilderFactory = class(TInterfacedObject, ISQLBuilderFactory)
  private
    FDriverDB: TDriverDB;
    constructor Create(ADriverDB: TDriverDB);
  public
    class function Make(ADriverDB: TDriverDB = ddDefault): ISQLBuilderFactory;

    function AclRole: IAclRoleSQLBuilder;
    function AclUser: IAclUserSQLBuilder;
    function Brand: IBrandSQLBuilder;
  end;

implementation

uses
  uAclRole.SQLBuilder.MySQL,
  uAclUser.SQLBuilder.MySQL,
  uBrand.SQLBuilder.MySQL,
  uEnv;

{ TSQLBuilderFactory }

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

end.
