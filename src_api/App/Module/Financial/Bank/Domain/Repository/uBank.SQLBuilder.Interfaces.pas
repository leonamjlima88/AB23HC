unit uBank.SQLBuilder.Interfaces;

interface

uses
  uBank,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  IBankSQLBuilder = interface(IBaseSQLBuilder)
    ['{FF557F9E-1C3D-4FCC-B7DB-C877EC71CC2F}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function RegisteredFields(AColumName, AColumnValue: String; AId: Int64): String;
  end;

implementation

end.

