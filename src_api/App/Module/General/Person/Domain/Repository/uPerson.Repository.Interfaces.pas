unit uPerson.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uPerson;

type
  IPersonRepository = interface(IBaseRepository)
    ['{061F3162-E14C-4C78-801D-E78EBEC8D8F9}']
    function Show(AId, ATenantId: Int64): TPerson;
    function Store(APerson: TPerson; AManageTransaction: Boolean): Int64; overload;
    function Update(APerson: TPerson; AId: Int64; AManageTransaction: Boolean): Boolean; overload;
  end;

implementation

end.


