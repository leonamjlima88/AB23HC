unit uSaleItem.SQLBuilder.Interfaces;

interface

uses
  uSaleItem,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  ISaleItemSQLBuilder = interface(IBaseSQLBuilder)
    ['{1EE92C14-2B20-4110-A9EB-D7C6F4CCD701}']
    function DeleteBySaleId(ASaleId: Int64): String;
    function SelectBySaleId(ASaleId: Int64): String;
    function ReportById(ASaleId: Int64): String;
  end;

implementation

end.

