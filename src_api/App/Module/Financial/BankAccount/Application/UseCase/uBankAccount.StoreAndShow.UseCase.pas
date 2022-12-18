unit uBankAccount.StoreAndShow.UseCase;

interface

uses
  uBankAccount.DTO,
  uBankAccount.Show.DTO,
  uBankAccount.Repository.Interfaces;

type
  IBankAccountStoreAndShowUseCase = Interface
['{A59EE92E-C176-4FC2-9A5D-F6BB7E73E234}']
    function Execute(AInput: TBankAccountDTO): TBankAccountShowDTO;
  end;

  TBankAccountStoreAndShowUseCase = class(TInterfacedObject, IBankAccountStoreAndShowUseCase)
  private
    FRepository: IBankAccountRepository;
    constructor Create(ARepository: IBankAccountRepository);
  public
    class function Make(ARepository: IBankAccountRepository): IBankAccountStoreAndShowUseCase;
    function Execute(AInput: TBankAccountDTO): TBankAccountShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uBankAccount,
  XSuperObject;

{ TBankAccountStoreAndShowUseCase }

constructor TBankAccountStoreAndShowUseCase.Create(ARepository: IBankAccountRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBankAccountStoreAndShowUseCase.Execute(AInput: TBankAccountDTO): TBankAccountShowDTO;
var
  lBankAccountToStore: Shared<TBankAccount>;
  lBankAccountStored: Shared<TBankAccount>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lBankAccountToStore := TBankAccount.FromJSON(AInput.AsJSON);
  lBankAccountToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lBankAccountToStore);
  lBankAccountStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TBankAccountShowDTO.FromEntity(lBankAccountStored.Value);
end;

class function TBankAccountStoreAndShowUseCase.Make(ARepository: IBankAccountRepository): IBankAccountStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
