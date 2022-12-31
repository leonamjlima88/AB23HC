unit uStorageLocation.Mapper;

interface

uses
  uMapper.Interfaces,
  uStorageLocation,
  uStorageLocation.DTO,
  uStorageLocation.Show.DTO;

type
  TStorageLocationMapper = class(TInterfacedObject, IMapper)
  public
    class function StorageLocationDtoToEntity(AStorageLocationDTO: TStorageLocationDTO): TStorageLocation;
    class function EntityToStorageLocationShowDto(AStorageLocation: TStorageLocation): TStorageLocationShowDTO;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TStorageLocationMapper }

class function TStorageLocationMapper.EntityToStorageLocationShowDto(AStorageLocation: TStorageLocation): TStorageLocationShowDTO;
var
  lStorageLocationShowDTO: TStorageLocationShowDTO;
begin
  if not Assigned(AStorageLocation) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lStorageLocationShowDTO := TStorageLocationShowDTO.FromJSON(AStorageLocation.AsJSON);

  // Tratar campos específicos
  lStorageLocationShowDTO.created_by_acl_user_name := AStorageLocation.created_by_acl_user.name;
  lStorageLocationShowDTO.updated_by_acl_user_name := AStorageLocation.updated_by_acl_user.name;

  Result := lStorageLocationShowDTO;
end;

class function TStorageLocationMapper.StorageLocationDtoToEntity(AStorageLocationDTO: TStorageLocationDTO): TStorageLocation;
var
  lStorageLocation: TStorageLocation;
begin
  // Mapear campos por JSON
  lStorageLocation := TStorageLocation.FromJSON(AStorageLocationDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lStorageLocation;
end;

end.
