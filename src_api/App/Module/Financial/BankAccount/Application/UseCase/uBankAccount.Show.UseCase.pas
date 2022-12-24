unit uBankAccount.Show.UseCase;

interface

uses
  uBankAccount.Repository.Interfaces,
  uBankAccount.Show.DTO;

type
  IBankAccountShowUseCase = Interface
    ['{9B00945C-557B-4A73-8695-CC9C98D1FCBC}']
    function Execute(APK, ATenantId: Int64): TBankAccountShowDTO;
  end;

  TBankAccountShowUseCase = class(TInterfacedObject, IBankAccountShowUseCase)
  private
    FRepository: IBankAccountRepository;
    constructor Create(ARepository: IBankAccountRepository);
  public
    class function Make(ARepository: IBankAccountRepository): IBankAccountShowUseCase;
    function Execute(APK, ATenantId: Int64): TBankAccountShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uBankAccount,
  uBankAccount.Mapper,
  uHlp,
  System.SysUtils,
  uApplication.Types;

{ TBankAccountShowUseCase }

constructor TBankAccountShowUseCase.Create(ARepository: IBankAccountRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBankAccountShowUseCase.Execute(APK, ATenantId: Int64): TBankAccountShowDTO;
var
  lBankAccountFound: Shared<TBankAccount>;
begin
  Result := Nil;

  // Localizar Registro
  lBankAccountFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lBankAccountFound.Value) then
    Exit;

  // Retornar DTO
  Result := TBankAccountMapper.EntityToBankAccountShowDto(lBankAccountFound);
end;

class function TBankAccountShowUseCase.Make(ARepository: IBankAccountRepository): IBankAccountShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
