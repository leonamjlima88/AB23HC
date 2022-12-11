unit uAclUser.Index.UseCase;

interface

uses
  uAclUser.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IAclUserIndexUseCase = Interface
    ['{286C44EE-5ACB-454C-A96F-93EAFB7385DC}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TAclUserIndexUseCase = class(TInterfacedObject, IAclUserIndexUseCase)
  private
    FRepository: IAclUserRepository;
    constructor Create(ARepository: IAclUserRepository);
  public
    class function Make(ARepository: IAclUserRepository): IAclUserIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TAclUserIndexUseCase }

constructor TAclUserIndexUseCase.Create(ARepository: IAclUserRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclUserIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TAclUserIndexUseCase.Make(ARepository: IAclUserRepository): IAclUserIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
