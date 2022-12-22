unit uUnit.StoreAndShow.UseCase;

interface

uses
  uUnit.DTO,
  uUnit.Show.DTO,
  uUnit.Repository.Interfaces;

type
  IUnitStoreAndShowUseCase = Interface
['{CB94C184-08EB-460D-A4E3-B69FB400687A}']
    function Execute(AInput: TUnitDTO): TUnitShowDTO;
  end;

  TUnitStoreAndShowUseCase = class(TInterfacedObject, IUnitStoreAndShowUseCase)
  private
    FRepository: IUnitRepository;
    constructor Create(ARepository: IUnitRepository);
  public
    class function Make(ARepository: IUnitRepository): IUnitStoreAndShowUseCase;
    function Execute(AInput: TUnitDTO): TUnitShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uUnit,
  uUnit.Mapper;

{ TUnitStoreAndShowUseCase }

constructor TUnitStoreAndShowUseCase.Create(ARepository: IUnitRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TUnitStoreAndShowUseCase.Execute(AInput: TUnitDTO): TUnitShowDTO;
var
  lUnitToStore: Shared<TUnit>;
  lUnitStored: Shared<TUnit>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lUnitToStore := TUnitMapper.UnitDtoToEntity(AInput);
  lUnitToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lUnitToStore);
  lUnitStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TUnitMapper.EntityToUnitShowDto(lUnitStored);
end;

class function TUnitStoreAndShowUseCase.Make(ARepository: IUnitRepository): IUnitStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
