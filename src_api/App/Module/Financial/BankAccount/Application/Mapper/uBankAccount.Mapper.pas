unit uBankAccount.Mapper;

interface

uses
  uMapper.Interfaces,
  uBankAccount,
  uBankAccount.DTO,
  uBankAccount.Show.DTO;

type
  TBankAccountMapper = class(TInterfacedObject, IMapper)
  public
    class function BankAccountDtoToEntity(ABankAccountDTO: TBankAccountDTO): TBankAccount;
    class function EntityToBankAccountShowDto(ABankAccount: TBankAccount): TBankAccountShowDTO;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TBankAccountMapper }

class function TBankAccountMapper.EntityToBankAccountShowDto(ABankAccount: TBankAccount): TBankAccountShowDTO;
var
  lBankAccountShowDTO: TBankAccountShowDTO;
begin
  if not Assigned(ABankAccount) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lBankAccountShowDTO := TBankAccountShowDTO.FromJSON(ABankAccount.AsJSON);

  // Tratar campos específicos
  lBankAccountShowDTO.bank_name                := ABankAccount.bank.name;
  lBankAccountShowDTO.created_by_acl_user_name := ABankAccount.created_by_acl_user.name;
  lBankAccountShowDTO.updated_by_acl_user_name := ABankAccount.updated_by_acl_user.name;

  Result := lBankAccountShowDTO;
end;

class function TBankAccountMapper.BankAccountDtoToEntity(ABankAccountDTO: TBankAccountDTO): TBankAccount;
var
  lBankAccount: TBankAccount;
begin
  // Mapear campos por JSON
  lBankAccount := TBankAccount.FromJSON(ABankAccountDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lBankAccount;
end;

end.
