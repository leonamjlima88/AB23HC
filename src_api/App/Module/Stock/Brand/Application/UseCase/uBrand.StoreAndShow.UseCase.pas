unit uBrand.StoreAndShow.UseCase;

interface

uses
  uBrand.DTO,
  uBrand.Show.DTO,
  uBrand.Repository.Interfaces;

type
  IBrandStoreAndShowUseCase = Interface
    ['{E5DA7F69-83B7-4C20-AF63-4D43EA9B01A0}']
    function Execute(AInput: TBrandDTO): TBrandShowDTO;
  end;

  TBrandStoreAndShowUseCase = class(TInterfacedObject, IBrandStoreAndShowUseCase)
  private
    FRepository: IBrandRepository;
    constructor Create(ARepository: IBrandRepository);
  public
    class function Make(ARepository: IBrandRepository): IBrandStoreAndShowUseCase;
    function Execute(AInput: TBrandDTO): TBrandShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uBrand,
  XSuperObject;

{ TBrandStoreAndShowUseCase }

constructor TBrandStoreAndShowUseCase.Create(ARepository: IBrandRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBrandStoreAndShowUseCase.Execute(AInput: TBrandDTO): TBrandShowDTO;
var
  lBrandToStore: Shared<TBrand>;
  lBrandStored: Shared<TBrand>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lBrandToStore := TBrand.FromJSON(AInput.AsJSON);
  lBrandToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lBrandToStore);
  lBrandStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TBrandShowDTO.FromEntity(lBrandStored.Value);
end;

class function TBrandStoreAndShowUseCase.Make(ARepository: IBrandRepository): IBrandStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
