unit uAclRole.Service;

interface

uses
  uPageFilter,
  uIndexResult,
  uAclRole,
  uAclRole.Repository.Interfaces;

type
  IAclRoleService = interface
    ['{F559AB6F-8E69-4D70-A0FC-6DF9DCC2F62D}']

    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): TAclRole;
    function Store(AAclRole: TAclRole; ADestroyEntity: Boolean = true): Int64;
    function Update(AAclRole: TAclRole; AId: Int64; ADestroyEntity: Boolean = true): Boolean;
  end;

  TAclRoleService = class(TInterfacedObject, IAclRoleService)
  private
    FRepository: IAclRoleRepository;
    constructor Create(ARepository: IAclRoleRepository);
  public
    class function Make(ARepository: IAclRoleRepository): IAclRoleService;
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): TAclRole;
    function Store(AAclRole: TAclRole; ADestroyEntity: Boolean = true): Int64;
    function Update(AAclRole: TAclRole; AId: Int64; ADestroyEntity: Boolean = true): Boolean;
  end;

implementation

uses
  System.SysUtils;

{ TAclRoleService }

constructor TAclRoleService.Create(ARepository: IAclRoleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclRoleService.Delete(AId: Int64): Boolean;
begin
  Result := FRepository.Delete(AId);
end;

function TAclRoleService.Index(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TAclRoleService.Make(ARepository: IAclRoleRepository): IAclRoleService;
begin
  Result := Self.Create(ARepository);
end;

function TAclRoleService.Show(AId: Int64): TAclRole;
begin
  Result := FRepository.Show(AId);
end;

function TAclRoleService.Store(AAclRole: TAclRole; ADestroyEntity: Boolean): Int64;
begin
  Result := FRepository.Store(AAclRole);

  // Destruir entidade
  if ADestroyEntity then
    FreeAndNil(AAclRole);
end;

function TAclRoleService.Update(AAclRole: TAclRole; AId: Int64; ADestroyEntity: Boolean): Boolean;
begin
  Result := FRepository.Update(AAclRole, AId);

  // Destruir entidade
  if ADestroyEntity then
    FreeAndNil(AAclRole);
end;

end.


