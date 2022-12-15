unit uPerson.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uPerson;

type
  IPersonRepository = interface(IBaseRepository)
    ['{061F3162-E14C-4C78-801D-E78EBEC8D8F9}']
    function Show(AId: Int64): TPerson;
    function Store(APerson: TPerson; AManageTransaction: Boolean): Int64; overload;
  end;

implementation

end.


