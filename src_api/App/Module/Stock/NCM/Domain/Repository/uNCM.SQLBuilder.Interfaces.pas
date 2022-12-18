unit uNCM.SQLBuilder.Interfaces;

interface

uses
  uNCM,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  INCMSQLBuilder = interface(IBaseSQLBuilder)
    ['{4752B68E-9539-4F43-ACA0-A87EE8C7FB0D}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function RegisteredFields(AColumName, AColumnValue: String; AId: Int64): String;
  end;

implementation

end.

