unit uBusinessProposal.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uBusinessProposal,
  uZLMemTable.Interfaces;

type
  IBusinessProposalRepository = interface(IBaseRepository)
    ['{5B86467E-A8DC-4D71-A110-1FA934F9FC10}']
    function Show(AId, ATenantId: Int64): TBusinessProposal;
    function Store(ABusinessProposal: TBusinessProposal; AManageTransaction: Boolean): Int64; overload;
    function Update(ABusinessProposal: TBusinessProposal; AId: Int64; AManageTransaction: Boolean): Boolean; overload;
    function DataForReportById(AId, ATenantId: Int64; ABusinessProposal, ABusinessProposalItem: IZLMemTable): IBusinessProposalRepository;
  end;

implementation

end.


