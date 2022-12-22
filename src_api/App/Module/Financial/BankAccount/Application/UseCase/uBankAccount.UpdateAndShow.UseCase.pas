unit uBankAccount.UpdateAndShow.UseCase;

interface

uses
  uBankAccount.DTO,
  uBankAccount.Show.DTO,
  uBankAccount.Repository.Interfaces;

type
  IBankAccountUpdateAndShowUseCase = Interface
['{F3D9EB1A-63E8-4E3A-A55B-A287A4DD64C8}']
    function Execute(AInput: TBankAccountDTO; APK: Int64): TBankAccountShowDTO;
  end;

  TBankAccountUpdateAndShowUseCase = class(TInterfacedObject, IBankAccountUpdateAndShowUseCase)
  private
    FRepository: IBankAccountRepository;
    constructor Create(ARepository: IBankAccountRepository);
  public
    class function Make(ARepository: IBankAccountRepository): IBankAccountUpdateAndShowUseCase;
    function Execute(AInput: TBankAccountDTO; APK: Int64): TBankAccountShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uBankAccount,
  uBankAccount.Mapper,
  System.SysUtils;

{ TBankAccountUpdateAndShowUseCase }

constructor TBankAccountUpdateAndShowUseCase.Create(ARepository: IBankAccountRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBankAccountUpdateAndShowUseCase.Execute(AInput: TBankAccountDTO; APK: Int64): TBankAccountShowDTO;
var
  lBankAccountToUpdate: Shared<TBankAccount>;
  lBankAccountUpdated: Shared<TBankAccount>;
begin
  // Carregar dados em Entity
  lBankAccountToUpdate := TBankAccountMapper.BankAccountDtoToEntity(AInput);
  With lBankAccountToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lBankAccountToUpdate, APK);
  lBankAccountUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TBankAccountMapper.EntityToBankAccountShowDto(lBankAccountUpdated);
end;

class function TBankAccountUpdateAndShowUseCase.Make(ARepository: IBankAccountRepository): IBankAccountUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
