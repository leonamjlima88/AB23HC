unit uDocument.Index.UseCase;

interface

uses
  uDocument.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IDocumentIndexUseCase = Interface
    ['{C1E43DBC-343E-416D-BC88-41DCE8B419AC}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TDocumentIndexUseCase = class(TInterfacedObject, IDocumentIndexUseCase)
  private
    FRepository: IDocumentRepository;
    constructor Create(ARepository: IDocumentRepository);
  public
    class function Make(ARepository: IDocumentRepository): IDocumentIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TDocumentIndexUseCase }

constructor TDocumentIndexUseCase.Create(ARepository: IDocumentRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TDocumentIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TDocumentIndexUseCase.Make(ARepository: IDocumentRepository): IDocumentIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
