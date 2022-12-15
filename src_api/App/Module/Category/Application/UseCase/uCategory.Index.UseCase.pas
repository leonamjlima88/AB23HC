unit uCategory.Index.UseCase;

interface

uses
  uCategory.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  ICategoryIndexUseCase = Interface
    ['{F69CB82B-D770-4665-B34D-64AE1805A0C2}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TCategoryIndexUseCase = class(TInterfacedObject, ICategoryIndexUseCase)
  private
    FRepository: ICategoryRepository;
    constructor Create(ARepository: ICategoryRepository);
  public
    class function Make(ARepository: ICategoryRepository): ICategoryIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TCategoryIndexUseCase }

constructor TCategoryIndexUseCase.Create(ARepository: ICategoryRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCategoryIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TCategoryIndexUseCase.Make(ARepository: ICategoryRepository): ICategoryIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
