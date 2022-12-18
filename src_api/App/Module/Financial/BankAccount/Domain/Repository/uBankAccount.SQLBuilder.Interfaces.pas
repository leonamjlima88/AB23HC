unit uBankAccount.SQLBuilder.Interfaces;

interface

uses
  uBankAccount,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  IBankAccountSQLBuilder = interface(IBaseSQLBuilder)
['{6C22F777-9439-4221-914F-D22B031137EE}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
  end;

implementation

end.

