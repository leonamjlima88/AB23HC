unit uCostCenter.Index.UseCase;

interface

uses
  uCostCenter.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  ICostCenterIndexUseCase = Interface
    ['{FA991F53-A0CD-439C-BD8B-081609BA2BA7}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TCostCenterIndexUseCase = class(TInterfacedObject, ICostCenterIndexUseCase)
  private
    FRepository: ICostCenterRepository;
    constructor Create(ARepository: ICostCenterRepository);
  public
    class function Make(ARepository: ICostCenterRepository): ICostCenterIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TCostCenterIndexUseCase }

constructor TCostCenterIndexUseCase.Create(ARepository: ICostCenterRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCostCenterIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TCostCenterIndexUseCase.Make(ARepository: ICostCenterRepository): ICostCenterIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
