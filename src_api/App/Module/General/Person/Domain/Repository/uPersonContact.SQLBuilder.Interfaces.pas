unit uPersonContact.SQLBuilder.Interfaces;

interface

uses
  uPersonContact,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  IPersonContactSQLBuilder = interface(IBaseSQLBuilder)
    ['{C0BBF472-A93C-481A-B798-23790E5F49F1}']
    function DeleteByPersonId(APersonId: Int64): String;
    function SelectByPersonId(APersonId: Int64): String;
  end;

implementation

end.

