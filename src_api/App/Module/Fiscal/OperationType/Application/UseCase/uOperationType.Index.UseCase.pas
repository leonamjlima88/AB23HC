unit uOperationType.Index.UseCase;

interface

uses
  uOperationType.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IOperationTypeIndexUseCase = Interface
    ['{98C4BAB2-A881-469C-8E47-AE4F9FDF8789}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TOperationTypeIndexUseCase = class(TInterfacedObject, IOperationTypeIndexUseCase)
  private
    FRepository: IOperationTypeRepository;
    constructor Create(ARepository: IOperationTypeRepository);
  public
    class function Make(ARepository: IOperationTypeRepository): IOperationTypeIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TOperationTypeIndexUseCase }

constructor TOperationTypeIndexUseCase.Create(ARepository: IOperationTypeRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TOperationTypeIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TOperationTypeIndexUseCase.Make(ARepository: IOperationTypeRepository): IOperationTypeIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
