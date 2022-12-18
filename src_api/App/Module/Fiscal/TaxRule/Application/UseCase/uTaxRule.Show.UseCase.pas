unit uTaxRule.Show.UseCase;

interface

uses
  uTaxRule.Repository.Interfaces,
  uTaxRule.Show.DTO;

type
  ITaxRuleShowUseCase = Interface
    ['{98591DAC-EFA1-48B3-B656-A60B2BDB55BA}']
    function Execute(APK: Int64): TTaxRuleShowDTO;
  end;

  TTaxRuleShowUseCase = class(TInterfacedObject, ITaxRuleShowUseCase)
  private
    FRepository: ITaxRuleRepository;
    constructor Create(ARepository: ITaxRuleRepository);
  public
    class function Make(ARepository: ITaxRuleRepository): ITaxRuleShowUseCase;
    function Execute(APK: Int64): TTaxRuleShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uTaxRule,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TTaxRuleShowUseCase }

constructor TTaxRuleShowUseCase.Create(ARepository: ITaxRuleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TTaxRuleShowUseCase.Execute(APK: Int64): TTaxRuleShowDTO;
var
  lTaxRuleFound: Shared<TTaxRule>;
begin
  // Localizar Registro
  lTaxRuleFound := FRepository.Show(APK);
  if not Assigned(lTaxRuleFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TTaxRuleShowDTO.FromEntity(lTaxRuleFound.Value);
end;

class function TTaxRuleShowUseCase.Make(ARepository: ITaxRuleRepository): ITaxRuleShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
