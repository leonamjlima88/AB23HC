unit uDocument.SQLBuilder.Interfaces;

interface

uses
  uDocument,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  IDocumentSQLBuilder = interface(IBaseSQLBuilder)
    ['{55D21A8B-5446-42C1-B73D-6F8360510BEB}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
  end;

implementation

end.

