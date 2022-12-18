unit uBankAccount.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uBankAccount;

type
  IBankAccountRepository = interface(IBaseRepository)
['{740C04BE-C1E1-41D4-A8E2-8846C074A058}']
    function Show(AId: Int64): TBankAccount;
  end;

implementation

end.


