unit uTenant.Index.UseCase;

interface

uses
  uTenant.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  ITenantIndexUseCase = Interface
['{46DE6F9A-E497-4F95-BAB4-87AC69AFCECB}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TTenantIndexUseCase = class(TInterfacedObject, ITenantIndexUseCase)
  private
    FRepository: ITenantRepository;
    constructor Create(ARepository: ITenantRepository);
  public
    class function Make(ARepository: ITenantRepository): ITenantIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TTenantIndexUseCase }

constructor TTenantIndexUseCase.Create(ARepository: ITenantRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TTenantIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TTenantIndexUseCase.Make(ARepository: ITenantRepository): ITenantIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
