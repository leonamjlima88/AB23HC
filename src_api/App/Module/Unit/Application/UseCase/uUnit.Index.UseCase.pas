unit uUnit.Index.UseCase;

interface

uses
  uUnit.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IUnitIndexUseCase = Interface
    ['{FA991F53-A0CD-439C-BD8B-081609BA2BA7}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TUnitIndexUseCase = class(TInterfacedObject, IUnitIndexUseCase)
  private
    FRepository: IUnitRepository;
    constructor Create(ARepository: IUnitRepository);
  public
    class function Make(ARepository: IUnitRepository): IUnitIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TUnitIndexUseCase }

constructor TUnitIndexUseCase.Create(ARepository: IUnitRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TUnitIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TUnitIndexUseCase.Make(ARepository: IUnitRepository): IUnitIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
