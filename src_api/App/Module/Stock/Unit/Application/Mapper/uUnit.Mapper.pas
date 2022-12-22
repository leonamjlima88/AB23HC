unit uUnit.Mapper;

interface

uses
  uMapper.Interfaces,
  uUnit,
  uUnit.DTO,
  uUnit.Show.DTO;

type
  TUnitMapper = class(TInterfacedObject, IMapper)
  public
    class function UnitDtoToEntity(AUnitDTO: TUnitDTO): TUnit;
    class function EntityToUnitShowDto(AUnit: TUnit): TUnitShowDTO;
  end;

implementation

uses
  XSuperObject;

{ TUnitMapper }

class function TUnitMapper.EntityToUnitShowDto(AUnit: TUnit): TUnitShowDTO;
var
  lUnitShowDTO: TUnitShowDTO;
begin
  // Mapear campos por JSON
  lUnitShowDTO := TUnitShowDTO.FromJSON(AUnit.AsJSON);

  // Tratar campos específicos
  lUnitShowDTO.created_by_acl_user_name := AUnit.created_by_acl_user.name;
  lUnitShowDTO.updated_by_acl_user_name := AUnit.updated_by_acl_user.name;

  Result := lUnitShowDTO;
end;

class function TUnitMapper.UnitDtoToEntity(AUnitDTO: TUnitDTO): TUnit;
var
  lUnit: TUnit;
begin
  // Mapear campos por JSON
  lUnit := TUnit.FromJSON(AUnitDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lUnit;
end;

end.
