unit uBusinessProposal.SQLBuilder.Interfaces;

interface

uses
  uBusinessProposal,
  uPageFilter,
  uSelectWithFilter,
  uBase.SQLBuilder.Interfaces,
  uBase.Entity;

type
  IBusinessProposalSQLBuilder = interface(IBaseSQLBuilder)
    ['{75C49CA4-2BC7-465D-A9B7-139987E8811E}']

    // BusinessProposal
    function ScriptSeedTable: String;
    function SelectAll: String;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
    function ReportById(AId, ATenantId: Int64): String;
  end;

implementation

end.

