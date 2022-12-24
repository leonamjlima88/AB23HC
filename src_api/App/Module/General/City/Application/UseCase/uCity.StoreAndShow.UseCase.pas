unit uCity.StoreAndShow.UseCase;

interface

uses
  uCity.DTO,
  uCity.Show.DTO,
  uCity.Repository.Interfaces;

type
  ICityStoreAndShowUseCase = Interface
['{3FB5A7AE-FB53-4FA7-AE78-9DD3DF500BC9}']
    function Execute(AInput: TCityDTO): TCityShowDTO;
  end;

  TCityStoreAndShowUseCase = class(TInterfacedObject, ICityStoreAndShowUseCase)
  private
    FRepository: ICityRepository;
    constructor Create(ARepository: ICityRepository);
  public
    class function Make(ARepository: ICityRepository): ICityStoreAndShowUseCase;
    function Execute(AInput: TCityDTO): TCityShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCity,
  uCity.Mapper;

{ TCityStoreAndShowUseCase }

constructor TCityStoreAndShowUseCase.Create(ARepository: ICityRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCityStoreAndShowUseCase.Execute(AInput: TCityDTO): TCityShowDTO;
var
  lCityToStore: Shared<TCity>;
  lCityStored: Shared<TCity>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lCityToStore := TCityMapper.CityDtoToEntity(AInput);
  lCityToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK         := FRepository.Store(lCityToStore);
  lCityStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TCityMapper.EntityToCityShowDto(lCityStored);
end;

class function TCityStoreAndShowUseCase.Make(ARepository: ICityRepository): ICityStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
