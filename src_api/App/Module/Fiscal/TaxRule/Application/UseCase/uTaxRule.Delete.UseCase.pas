unit uTaxRule.Delete.UseCase;

interface

uses
  uTaxRule.Repository.Interfaces;

type
  ITaxRuleDeleteUseCase = Interface
['{71E437A6-19C9-45C0-A607-E0D79CA23CCF}']
    function Execute(APK: Int64): Boolean;
  end;

  TTaxRuleDeleteUseCase = class(TInterfacedObject, ITaxRuleDeleteUseCase)
  private
    FRepository: ITaxRuleRepository;
    constructor Create(ARepository: ITaxRuleRepository);
  public
    class function Make(ARepository: ITaxRuleRepository): ITaxRuleDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TTaxRuleDeleteUseCase }

constructor TTaxRuleDeleteUseCase.Create(ARepository: ITaxRuleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TTaxRuleDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TTaxRuleDeleteUseCase.Make(ARepository: ITaxRuleRepository): ITaxRuleDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
