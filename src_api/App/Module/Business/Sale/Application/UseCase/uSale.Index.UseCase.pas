unit uSale.Index.UseCase;

interface

uses
  uSale.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  ISaleIndexUseCase = Interface
    ['{86A396A0-2BFD-42BD-B9EF-AEE516D7F42C}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TSaleIndexUseCase = class(TInterfacedObject, ISaleIndexUseCase)
  private
    FRepository: ISaleRepository;
    constructor Create(ARepository: ISaleRepository);
  public
    class function Make(ARepository: ISaleRepository): ISaleIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TSaleIndexUseCase }

constructor TSaleIndexUseCase.Create(ARepository: ISaleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TSaleIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TSaleIndexUseCase.Make(ARepository: ISaleRepository): ISaleIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
