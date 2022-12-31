unit uCity.UpdateAndShow.UseCase;

interface

uses
  uCity.DTO,
  uCity.Show.DTO,
  uCity.Repository.Interfaces;

type
  ICityUpdateAndShowUseCase = Interface
['{1F570FC7-BBC9-4192-8B27-CA2F0EF0F884}']
    function Execute(AInput: TCityDTO; APK: Int64): TCityShowDTO;
  end;

  TCityUpdateAndShowUseCase = class(TInterfacedObject, ICityUpdateAndShowUseCase)
  private
    FRepository: ICityRepository;
    constructor Create(ARepository: ICityRepository);
  public
    class function Make(ARepository: ICityRepository): ICityUpdateAndShowUseCase;
    function Execute(AInput: TCityDTO; APK: Int64): TCityShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCity,
  System.SysUtils,
  uCity.Mapper;

{ TCityUpdateAndShowUseCase }

constructor TCityUpdateAndShowUseCase.Create(ARepository: ICityRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCityUpdateAndShowUseCase.Execute(AInput: TCityDTO; APK: Int64): TCityShowDTO;
var
  lCityToUpdate: Shared<TCity>;
  lCityUpdated: Shared<TCity>;
begin
  // Carregar dados em Entity
  lCityToUpdate := TCityMapper.CityDtoToEntity(AInput);
  With lCityToUpdate.Value do
  begin
    id := APK;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lCityToUpdate, APK);
  lCityUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TCityMapper.EntityToCityShowDto(lCityUpdated);
end;

class function TCityUpdateAndShowUseCase.Make(ARepository: ICityRepository): ICityUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
