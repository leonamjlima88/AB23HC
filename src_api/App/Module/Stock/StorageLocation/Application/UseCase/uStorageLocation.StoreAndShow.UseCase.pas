unit uStorageLocation.StoreAndShow.UseCase;

interface

uses
  uStorageLocation.DTO,
  uStorageLocation.Show.DTO,
  uStorageLocation.Repository.Interfaces;

type
  IStorageLocationStoreAndShowUseCase = Interface
    ['{BF6AF532-78EF-40CA-AFB1-326ED9B039C1}']
    function Execute(AInput: TStorageLocationDTO): TStorageLocationShowDTO;
  end;

  TStorageLocationStoreAndShowUseCase = class(TInterfacedObject, IStorageLocationStoreAndShowUseCase)
  private
    FRepository: IStorageLocationRepository;
    constructor Create(ARepository: IStorageLocationRepository);
  public
    class function Make(ARepository: IStorageLocationRepository): IStorageLocationStoreAndShowUseCase;
    function Execute(AInput: TStorageLocationDTO): TStorageLocationShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uStorageLocation,
  uStorageLocation.Mapper;

{ TStorageLocationStoreAndShowUseCase }

constructor TStorageLocationStoreAndShowUseCase.Create(ARepository: IStorageLocationRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TStorageLocationStoreAndShowUseCase.Execute(AInput: TStorageLocationDTO): TStorageLocationShowDTO;
var
  lStorageLocationToStore: Shared<TStorageLocation>;
  lStorageLocationStored: Shared<TStorageLocation>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lStorageLocationToStore := TStorageLocationMapper.StorageLocationDtoToEntity(AInput);
  lStorageLocationToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lStorageLocationToStore);
  lStorageLocationStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TStorageLocationMapper.EntityToStorageLocationShowDto(lStorageLocationStored);
end;

class function TStorageLocationStoreAndShowUseCase.Make(ARepository: IStorageLocationRepository): IStorageLocationStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
