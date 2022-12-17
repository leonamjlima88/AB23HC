unit uProduct.Index.UseCase;

interface

uses
  uProduct.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IProductIndexUseCase = Interface
    ['{B5B0CD9D-E65B-44C4-B17C-B3E8B15A0038}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TProductIndexUseCase = class(TInterfacedObject, IProductIndexUseCase)
  private
    FRepository: IProductRepository;
    constructor Create(ARepository: IProductRepository);
  public
    class function Make(ARepository: IProductRepository): IProductIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TProductIndexUseCase }

constructor TProductIndexUseCase.Create(ARepository: IProductRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TProductIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TProductIndexUseCase.Make(ARepository: IProductRepository): IProductIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
