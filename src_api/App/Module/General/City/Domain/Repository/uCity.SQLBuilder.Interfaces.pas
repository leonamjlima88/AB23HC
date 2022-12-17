unit uCity.SQLBuilder.Interfaces;

interface

uses
  uCity,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  ICitySQLBuilder = interface(IBaseSQLBuilder)
['{8858A862-D9A4-4A20-893D-DA6B178CF392}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
  end;

implementation

end.

