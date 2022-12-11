unit uAclUser.Show.UseCase;

interface

uses
  uAclUser.Repository.Interfaces,
  uAclUser.Show.DTO;

type
  IAclUserShowUseCase = Interface
    ['{6CE1C725-16E1-451F-AEEF-DA5C61F068B4}']
    function Execute(APK: Int64): TAclUserShowDTO;
  end;

  TAclUserShowUseCase = class(TInterfacedObject, IAclUserShowUseCase)
  private
    FRepository: IAclUserRepository;
    constructor Create(ARepository: IAclUserRepository);
  public
    class function Make(ARepository: IAclUserRepository): IAclUserShowUseCase;
    function Execute(APK: Int64): TAclUserShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uAclUser,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TAclUserShowUseCase }

constructor TAclUserShowUseCase.Create(ARepository: IAclUserRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclUserShowUseCase.Execute(APK: Int64): TAclUserShowDTO;
var
  lAclUserFound: Shared<TAclUser>;
begin
  // Localizar Registro
  lAclUserFound := FRepository.Show(APK);
  if not Assigned(lAclUserFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TAclUserShowDTO.FromEntity(lAclUserFound.Value);
end;

class function TAclUserShowUseCase.Make(ARepository: IAclUserRepository): IAclUserShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
