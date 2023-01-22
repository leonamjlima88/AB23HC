unit uTenant.Mapper;

interface

uses
  uMapper.Interfaces,
  uTenant,
  uTenant.DTO,
  uTenant.Show.DTO;

type
  TTenantMapper = class(TInterfacedObject, IMapper)
  public
    class function TenantDtoToEntity(ATenantDTO: TTenantDTO): TTenant;
    class function EntityToTenantShowDto(ATenant: TTenant): TTenantShowDTO;
  end;

implementation

uses
  XSuperObject,
  uLegalEntityNumber.VO,
  System.SysUtils,
  uApplication.Types;

{ TTenantMapper }

class function TTenantMapper.EntityToTenantShowDto(ATenant: TTenant): TTenantShowDTO;
var
  lTenantShowDTO: TTenantShowDTO;
begin
  if not Assigned(ATenant) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lTenantShowDTO := TTenantShowDTO.FromJSON(ATenant.AsJSON);

  // Tratar campos específicos
  lTenantShowDTO.legal_entity_number      := ATenant.legal_entity_number.Value;
  lTenantShowDTO.city_name                := ATenant.city.name;
  lTenantShowDTO.city_state               := ATenant.city.state;
  lTenantShowDTO.city_ibge_code           := ATenant.city.ibge_code;

  Result := lTenantShowDTO;
end;

class function TTenantMapper.TenantDtoToEntity(ATenantDTO: TTenantDTO): TTenant;
var
  lTenant: TTenant;
begin
  // Mapear campos por JSON
  lTenant := TTenant.FromJSON(ATenantDTO.AsJSON);

  // Tratar campos específicos
  lTenant.legal_entity_number := TLegalEntityNumberVO.Make(ATenantDTO.legal_entity_number);

  Result := lTenant;
end;

end.
