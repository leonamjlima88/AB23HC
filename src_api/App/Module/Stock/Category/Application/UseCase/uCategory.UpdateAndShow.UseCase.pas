unit uCategory.UpdateAndShow.UseCase;

interface

uses
  uCategory.DTO,
  uCategory.Show.DTO,
  uCategory.Repository.Interfaces;

type
  ICategoryUpdateAndShowUseCase = Interface
    ['{B7A96BC0-0117-48D5-AD71-15E3F5F02B5B}']
    function Execute(AInput: TCategoryDTO; APK: Int64): TCategoryShowDTO;
  end;

  TCategoryUpdateAndShowUseCase = class(TInterfacedObject, ICategoryUpdateAndShowUseCase)
  private
    FRepository: ICategoryRepository;
    constructor Create(ARepository: ICategoryRepository);
  public
    class function Make(ARepository: ICategoryRepository): ICategoryUpdateAndShowUseCase;
    function Execute(AInput: TCategoryDTO; APK: Int64): TCategoryShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCategory,
  System.SysUtils,
  uCategory.Mapper;

{ TCategoryUpdateAndShowUseCase }

constructor TCategoryUpdateAndShowUseCase.Create(ARepository: ICategoryRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCategoryUpdateAndShowUseCase.Execute(AInput: TCategoryDTO; APK: Int64): TCategoryShowDTO;
var
  lCategoryToUpdate: Shared<TCategory>;
  lCategoryUpdated: Shared<TCategory>;
begin
  // Carregar dados em Entity
  lCategoryToUpdate := TCategoryMapper.CategoryDtoToEntity(AInput);
  With lCategoryToUpdate.Value do
  begin
    id := APK;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lCategoryToUpdate, APK);
  lCategoryUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TCategoryMapper.EntityToCategoryShowDto(lCategoryUpdated);
end;

class function TCategoryUpdateAndShowUseCase.Make(ARepository: ICategoryRepository): ICategoryUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
