unit uBrand.UpdateAndShow.UseCase;

interface

uses
  uBrand.DTO,
  uBrand.Show.DTO,
  uBrand.Repository.Interfaces;

type
  IBrandUpdateAndShowUseCase = Interface
    ['{D92E72A1-E818-4496-B76C-6AECC7C1B870}']
    function Execute(AInput: TBrandDTO; APK: Int64): TBrandShowDTO;
  end;

  TBrandUpdateAndShowUseCase = class(TInterfacedObject, IBrandUpdateAndShowUseCase)
  private
    FRepository: IBrandRepository;
    constructor Create(ARepository: IBrandRepository);
  public
    class function Make(ARepository: IBrandRepository): IBrandUpdateAndShowUseCase;
    function Execute(AInput: TBrandDTO; APK: Int64): TBrandShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uBrand,
  XSuperObject,
  System.SysUtils;

{ TBrandUpdateAndShowUseCase }

constructor TBrandUpdateAndShowUseCase.Create(ARepository: IBrandRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBrandUpdateAndShowUseCase.Execute(AInput: TBrandDTO; APK: Int64): TBrandShowDTO;
var
  lBrandToUpdate: Shared<TBrand>;
  lBrandUpdated: Shared<TBrand>;
begin
  // Carregar dados em Entity
  lBrandToUpdate := TBrand.FromJSON(AInput.AsJSON);
  With lBrandToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lBrandToUpdate, APK);
  lBrandUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TBrandShowDTO.FromEntity(lBrandUpdated.Value);
end;

class function TBrandUpdateAndShowUseCase.Make(ARepository: IBrandRepository): IBrandUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
