unit uTaxRule.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uTaxRule;

type
  ITaxRuleRepository = interface(IBaseRepository)
    ['{061F3162-E14C-4C78-801D-E78EBEC8D8F9}']
    function Show(AId: Int64): TTaxRule;
    function Store(ATaxRule: TTaxRule; AManageTransaction: Boolean): Int64; overload;
    function Update(ATaxRule: TTaxRule; AId: Int64; AManageTransaction: Boolean): Boolean; overload;
  end;

implementation

end.


