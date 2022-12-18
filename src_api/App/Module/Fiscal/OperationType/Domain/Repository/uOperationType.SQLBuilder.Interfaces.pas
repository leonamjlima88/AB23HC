unit uOperationType.SQLBuilder.Interfaces;

interface

uses
  uOperationType,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  IOperationTypeSQLBuilder = interface(IBaseSQLBuilder)
    ['{B770B6DA-E002-4FD2-85C2-8E4FBE6846A0}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
  end;

implementation

end.

