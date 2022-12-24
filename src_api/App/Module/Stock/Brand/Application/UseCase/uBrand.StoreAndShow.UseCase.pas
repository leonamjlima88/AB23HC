unit uBrand.StoreAndShow.UseCase;

interface

uses
  uBrand.DTO,
  uBrand.Show.DTO,
  uBrand.Repository.Interfaces;

type
  IBrandStoreAndShowUseCase = Interface
    ['{D8E1A50E-0B58-4461-9104-5C11033BBB97}']
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
  XSuperObject,
  uBrand.Mapper;

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
  lBrandToStore := TBrandMapper.BrandDtoToEntity(AInput);
  lBrandToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK          := FRepository.Store(lBrandToStore);
  lBrandStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TBrandMapper.EntityToBrandShowDto(lBrandStored);
end;

class function TBrandStoreAndShowUseCase.Make(ARepository: IBrandRepository): IBrandStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
