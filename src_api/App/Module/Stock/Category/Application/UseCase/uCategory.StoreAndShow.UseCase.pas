unit uCategory.StoreAndShow.UseCase;

interface

uses
  uCategory.DTO,
  uCategory.Show.DTO,
  uCategory.Repository.Interfaces;

type
  ICategoryStoreAndShowUseCase = Interface
    ['{D5E005F8-0744-490C-A817-D781268001C3}']
    function Execute(AInput: TCategoryDTO): TCategoryShowDTO;
  end;

  TCategoryStoreAndShowUseCase = class(TInterfacedObject, ICategoryStoreAndShowUseCase)
  private
    FRepository: ICategoryRepository;
    constructor Create(ARepository: ICategoryRepository);
  public
    class function Make(ARepository: ICategoryRepository): ICategoryStoreAndShowUseCase;
    function Execute(AInput: TCategoryDTO): TCategoryShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCategory,
  uCategory.Mapper;

{ TCategoryStoreAndShowUseCase }

constructor TCategoryStoreAndShowUseCase.Create(ARepository: ICategoryRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCategoryStoreAndShowUseCase.Execute(AInput: TCategoryDTO): TCategoryShowDTO;
var
  lCategoryToStore: Shared<TCategory>;
  lCategoryStored: Shared<TCategory>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lCategoryToStore := TCategoryMapper.CategoryDtoToEntity(AInput);
  lCategoryToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK             := FRepository.Store(lCategoryToStore);
  lCategoryStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TCategoryMapper.EntityToCategoryShowDto(lCategoryStored);
end;

class function TCategoryStoreAndShowUseCase.Make(ARepository: ICategoryRepository): ICategoryStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
