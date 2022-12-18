unit uCFOP.Index.UseCase;

interface

uses
  uCFOP.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  ICFOPIndexUseCase = Interface
    ['{98C4BAB2-A881-469C-8E47-AE4F9FDF8789}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TCFOPIndexUseCase = class(TInterfacedObject, ICFOPIndexUseCase)
  private
    FRepository: ICFOPRepository;
    constructor Create(ARepository: ICFOPRepository);
  public
    class function Make(ARepository: ICFOPRepository): ICFOPIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TCFOPIndexUseCase }

constructor TCFOPIndexUseCase.Create(ARepository: ICFOPRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCFOPIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TCFOPIndexUseCase.Make(ARepository: ICFOPRepository): ICFOPIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
