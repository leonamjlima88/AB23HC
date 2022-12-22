unit uCostCenter.StoreAndShow.UseCase;

interface

uses
  uCostCenter.DTO,
  uCostCenter.Show.DTO,
  uCostCenter.Repository.Interfaces;

type
  ICostCenterStoreAndShowUseCase = Interface
['{FF5935BF-A3C5-414D-A4C5-F855DFB21A91}']
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
  uCostCenter.Mapper;

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
  lCostCenterToStore := TCostCenterMapper.CostCenterDtoToEntity(AInput);
  lCostCenterToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lCostCenterToStore);
  lCostCenterStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TCostCenterMapper.EntityToCostCenterShowDto(lCostCenterStored);
end;

class function TCostCenterStoreAndShowUseCase.Make(ARepository: ICostCenterRepository): ICostCenterStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
