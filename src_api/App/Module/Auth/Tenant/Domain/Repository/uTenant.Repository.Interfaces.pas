unit uTenant.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uTenant;

type
  ITenantRepository = interface(IBaseRepository)
    ['{061F3162-E14C-4C78-801D-E78EBEC8D8F9}']
    function Show(AId: Int64): TTenant;
    function Store(ATenant: TTenant; AManageTransaction: Boolean): Int64; overload;
    function Update(ATenant: TTenant; AId: Int64; AManageTransaction: Boolean): Boolean; overload;
  end;

implementation

end.


