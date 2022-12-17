unit uStorageLocation.Index.UseCase;

interface

uses
  uStorageLocation.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IStorageLocationIndexUseCase = Interface
    ['{FA991F53-A0CD-439C-BD8B-081609BA2BA7}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TStorageLocationIndexUseCase = class(TInterfacedObject, IStorageLocationIndexUseCase)
  private
    FRepository: IStorageLocationRepository;
    constructor Create(ARepository: IStorageLocationRepository);
  public
    class function Make(ARepository: IStorageLocationRepository): IStorageLocationIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TStorageLocationIndexUseCase }

constructor TStorageLocationIndexUseCase.Create(ARepository: IStorageLocationRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TStorageLocationIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TStorageLocationIndexUseCase.Make(ARepository: IStorageLocationRepository): IStorageLocationIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
