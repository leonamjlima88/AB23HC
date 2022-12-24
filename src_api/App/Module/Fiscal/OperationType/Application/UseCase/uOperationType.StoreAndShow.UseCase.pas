unit uOperationType.StoreAndShow.UseCase;

interface

uses
  uOperationType.DTO,
  uOperationType.Show.DTO,
  uOperationType.Repository.Interfaces;

type
  IOperationTypeStoreAndShowUseCase = Interface
    ['{D8E1A50E-0B58-4461-9104-5C11033BBB97}']
    function Execute(AInput: TOperationTypeDTO): TOperationTypeShowDTO;
  end;

  TOperationTypeStoreAndShowUseCase = class(TInterfacedObject, IOperationTypeStoreAndShowUseCase)
  private
    FRepository: IOperationTypeRepository;
    constructor Create(ARepository: IOperationTypeRepository);
  public
    class function Make(ARepository: IOperationTypeRepository): IOperationTypeStoreAndShowUseCase;
    function Execute(AInput: TOperationTypeDTO): TOperationTypeShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uOperationType,
  uOperationType.Mapper;

{ TOperationTypeStoreAndShowUseCase }

constructor TOperationTypeStoreAndShowUseCase.Create(ARepository: IOperationTypeRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TOperationTypeStoreAndShowUseCase.Execute(AInput: TOperationTypeDTO): TOperationTypeShowDTO;
var
  lOperationTypeToStore: Shared<TOperationType>;
  lOperationTypeStored: Shared<TOperationType>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lOperationTypeToStore := TOperationTypeMapper.OperationTypeDtoToEntity(AInput);
  lOperationTypeToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK                  := FRepository.Store(lOperationTypeToStore);
  lOperationTypeStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TOperationTypeMapper.EntityToOperationTypeShowDto(lOperationTypeStored);
end;

class function TOperationTypeStoreAndShowUseCase.Make(ARepository: IOperationTypeRepository): IOperationTypeStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
