unit uAclUser.UpdateAndShow.UseCase;

interface

uses
  uAclUser.DTO,
  uAclUser.Show.DTO,
  uAclUser.Repository.Interfaces;

type
  IAclUserUpdateAndShowUseCase = Interface
    ['{FDAFC09D-D524-4A46-A2EA-322EE2E5DDC9}']
    function Execute(AInput: TAclUserDTO; APK: Int64): TAclUserShowDTO;
  end;

  TAclUserUpdateAndShowUseCase = class(TInterfacedObject, IAclUserUpdateAndShowUseCase)
  private
    FRepository: IAclUserRepository;
    constructor Create(ARepository: IAclUserRepository);
  public
    class function Make(ARepository: IAclUserRepository): IAclUserUpdateAndShowUseCase;
    function Execute(AInput: TAclUserDTO; APK: Int64): TAclUserShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uAclUser,
  uAclUser.Mapper,
  System.SysUtils,
  uApplication.Types;

{ TAclUserUpdateAndShowUseCase }

constructor TAclUserUpdateAndShowUseCase.Create(ARepository: IAclUserRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclUserUpdateAndShowUseCase.Execute(AInput: TAclUserDTO; APK: Int64): TAclUserShowDTO;
var
  lAclUserToUpdate: Shared<TAclUser>;
  lAclUserUpdated: Shared<TAclUser>;
begin
  // Carregar dados em Entity
  lAclUserToUpdate := TAclUserMapper.AclUserDtoToEntity(AInput);
  With lAclUserToUpdate.Value do
  begin
    id := APK;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lAclUserToUpdate, APK);
  lAclUserUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TAclUserMapper.EntityToAclUserShowDto(lAclUserUpdated);
end;

class function TAclUserUpdateAndShowUseCase.Make(ARepository: IAclUserRepository): IAclUserUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
