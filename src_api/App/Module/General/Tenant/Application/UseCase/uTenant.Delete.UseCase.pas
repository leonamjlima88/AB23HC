unit uTenant.Delete.UseCase;

interface

uses
  uTenant.Repository.Interfaces;

type
  ITenantDeleteUseCase = Interface
['{7AF33AD2-BD25-475C-B875-BA7F61DF60B7}']
    function Execute(APK: Int64): Boolean;
  end;

  TTenantDeleteUseCase = class(TInterfacedObject, ITenantDeleteUseCase)
  private
    FRepository: ITenantRepository;
    constructor Create(ARepository: ITenantRepository);
  public
    class function Make(ARepository: ITenantRepository): ITenantDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TTenantDeleteUseCase }

constructor TTenantDeleteUseCase.Create(ARepository: ITenantRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TTenantDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TTenantDeleteUseCase.Make(ARepository: ITenantRepository): ITenantDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
