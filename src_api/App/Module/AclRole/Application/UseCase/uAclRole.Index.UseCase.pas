unit uAclRole.Index.UseCase;

interface

uses
  uAclRole.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IAclRoleIndexUseCase = Interface
    ['{73407662-9790-4C3B-A2AD-269AE2215731}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TAclRoleIndexUseCase = class(TInterfacedObject, IAclRoleIndexUseCase)
  private
    FRepository: IAclRoleRepository;
    constructor Create(ARepository: IAclRoleRepository);
  public
    class function Make(ARepository: IAclRoleRepository): IAclRoleIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TAclRoleIndexUseCase }

constructor TAclRoleIndexUseCase.Create(ARepository: IAclRoleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclRoleIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TAclRoleIndexUseCase.Make(ARepository: IAclRoleRepository): IAclRoleIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
