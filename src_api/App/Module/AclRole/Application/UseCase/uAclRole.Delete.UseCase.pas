unit uAclRole.Delete.UseCase;

interface

uses
  uAclRole.Repository.Interfaces;

type
  IAclRoleDeleteUseCase = Interface
    ['{8F46D58C-FA88-402C-A764-9F22CC57B9A7}']
    function Execute(APK: Int64): Boolean;
  end;

  TAclRoleDeleteUseCase = class(TInterfacedObject, IAclRoleDeleteUseCase)
  private
    FRepository: IAclRoleRepository;
    constructor Create(ARepository: IAclRoleRepository);
  public
    class function Make(ARepository: IAclRoleRepository): IAclRoleDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TAclRoleDeleteUseCase }

constructor TAclRoleDeleteUseCase.Create(ARepository: IAclRoleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclRoleDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TAclRoleDeleteUseCase.Make(ARepository: IAclRoleRepository): IAclRoleDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
