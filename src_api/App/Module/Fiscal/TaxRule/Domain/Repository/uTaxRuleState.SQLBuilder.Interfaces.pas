unit uTaxRuleState.SQLBuilder.Interfaces;

interface

uses
  uTaxRuleState,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  ITaxRuleStateSQLBuilder = interface(IBaseSQLBuilder)
    ['{C0BBF472-A93C-481A-B798-23790E5F49F1}']
    function DeleteByTaxRuleId(ATaxRuleId: Int64): String;
    function SelectByTaxRuleId(ATaxRuleId: Int64): String;
  end;

implementation

end.

