unit uBankAccount.Index.UseCase;

interface

uses
  uBankAccount.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IBankAccountIndexUseCase = Interface
['{E1511743-1F40-4752-B17A-29030DA26662}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TBankAccountIndexUseCase = class(TInterfacedObject, IBankAccountIndexUseCase)
  private
    FRepository: IBankAccountRepository;
    constructor Create(ARepository: IBankAccountRepository);
  public
    class function Make(ARepository: IBankAccountRepository): IBankAccountIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TBankAccountIndexUseCase }

constructor TBankAccountIndexUseCase.Create(ARepository: IBankAccountRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBankAccountIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TBankAccountIndexUseCase.Make(ARepository: IBankAccountRepository): IBankAccountIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
