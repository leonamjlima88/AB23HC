unit uNCM.Index.UseCase;

interface

uses
  uNCM.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  INCMIndexUseCase = Interface
    ['{98C4BAB2-A881-469C-8E47-AE4F9FDF8789}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TNCMIndexUseCase = class(TInterfacedObject, INCMIndexUseCase)
  private
    FRepository: INCMRepository;
    constructor Create(ARepository: INCMRepository);
  public
    class function Make(ARepository: INCMRepository): INCMIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TNCMIndexUseCase }

constructor TNCMIndexUseCase.Create(ARepository: INCMRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TNCMIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TNCMIndexUseCase.Make(ARepository: INCMRepository): INCMIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
