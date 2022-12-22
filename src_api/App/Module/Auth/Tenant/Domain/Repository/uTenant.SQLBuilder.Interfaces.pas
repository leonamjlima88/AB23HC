unit uTenant.SQLBuilder.Interfaces;

interface

uses
  uTenant,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  ITenantSQLBuilder = interface(IBaseSQLBuilder)
    ['{5FD5DAE7-3104-45D1-8E56-C11717EBE03F}']

    // Tenant
    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function RegisteredLegalEntityNumbers(ALegalEntityNumber: String; AId: Int64): String;
  end;

implementation

end.

