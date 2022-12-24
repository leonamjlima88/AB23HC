unit uAclUser.StoreAndShow.UseCase;

interface

uses
  uAclUser.DTO,
  uAclUser.Show.DTO,
  uAclUser.Repository.Interfaces;

type
  IAclUserStoreAndShowUseCase = Interface
    ['{C83AF47C-10E0-4DBA-8143-A25BAAE6D6C9}']
    function Execute(AInput: TAclUserDTO): TAclUserShowDTO;
  end;

  TAclUserStoreAndShowUseCase = class(TInterfacedObject, IAclUserStoreAndShowUseCase)
  private
    FRepository: IAclUserRepository;
    constructor Create(ARepository: IAclUserRepository);
  public
    class function Make(ARepository: IAclUserRepository): IAclUserStoreAndShowUseCase;
    function Execute(AInput: TAclUserDTO): TAclUserShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uAclUser,
  uAclUser.Mapper,
  uHlp,
  uApplication.Types;

{ TAclUserStoreAndShowUseCase }

constructor TAclUserStoreAndShowUseCase.Create(ARepository: IAclUserRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclUserStoreAndShowUseCase.Execute(AInput: TAclUserDTO): TAclUserShowDTO;
var
  lAclUserToStore: Shared<TAclUser>;
  lAclUserStored: Shared<TAclUser>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lAclUserToStore := TAclUserMapper.AclUserDtoToEntity(AInput);
  With lAclUserToStore.Value do
  begin
    login_password := THlp.Encrypt(ENCRYPTATION_KEY, LOGIN_PASSWORD_DEFAULT);
    Validate;
  end;

  // Incluir e Localizar registro incluso
  lPK            := FRepository.Store(lAclUserToStore);
  lAclUserStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TAclUserMapper.EntityToAclUserShowDto(lAclUserStored);
end;

class function TAclUserStoreAndShowUseCase.Make(ARepository: IAclUserRepository): IAclUserStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
