unit uAclUser.Mapper;

interface

uses
  uMapper.Interfaces,
  uAclUser,
  uAclUser.DTO,
  uAclUser.Show.DTO;

type
  TAclUserMapper = class(TInterfacedObject, IMapper)
  public
    class function AclUserDtoToEntity(AAclUserDTO: TAclUserDTO): TAclUser;
    class function EntityToAclUserShowDto(AAclUser: TAclUser): TAclUserShowDTO;
  end;

implementation

uses
  XSuperObject;

{ TAclUserMapper }

class function TAclUserMapper.EntityToAclUserShowDto(AAclUser: TAclUser): TAclUserShowDTO;
var
  lAclUserShowDTO: TAclUserShowDTO;
begin
  // Mapear campos por JSON
  lAclUserShowDTO := TAclUserShowDTO.FromJSON(AAclUser.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lAclUserShowDTO;
end;

class function TAclUserMapper.AclUserDtoToEntity(AAclUserDTO: TAclUserDTO): TAclUser;
var
  lAclUser: TAclUser;
begin
  // Mapear campos por JSON
  lAclUser := TAclUser.FromJSON(AAclUserDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lAclUser;
end;

end.
