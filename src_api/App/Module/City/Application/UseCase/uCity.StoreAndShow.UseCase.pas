unit uCity.StoreAndShow.UseCase;

interface

uses
  uCity.DTO,
  uCity.Show.DTO,
  uCity.Repository.Interfaces;

type
  ICityStoreAndShowUseCase = Interface
    ['{E5DA7F69-83B7-4C20-AF63-4D43EA9B01A0}']
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
  XSuperObject;

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
  lCityToStore := TCity.FromJSON(AInput.AsJSON);
  lCityToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lCityToStore);

  // Localizar Registro
  lCityStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TCityShowDTO.FromEntity(lCityStored.Value);
end;

class function TCityStoreAndShowUseCase.Make(ARepository: ICityRepository): ICityStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
