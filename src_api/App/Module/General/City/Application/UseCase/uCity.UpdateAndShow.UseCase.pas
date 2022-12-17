unit uCity.UpdateAndShow.UseCase;

interface

uses
  uCity.DTO,
  uCity.Show.DTO,
  uCity.Repository.Interfaces;

type
  ICityUpdateAndShowUseCase = Interface
    ['{2537BB66-AF57-4B53-BA41-9A5CF02EFC29}']
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
  XSuperObject,
  System.SysUtils;

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
  lCityToUpdate := TCity.FromJSON(AInput.AsJSON);
  With lCityToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lCityToUpdate, APK);
  lCityUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TCityShowDTO.FromEntity(lCityUpdated.Value);
end;

class function TCityUpdateAndShowUseCase.Make(ARepository: ICityRepository): ICityUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
