unit uStorageLocation.UpdateAndShow.UseCase;

interface

uses
  uStorageLocation.DTO,
  uStorageLocation.Show.DTO,
  uStorageLocation.Repository.Interfaces;

type
  IStorageLocationUpdateAndShowUseCase = Interface
['{724ED545-B96B-484B-9A53-09BC99AF27A7}']
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
  System.SysUtils,
  uStorageLocation.Mapper;

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
  lStorageLocationToUpdate := TStorageLocationMapper.StorageLocationDtoToEntity(AInput);
  With lStorageLocationToUpdate.Value do
  begin
    id := APK;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lStorageLocationToUpdate, APK);
  lStorageLocationUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TStorageLocationMapper.EntityToStorageLocationShowDto(lStorageLocationUpdated);
end;

class function TStorageLocationUpdateAndShowUseCase.Make(ARepository: IStorageLocationRepository): IStorageLocationUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
