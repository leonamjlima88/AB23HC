unit uCity.Index.UseCase;

interface

uses
  uCity.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  ICityIndexUseCase = Interface
    ['{FA991F53-A0CD-439C-BD8B-081609BA2BA7}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TCityIndexUseCase = class(TInterfacedObject, ICityIndexUseCase)
  private
    FRepository: ICityRepository;
    constructor Create(ARepository: ICityRepository);
  public
    class function Make(ARepository: ICityRepository): ICityIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TCityIndexUseCase }

constructor TCityIndexUseCase.Create(ARepository: ICityRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCityIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TCityIndexUseCase.Make(ARepository: ICityRepository): ICityIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
