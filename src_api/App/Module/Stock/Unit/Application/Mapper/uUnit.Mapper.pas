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
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TUnitMapper }

class function TUnitMapper.EntityToUnitShowDto(AUnit: TUnit): TUnitShowDTO;
var
  lUnitShowDTO: TUnitShowDTO;
begin
  if not Assigned(AUnit) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lUnitShowDTO := TUnitShowDTO.FromJSON(AUnit.AsJSON);

  // Tratar campos espec�ficos
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

  // Tratar campos espec�ficos
  // ...

  Result := lUnit;
end;

end.
