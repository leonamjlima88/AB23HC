unit uBankAccount.Delete.UseCase;

interface

uses
  uBankAccount.Repository.Interfaces;

type
  IBankAccountDeleteUseCase = Interface
    ['{09562C0F-0140-468F-98E9-B5FEFBE4B141}']
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

  TBankAccountDeleteUseCase = class(TInterfacedObject, IBankAccountDeleteUseCase)
  private
    FRepository: IBankAccountRepository;
    constructor Create(ARepository: IBankAccountRepository);
  public
    class function Make(ARepository: IBankAccountRepository): IBankAccountDeleteUseCase;
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

implementation

{ TBankAccountDeleteUseCase }

constructor TBankAccountDeleteUseCase.Create(ARepository: IBankAccountRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBankAccountDeleteUseCase.Execute(APK, ATenantId: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK, ATenantId);
end;

class function TBankAccountDeleteUseCase.Make(ARepository: IBankAccountRepository): IBankAccountDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
