unit uAclUser.SQLBuilder.Interfaces;

interface

uses
  uAclUser,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  IAclUserSQLBuilder = interface(IBaseSQLBuilder)
    ['{F2BFD14E-4BB9-4D62-B27B-543DD08BF21B}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
  end;

implementation

end.

