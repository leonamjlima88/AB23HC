unit uCategory.SQLBuilder.Interfaces;

interface

uses
  uCategory,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  ICategorySQLBuilder = interface(IBaseSQLBuilder)
    ['{8B6169D8-7EF0-4A63-84C0-527F51EF1360}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
  end;

implementation

end.

