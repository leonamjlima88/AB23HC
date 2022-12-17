unit uProduct.SQLBuilder.Interfaces;

interface

uses
  uProduct,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  IProductSQLBuilder = interface(IBaseSQLBuilder)
    ['{5FD5DAE7-3104-45D1-8E56-C11717EBE03F}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function RegisteredFields(AColumName, AColumnValue: String; AId: Int64): String;
  end;

implementation

end.

