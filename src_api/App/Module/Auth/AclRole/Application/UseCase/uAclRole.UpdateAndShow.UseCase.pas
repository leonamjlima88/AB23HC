unit uAclRole.UpdateAndShow.UseCase;

interface

uses
  uAclRole.DTO,
  uAclRole.Show.DTO,
  uAclRole.Repository.Interfaces;

type
  IAclRoleUpdateAndShowUseCase = Interface
    ['{F2154555-CCE8-4AA6-8349-A549BD321FBB}']
    function Execute(AInput: TAclRoleDTO; APK: Int64): TAclRoleShowDTO;
  end;

  TAclRoleUpdateAndShowUseCase = class(TInterfacedObject, IAclRoleUpdateAndShowUseCase)
  private
    FRepository: IAclRoleRepository;
    constructor Create(ARepository: IAclRoleRepository);
  public
    class function Make(ARepository: IAclRoleRepository): IAclRoleUpdateAndShowUseCase;
    function Execute(AInput: TAclRoleDTO; APK: Int64): TAclRoleShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uAclRole,
  uAclRole.Mapper;

{ TAclRoleUpdateAndShowUseCase }

constructor TAclRoleUpdateAndShowUseCase.Create(ARepository: IAclRoleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclRoleUpdateAndShowUseCase.Execute(AInput: TAclRoleDTO; APK: Int64): TAclRoleShowDTO;
var
  lAclRoleToUpdate: Shared<TAclRole>;
  lAclRoleUpdated: Shared<TAclRole>;
begin
  // Carregar dados em Entity
  lAclRoleToUpdate := TAclRoleMapper.AclRoleDtoToEntity(AInput);
  With lAclRoleToUpdate.Value do
  begin
    id := APK;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lAclRoleToUpdate, APK);
  lAclRoleUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TAclRoleMapper.EntityToAclRoleShowDto(lAclRoleUpdated);
end;

class function TAclRoleUpdateAndShowUseCase.Make(ARepository: IAclRoleRepository): IAclRoleUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
