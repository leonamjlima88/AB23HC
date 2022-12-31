unit uAclRole.Mapper;

interface

uses
  uMapper.Interfaces,
  uAclRole,
  uAclRole.DTO,
  uAclRole.Show.DTO;

type
  TAclRoleMapper = class(TInterfacedObject, IMapper)
  public
    class function AclRoleDtoToEntity(AAclRoleDTO: TAclRoleDTO): TAclRole;
    class function EntityToAclRoleShowDto(AAclRole: TAclRole): TAclRoleShowDTO;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TAclRoleMapper }

class function TAclRoleMapper.EntityToAclRoleShowDto(AAclRole: TAclRole): TAclRoleShowDTO;
var
  lAclRoleShowDTO: TAclRoleShowDTO;
begin
  if not Assigned(AAclRole) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lAclRoleShowDTO := TAclRoleShowDTO.FromJSON(AAclRole.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lAclRoleShowDTO;
end;

class function TAclRoleMapper.AclRoleDtoToEntity(AAclRoleDTO: TAclRoleDTO): TAclRole;
var
  lAclRole: TAclRole;
begin
  // Mapear campos por JSON
  lAclRole := TAclRole.FromJSON(AAclRoleDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lAclRole;
end;

end.
