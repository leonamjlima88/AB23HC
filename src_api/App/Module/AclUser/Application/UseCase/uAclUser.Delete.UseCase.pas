unit uAclUser.Delete.UseCase;

interface

uses
  uAclUser.Repository.Interfaces;

type
  IAclUserDeleteUseCase = Interface
    ['{11A7868D-7338-4B4D-A125-EB4934BD67F1}']
    function Execute(APK: Int64): Boolean;
  end;

  TAclUserDeleteUseCase = class(TInterfacedObject, IAclUserDeleteUseCase)
  private
    FRepository: IAclUserRepository;
    constructor Create(ARepository: IAclUserRepository);
  public
    class function Make(ARepository: IAclUserRepository): IAclUserDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TAclUserDeleteUseCase }

constructor TAclUserDeleteUseCase.Create(ARepository: IAclUserRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclUserDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TAclUserDeleteUseCase.Make(ARepository: IAclUserRepository): IAclUserDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
