unit uPaymentTerm.Index.UseCase;

interface

uses
  uPaymentTerm.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IPaymentTermIndexUseCase = Interface
    ['{98C4BAB2-A881-469C-8E47-AE4F9FDF8789}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TPaymentTermIndexUseCase = class(TInterfacedObject, IPaymentTermIndexUseCase)
  private
    FRepository: IPaymentTermRepository;
    constructor Create(ARepository: IPaymentTermRepository);
  public
    class function Make(ARepository: IPaymentTermRepository): IPaymentTermIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TPaymentTermIndexUseCase }

constructor TPaymentTermIndexUseCase.Create(ARepository: IPaymentTermRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TPaymentTermIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TPaymentTermIndexUseCase.Make(ARepository: IPaymentTermRepository): IPaymentTermIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
