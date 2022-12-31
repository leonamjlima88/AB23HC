unit uOperationType.Mapper;

interface

uses
  uMapper.Interfaces,
  uOperationType,
  uOperationType.DTO,
  uOperationType.Show.DTO;

type
  TOperationTypeMapper = class(TInterfacedObject, IMapper)
  public
    class function OperationTypeDtoToEntity(AOperationTypeDTO: TOperationTypeDTO): TOperationType;
    class function EntityToOperationTypeShowDto(AOperationType: TOperationType): TOperationTypeShowDTO;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TOperationTypeMapper }

class function TOperationTypeMapper.EntityToOperationTypeShowDto(AOperationType: TOperationType): TOperationTypeShowDTO;
var
  lOperationTypeShowDTO: TOperationTypeShowDTO;
begin
  if not Assigned(AOperationType) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lOperationTypeShowDTO := TOperationTypeShowDTO.FromJSON(AOperationType.AsJSON);

  // Tratar campos específicos
  lOperationTypeShowDTO.created_by_acl_user_name := AOperationType.created_by_acl_user.name;
  lOperationTypeShowDTO.updated_by_acl_user_name := AOperationType.updated_by_acl_user.name;

  Result := lOperationTypeShowDTO;
end;

class function TOperationTypeMapper.OperationTypeDtoToEntity(AOperationTypeDTO: TOperationTypeDTO): TOperationType;
var
  lOperationType: TOperationType;
begin
  // Mapear campos por JSON
  lOperationType := TOperationType.FromJSON(AOperationTypeDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lOperationType;
end;

end.
