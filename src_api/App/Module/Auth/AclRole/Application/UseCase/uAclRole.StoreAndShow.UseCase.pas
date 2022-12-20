unit uAclRole.StoreAndShow.UseCase;

interface

uses
  uAclRole.DTO,
  uAclRole.Show.DTO,
  uAclRole.Repository.Interfaces;

type
  IAclRoleStoreAndShowUseCase = Interface
    ['{8D04D313-CE11-447E-A52E-D171B9605598}']
    function Execute(AInput: TAclRoleDTO): TAclRoleShowDTO;
  end;

  TAclRoleStoreAndShowUseCase = class(TInterfacedObject, IAclRoleStoreAndShowUseCase)
  private
    FRepository: IAclRoleRepository;
    constructor Create(ARepository: IAclRoleRepository);
  public
    class function Make(ARepository: IAclRoleRepository): IAclRoleStoreAndShowUseCase;
    function Execute(AInput: TAclRoleDTO): TAclRoleShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uAclRole,
  XSuperObject;

{ TAclRoleStoreAndShowUseCase }

constructor TAclRoleStoreAndShowUseCase.Create(ARepository: IAclRoleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclRoleStoreAndShowUseCase.Execute(AInput: TAclRoleDTO): TAclRoleShowDTO;
var
  lAclRoleToStore: Shared<TAclRole>;
  lAclRoleStored: Shared<TAclRole>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lAclRoleToStore := TAclRole.FromJSON(AInput.AsJSON);
  lAclRoleToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK            := FRepository.Store(lAclRoleToStore);
  lAclRoleStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TAclRoleShowDTO.FromEntity(lAclRoleStored.Value);
end;

class function TAclRoleStoreAndShowUseCase.Make(ARepository: IAclRoleRepository): IAclRoleStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
