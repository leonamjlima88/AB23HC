unit uPerson.SQLBuilder.Interfaces;

interface

uses
  uPerson,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  IPersonSQLBuilder = interface(IBaseSQLBuilder)
    ['{5FD5DAE7-3104-45D1-8E56-C11717EBE03F}']

    // Person
    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;

    // PersonContact
    function PersonContactScriptCreateTable: String;
    function PersonContactSelectAll: String;
    function PersonContactDeleteByPersonId(APersonId: Int64): String;
    function PersonContactSelectByPersonId(APersonId: Int64): String;
    function PersonContactInsertInto(AEntity: TBaseEntity): String;
  end;

implementation

end.

