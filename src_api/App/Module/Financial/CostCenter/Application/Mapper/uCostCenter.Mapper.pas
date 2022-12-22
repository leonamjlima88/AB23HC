unit uCostCenter.Mapper;

interface

uses
  uMapper.Interfaces,
  uCostCenter,
  uCostCenter.DTO,
  uCostCenter.Show.DTO;

type
  TCostCenterMapper = class(TInterfacedObject, IMapper)
  public
    class function CostCenterDtoToEntity(ACostCenterDTO: TCostCenterDTO): TCostCenter;
    class function EntityToCostCenterShowDto(ACostCenter: TCostCenter): TCostCenterShowDTO;
  end;

implementation

uses
  XSuperObject;

{ TCostCenterMapper }

class function TCostCenterMapper.EntityToCostCenterShowDto(ACostCenter: TCostCenter): TCostCenterShowDTO;
var
  lCostCenterShowDTO: TCostCenterShowDTO;
begin
  // Mapear campos por JSON
  lCostCenterShowDTO := TCostCenterShowDTO.FromJSON(ACostCenter.AsJSON);

  // Tratar campos específicos
  lCostCenterShowDTO.created_by_acl_user_name := ACostCenter.created_by_acl_user.name;
  lCostCenterShowDTO.updated_by_acl_user_name := ACostCenter.updated_by_acl_user.name;

  Result := lCostCenterShowDTO;
end;

class function TCostCenterMapper.CostCenterDtoToEntity(ACostCenterDTO: TCostCenterDTO): TCostCenter;
var
  lCostCenter: TCostCenter;
begin
  // Mapear campos por JSON
  lCostCenter := TCostCenter.FromJSON(ACostCenterDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lCostCenter;
end;

end.
