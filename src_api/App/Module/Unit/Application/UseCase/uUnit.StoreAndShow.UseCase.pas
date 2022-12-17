unit uUnit.StoreAndShow.UseCase;

interface

uses
  uUnit.DTO,
  uUnit.Show.DTO,
  uUnit.Repository.Interfaces;

type
  IUnitStoreAndShowUseCase = Interface
    ['{E5DA7F69-83B7-4C20-AF63-4D43EA9B01A0}']
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
  XSuperObject;

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
  lUnitToStore := TUnit.FromJSON(AInput.AsJSON);
  lUnitToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lUnitToStore);
  lUnitStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TUnitShowDTO.FromEntity(lUnitStored.Value);
end;

class function TUnitStoreAndShowUseCase.Make(ARepository: IUnitRepository): IUnitStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
