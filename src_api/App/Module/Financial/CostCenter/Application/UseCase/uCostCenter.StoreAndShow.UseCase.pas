unit uCostCenter.StoreAndShow.UseCase;

interface

uses
  uCostCenter.DTO,
  uCostCenter.Show.DTO,
  uCostCenter.Repository.Interfaces;

type
  ICostCenterStoreAndShowUseCase = Interface
    ['{E5DA7F69-83B7-4C20-AF63-4D43EA9B01A0}']
    function Execute(AInput: TCostCenterDTO): TCostCenterShowDTO;
  end;

  TCostCenterStoreAndShowUseCase = class(TInterfacedObject, ICostCenterStoreAndShowUseCase)
  private
    FRepository: ICostCenterRepository;
    constructor Create(ARepository: ICostCenterRepository);
  public
    class function Make(ARepository: ICostCenterRepository): ICostCenterStoreAndShowUseCase;
    function Execute(AInput: TCostCenterDTO): TCostCenterShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCostCenter,
  XSuperObject;

{ TCostCenterStoreAndShowUseCase }

constructor TCostCenterStoreAndShowUseCase.Create(ARepository: ICostCenterRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCostCenterStoreAndShowUseCase.Execute(AInput: TCostCenterDTO): TCostCenterShowDTO;
var
  lCostCenterToStore: Shared<TCostCenter>;
  lCostCenterStored: Shared<TCostCenter>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lCostCenterToStore := TCostCenter.FromJSON(AInput.AsJSON);
  lCostCenterToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lCostCenterToStore);
  lCostCenterStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TCostCenterShowDTO.FromEntity(lCostCenterStored.Value);
end;

class function TCostCenterStoreAndShowUseCase.Make(ARepository: ICostCenterRepository): ICostCenterStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
