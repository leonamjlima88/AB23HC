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
  System.SysUtils,
  uApplication.Types,
  xSuperObject;

{ TAclUserUpdateAndShowUseCase }

constructor TAclUserUpdateAndShowUseCase.Create(ARepository: IAclUserRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclUserUpdateAndShowUseCase.Execute(AInput: TAclUserDTO; APK: Int64): TAclUserShowDTO;
var
  lAclUserFound: Shared<TAclUser>;
  lAclUserToUpdate: Shared<TAclUser>;
  lAclUserUpdated: Shared<TAclUser>;
begin
  lAclUserFound := FRepository.Show(APK);
  if not Assigned(lAclUserFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Carregar dados em Entity
  lAclUserToUpdate := TAclUser.FromJSON(AInput.AsJSON);
  With lAclUserToUpdate.Value do
  begin
    id := APK;
    Validate;
  end;

  // Sempre manter senha já cadastrada na atualização
  case Assigned(lAclUserFound.Value) of
    True:  AInput.login_password := lAclUserFound.Value.login_password;
    False: raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lAclUserToUpdate, APK);
  lAclUserUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TAclUserShowDTO.FromEntity(lAclUserUpdated.Value);
end;

class function TAclUserUpdateAndShowUseCase.Make(ARepository: IAclUserRepository): IAclUserUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
