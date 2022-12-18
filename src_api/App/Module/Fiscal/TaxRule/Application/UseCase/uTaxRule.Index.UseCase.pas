unit uTaxRule.Index.UseCase;

interface

uses
  uTaxRule.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  ITaxRuleIndexUseCase = Interface
['{CD23ABD8-FBF3-4C5E-9808-A490F307167E}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TTaxRuleIndexUseCase = class(TInterfacedObject, ITaxRuleIndexUseCase)
  private
    FRepository: ITaxRuleRepository;
    constructor Create(ARepository: ITaxRuleRepository);
  public
    class function Make(ARepository: ITaxRuleRepository): ITaxRuleIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TTaxRuleIndexUseCase }

constructor TTaxRuleIndexUseCase.Create(ARepository: ITaxRuleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TTaxRuleIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TTaxRuleIndexUseCase.Make(ARepository: ITaxRuleRepository): ITaxRuleIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
