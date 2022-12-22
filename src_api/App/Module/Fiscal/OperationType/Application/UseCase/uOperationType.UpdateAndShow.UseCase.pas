unit uOperationType.UpdateAndShow.UseCase;

interface

uses
  uOperationType.DTO,
  uOperationType.Show.DTO,
  uOperationType.Repository.Interfaces;

type
  IOperationTypeUpdateAndShowUseCase = Interface
    ['{D92E72A1-E818-4496-B76C-6AECC7C1B870}']
    function Execute(AInput: TOperationTypeDTO; APK: Int64): TOperationTypeShowDTO;
  end;

  TOperationTypeUpdateAndShowUseCase = class(TInterfacedObject, IOperationTypeUpdateAndShowUseCase)
  private
    FRepository: IOperationTypeRepository;
    constructor Create(ARepository: IOperationTypeRepository);
  public
    class function Make(ARepository: IOperationTypeRepository): IOperationTypeUpdateAndShowUseCase;
    function Execute(AInput: TOperationTypeDTO; APK: Int64): TOperationTypeShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uOperationType,
  System.SysUtils,
  uOperationType.Mapper;

{ TOperationTypeUpdateAndShowUseCase }

constructor TOperationTypeUpdateAndShowUseCase.Create(ARepository: IOperationTypeRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TOperationTypeUpdateAndShowUseCase.Execute(AInput: TOperationTypeDTO; APK: Int64): TOperationTypeShowDTO;
var
  lOperationTypeToUpdate: Shared<TOperationType>;
  lOperationTypeUpdated: Shared<TOperationType>;
begin
  // Carregar dados em Entity
  lOperationTypeToUpdate := TOperationTypeMapper.OperationTypeDtoToEntity(AInput);
  With lOperationTypeToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lOperationTypeToUpdate, APK);
  lOperationTypeUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TOperationTypeMapper.EntityToOperationTypeShowDto(lOperationTypeUpdated);
end;

class function TOperationTypeUpdateAndShowUseCase.Make(ARepository: IOperationTypeRepository): IOperationTypeUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
