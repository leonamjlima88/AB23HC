unit uCostCenter.SQLBuilder.Interfaces;

interface

uses
  uCostCenter,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  ICostCenterSQLBuilder = interface(IBaseSQLBuilder)
['{CB495E7B-1AFF-4983-B514-3183A3D62BFC}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
  end;

implementation

end.

