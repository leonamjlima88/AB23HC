unit uChartOfAccount.SQLBuilder.Interfaces;

interface

uses
  uChartOfAccount,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  IChartOfAccountSQLBuilder = interface(IBaseSQLBuilder)
    ['{B770B6DA-E002-4FD2-85C2-8E4FBE6846A0}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function RegisteredFields(AColumName, AColumnValue: String; AId: Int64): String;
  end;

implementation

end.

