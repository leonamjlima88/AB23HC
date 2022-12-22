unit uCity.Mapper;

interface

uses
  uMapper.Interfaces,
  uCity,
  uCity.DTO,
  uCity.Show.DTO;

type
  TCityMapper = class(TInterfacedObject, IMapper)
  public
    class function CityDtoToEntity(ACityDTO: TCityDTO): TCity;
    class function EntityToCityShowDto(ACity: TCity): TCityShowDTO;
  end;

implementation

uses
  XSuperObject;

{ TCityMapper }

class function TCityMapper.EntityToCityShowDto(ACity: TCity): TCityShowDTO;
var
  lCityShowDTO: TCityShowDTO;
begin
  // Mapear campos por JSON
  lCityShowDTO := TCityShowDTO.FromJSON(ACity.AsJSON);

  // Tratar campos específicos
  lCityShowDTO.created_by_acl_user_name := ACity.created_by_acl_user.name;
  lCityShowDTO.updated_by_acl_user_name := ACity.updated_by_acl_user.name;

  Result := lCityShowDTO;
end;

class function TCityMapper.CityDtoToEntity(ACityDTO: TCityDTO): TCity;
var
  lCity: TCity;
begin
  // Mapear campos por JSON
  lCity := TCity.FromJSON(ACityDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lCity;
end;

end.
