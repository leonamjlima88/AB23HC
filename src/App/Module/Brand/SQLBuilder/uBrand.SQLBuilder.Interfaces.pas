unit uBrand.SQLBuilder.Interfaces;

interface

uses
  uBrand,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  IBrandSQLBuilder = interface(IBaseSQLBuilder)
    ['{5FD5DAE7-3104-45D1-8E56-C11717EBE03F}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
  end;

implementation

end.

