unit uStorageLocation.UpdateAndShow.UseCase;

interface

uses
  uStorageLocation.DTO,
  uStorageLocation.Show.DTO,
  uStorageLocation.Repository.Interfaces;

type
  IStorageLocationUpdateAndShowUseCase = Interface
    ['{2537BB66-AF57-4B53-BA41-9A5CF02EFC29}']
    function Execute(AInput: TStorageLocationDTO; APK: Int64): TStorageLocationShowDTO;
  end;

  TStorageLocationUpdateAndShowUseCase = class(TInterfacedObject, IStorageLocationUpdateAndShowUseCase)
  private
    FRepository: IStorageLocationRepository;
    constructor Create(ARepository: IStorageLocationRepository);
  public
    class function Make(ARepository: IStorageLocationRepository): IStorageLocationUpdateAndShowUseCase;
    function Execute(AInput: TStorageLocationDTO; APK: Int64): TStorageLocationShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uStorageLocation,
  XSuperObject,
  System.SysUtils;

{ TStorageLocationUpdateAndShowUseCase }

constructor TStorageLocationUpdateAndShowUseCase.Create(ARepository: IStorageLocationRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TStorageLocationUpdateAndShowUseCase.Execute(AInput: TStorageLocationDTO; APK: Int64): TStorageLocationShowDTO;
var
  lStorageLocationToUpdate: Shared<TStorageLocation>;
  lStorageLocationUpdated: Shared<TStorageLocation>;
begin
  // Carregar dados em Entity
  lStorageLocationToUpdate := TStorageLocation.FromJSON(AInput.AsJSON);
  With lStorageLocationToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lStorageLocationToUpdate, APK);
  lStorageLocationUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TStorageLocationShowDTO.FromEntity(lStorageLocationUpdated.Value);
end;

class function TStorageLocationUpdateAndShowUseCase.Make(ARepository: IStorageLocationRepository): IStorageLocationUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
