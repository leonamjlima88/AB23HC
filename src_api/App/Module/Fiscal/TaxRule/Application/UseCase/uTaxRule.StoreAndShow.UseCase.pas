unit uTaxRule.StoreAndShow.UseCase;

interface

uses
  uTaxRule.DTO,
  uTaxRule.Show.DTO,
  uTaxRule.Repository.Interfaces;

type
  ITaxRuleStoreAndShowUseCase = Interface
    ['{F03C37BA-9320-47D8-A0E1-7F93F88DAF73}']
    function Execute(AInput: TTaxRuleDTO): TTaxRuleShowDTO;
  end;

  TTaxRuleStoreAndShowUseCase = class(TInterfacedObject, ITaxRuleStoreAndShowUseCase)
  private
    FRepository: ITaxRuleRepository;
    constructor Create(ARepository: ITaxRuleRepository);
  public
    class function Make(ARepository: ITaxRuleRepository): ITaxRuleStoreAndShowUseCase;
    function Execute(AInput: TTaxRuleDTO): TTaxRuleShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uTaxRule,
  uTaxRule.Mapper;

{ TTaxRuleStoreAndShowUseCase }

constructor TTaxRuleStoreAndShowUseCase.Create(ARepository: ITaxRuleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TTaxRuleStoreAndShowUseCase.Execute(AInput: TTaxRuleDTO): TTaxRuleShowDTO;
var
  lTaxRuleToStore: Shared<TTaxRule>;
  lTaxRuleStored: Shared<TTaxRule>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lTaxRuleToStore := TTaxRuleMapper.TaxRuleDtoToEntity(AInput);
  lTaxRuleToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lTaxRuleToStore, true);
  lTaxRuleStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TTaxRuleMapper.EntityToTaxRuleShowDto(lTaxRuleStored);
end;

class function TTaxRuleStoreAndShowUseCase.Make(ARepository: ITaxRuleRepository): ITaxRuleStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
