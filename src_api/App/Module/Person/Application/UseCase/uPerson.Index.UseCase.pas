unit uPerson.Index.UseCase;

interface

uses
  uPerson.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IPersonIndexUseCase = Interface
['{CD23ABD8-FBF3-4C5E-9808-A490F307167E}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TPersonIndexUseCase = class(TInterfacedObject, IPersonIndexUseCase)
  private
    FRepository: IPersonRepository;
    constructor Create(ARepository: IPersonRepository);
  public
    class function Make(ARepository: IPersonRepository): IPersonIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TPersonIndexUseCase }

constructor TPersonIndexUseCase.Create(ARepository: IPersonRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TPersonIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TPersonIndexUseCase.Make(ARepository: IPersonRepository): IPersonIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
