unit uSalePayment.SQLBuilder.Interfaces;

interface

uses
  uSalePayment,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  ISalePaymentSQLBuilder = interface(IBaseSQLBuilder)
    ['{F0138B08-FEFF-4EA8-A05F-4DEFDD77F723}']
    function DeleteBySaleId(ASaleId: Int64): String;
    function SelectBySaleId(ASaleId: Int64): String;
    function ReportById(ASaleId: Int64): String;
  end;

implementation

end.

