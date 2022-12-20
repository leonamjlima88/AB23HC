unit uTaxRule.UpdateAndShow.UseCase;

interface

uses
  uTaxRule.DTO,
  uTaxRule.Show.DTO,
  uTaxRule.Repository.Interfaces;

type
  ITaxRuleUpdateAndShowUseCase = Interface
['{89480FD9-7684-44D1-9AE6-F691DA1323A1}']
    function Execute(AInput: TTaxRuleDTO; APK: Int64): TTaxRuleShowDTO;
  end;

  TTaxRuleUpdateAndShowUseCase = class(TInterfacedObject, ITaxRuleUpdateAndShowUseCase)
  private
    FRepository: ITaxRuleRepository;
    constructor Create(ARepository: ITaxRuleRepository);
  public
    class function Make(ARepository: ITaxRuleRepository): ITaxRuleUpdateAndShowUseCase;
    function Execute(AInput: TTaxRuleDTO; APK: Int64): TTaxRuleShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uTaxRule,
  XSuperObject,
  System.SysUtils;

{ TTaxRuleUpdateAndShowUseCase }

constructor TTaxRuleUpdateAndShowUseCase.Create(ARepository: ITaxRuleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TTaxRuleUpdateAndShowUseCase.Execute(AInput: TTaxRuleDTO; APK: Int64): TTaxRuleShowDTO;
var
  lTaxRuleToUpdate: Shared<TTaxRule>;
  lTaxRuleUpdated: Shared<TTaxRule>;
begin
  // Carregar dados em Entity
  lTaxRuleToUpdate := TTaxRule.FromJSON(AInput.AsJSON);
  With lTaxRuleToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lTaxRuleToUpdate, APK, true);
  lTaxRuleUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TTaxRuleShowDTO.FromEntity(lTaxRuleUpdated.Value);
end;

class function TTaxRuleUpdateAndShowUseCase.Make(ARepository: ITaxRuleRepository): ITaxRuleUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
