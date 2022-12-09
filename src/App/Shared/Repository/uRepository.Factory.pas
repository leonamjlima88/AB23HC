unit uRepository.Factory;

interface

uses
  uConnection.Interfaces, uConnection.Types, uBrand.Repository.Interfaces,
  uAclRole.Repository.Interfaces, uAclUser.Repository.Interfaces;

type
  IRepositoryFactory = Interface
    ['{4360ECF9-C170-41B5-8E9B-74C58AE06AA2}']
    function AclRole: IAclRoleRepository;
    function AclUser: IAclUserRepository;
    function Brand: IBrandRepository;
  end;

  TRepositoryFactory = class(TInterfacedObject, IRepositoryFactory)
  private
    FConn: IConnection;
    FRepoType: TRepositoryType;
    FDriverDB: TDriverDB;
    constructor Create(AConn: IConnection; ARepoType: TRepositoryType; ADriverDB: TDriverDB);
  public
    class function Make(AConn: IConnection = nil; ARepoType: TRepositoryType = rtDefault; ADriverDB: TDriverDB = ddDefault): IRepositoryFactory;

    function AclRole: IAclRoleRepository;
    function AclUser: IAclUserRepository;
    function Brand: IBrandRepository;
  end;

implementation

uses
  uBrand.Repository.SQL,
  uSQLBuilder.Factory,
  uEnv,
  uConnection.Factory,
  uAclRole.Repository.SQL,
  uAclUser.Repository.SQL;

{ TRepositoryFactory }

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

end.
