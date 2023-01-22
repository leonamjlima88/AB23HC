unit uSale.SQLBuilder.Interfaces;

interface

uses
  uSale,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  ISaleSQLBuilder = interface(IBaseSQLBuilder)
    ['{1DE64086-6667-4BA7-BF99-0B6C0FEBE598}']

    // Sale
    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function ReportById(AId, ATenantId: Int64): String;
  end;

implementation

end.

