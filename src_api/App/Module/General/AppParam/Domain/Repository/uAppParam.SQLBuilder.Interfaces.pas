unit uAppParam.SQLBuilder.Interfaces;

interface

uses
  uAppParam,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity,
  System.Generics.Collections;

type
  IAppParamSQLBuilder = interface(IBaseSQLBuilder)
    ['{3AFCC152-B116-4C6A-96B9-6F9A1F07C8FF}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function DeleteByGroup(AGroupName: String; ATenantId: Int64): String;
  end;

implementation

end.

