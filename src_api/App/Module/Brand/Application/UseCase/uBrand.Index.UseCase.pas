unit uBrand.Index.UseCase;

interface

uses
  uBrand.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IBrandIndexUseCase = Interface
    ['{FA991F53-A0CD-439C-BD8B-081609BA2BA7}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TBrandIndexUseCase = class(TInterfacedObject, IBrandIndexUseCase)
  private
    FRepository: IBrandRepository;
    constructor Create(ARepository: IBrandRepository);
  public
    class function Make(ARepository: IBrandRepository): IBrandIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TBrandIndexUseCase }

constructor TBrandIndexUseCase.Create(ARepository: IBrandRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBrandIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TBrandIndexUseCase.Make(ARepository: IBrandRepository): IBrandIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
