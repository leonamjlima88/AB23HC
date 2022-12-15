unit uSize.Index.UseCase;

interface

uses
  uSize.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  ISizeIndexUseCase = Interface
['{433A25CD-D312-48AC-9029-2764934E300E}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TSizeIndexUseCase = class(TInterfacedObject, ISizeIndexUseCase)
  private
    FRepository: ISizeRepository;
    constructor Create(ARepository: ISizeRepository);
  public
    class function Make(ARepository: ISizeRepository): ISizeIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TSizeIndexUseCase }

constructor TSizeIndexUseCase.Create(ARepository: ISizeRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TSizeIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TSizeIndexUseCase.Make(ARepository: ISizeRepository): ISizeIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
