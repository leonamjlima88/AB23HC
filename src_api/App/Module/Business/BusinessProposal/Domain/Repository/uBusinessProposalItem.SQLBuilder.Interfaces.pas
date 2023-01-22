unit uBusinessProposalItem.SQLBuilder.Interfaces;

interface

uses
  uBusinessProposalItem,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  IBusinessProposalItemSQLBuilder = interface(IBaseSQLBuilder)
    ['{2756FEDF-EA98-44D1-8BC3-BA0D96901794}']
    function DeleteByBusinessProposalId(ABusinessProposalId: Int64): String;
    function SelectByBusinessProposalId(ABusinessProposalId: Int64): String;
    function ReportById(ABusinessProposalId: Int64): String;
  end;

implementation

end.

