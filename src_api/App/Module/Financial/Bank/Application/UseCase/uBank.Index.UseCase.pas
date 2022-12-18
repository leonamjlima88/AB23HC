unit uBank.Index.UseCase;

interface

uses
  uBank.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IBankIndexUseCase = Interface
    ['{FA991F53-A0CD-439C-BD8B-081609BA2BA7}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TBankIndexUseCase = class(TInterfacedObject, IBankIndexUseCase)
  private
    FRepository: IBankRepository;
    constructor Create(ARepository: IBankRepository);
  public
    class function Make(ARepository: IBankRepository): IBankIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TBankIndexUseCase }

constructor TBankIndexUseCase.Create(ARepository: IBankRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBankIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TBankIndexUseCase.Make(ARepository: IBankRepository): IBankIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
