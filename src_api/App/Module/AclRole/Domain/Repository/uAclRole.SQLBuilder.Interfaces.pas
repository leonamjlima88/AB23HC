unit uAclRole.SQLBuilder.Interfaces;

interface

uses
  uAclRole,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces;

type
  IAclRoleSQLBuilder = interface(IBaseSQLBuilder)
    ['{CA9D7574-DDEC-4082-953A-C7DD83640E16}']

    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
  end;

implementation

end.

