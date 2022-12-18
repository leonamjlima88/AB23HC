unit uChartOfAccount.Index.UseCase;

interface

uses
  uChartOfAccount.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IChartOfAccountIndexUseCase = Interface
    ['{98C4BAB2-A881-469C-8E47-AE4F9FDF8789}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TChartOfAccountIndexUseCase = class(TInterfacedObject, IChartOfAccountIndexUseCase)
  private
    FRepository: IChartOfAccountRepository;
    constructor Create(ARepository: IChartOfAccountRepository);
  public
    class function Make(ARepository: IChartOfAccountRepository): IChartOfAccountIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TChartOfAccountIndexUseCase }

constructor TChartOfAccountIndexUseCase.Create(ARepository: IChartOfAccountRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TChartOfAccountIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TChartOfAccountIndexUseCase.Make(ARepository: IChartOfAccountRepository): IChartOfAccountIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
