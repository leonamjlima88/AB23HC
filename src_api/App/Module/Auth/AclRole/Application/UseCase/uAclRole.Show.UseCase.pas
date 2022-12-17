unit uAclRole.Show.UseCase;

interface

uses
  uAclRole.Repository.Interfaces,
  uAclRole.Show.DTO;

type
  IAclRoleShowUseCase = Interface
    ['{F189F8A7-C63B-48B5-BB1D-2E90DC16FC5C}']
    function Execute(APK: Int64): TAclRoleShowDTO;
  end;

  TAclRoleShowUseCase = class(TInterfacedObject, IAclRoleShowUseCase)
  private
    FRepository: IAclRoleRepository;
    constructor Create(ARepository: IAclRoleRepository);
  public
    class function Make(ARepository: IAclRoleRepository): IAclRoleShowUseCase;
    function Execute(APK: Int64): TAclRoleShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uAclRole,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TAclRoleShowUseCase }

constructor TAclRoleShowUseCase.Create(ARepository: IAclRoleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclRoleShowUseCase.Execute(APK: Int64): TAclRoleShowDTO;
var
  lAclRoleFound: Shared<TAclRole>;
begin
  // Localizar Registro
  lAclRoleFound := FRepository.Show(APK);
  if not Assigned(lAclRoleFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TAclRoleShowDTO.FromEntity(lAclRoleFound.Value);
end;

class function TAclRoleShowUseCase.Make(ARepository: IAclRoleRepository): IAclRoleShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
