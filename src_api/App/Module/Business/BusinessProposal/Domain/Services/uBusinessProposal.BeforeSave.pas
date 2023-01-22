unit uBusinessProposal.BeforeSave;

interface

uses
  uBusinessProposal,
  uApplication.Types,
  uBusinessProposalItem;

type
  IBusinessProposalBeforeSave = Interface
    ['{9D158418-45C2-4D5C-A21F-A6D533ED4330}']
    function Execute: IBusinessProposalBeforeSave;
  end;

  TBusinessProposalBeforeSave = class(TInterfacedObject, IBusinessProposalBeforeSave)
  private
    FEntity: TBusinessProposal;
    FState: TEntityState;
    constructor Create(AEntity: TBusinessProposal; AStateEnum: TEntityState);
    function HandleAttributes: IBusinessProposalBeforeSave;
    function HandleBusinessProposal: IBusinessProposalBeforeSave;
    function HandleBusinessProposalItem(AEntity: TBusinessProposalItem): IBusinessProposalBeforeSave;
    function HandleBusinessProposalItemList: IBusinessProposalBeforeSave;
  public
    class function Make(AEntity: TBusinessProposal; AStateEnum: TEntityState): IBusinessProposalBeforeSave;
    function Execute: IBusinessProposalBeforeSave;
  end;

implementation

uses
  uHlp,
  System.SysUtils;

{ TBusinessProposalBeforeSave }

constructor TBusinessProposalBeforeSave.Create(AEntity: TBusinessProposal; AStateEnum: TEntityState);
begin
  inherited Create;
  FEntity := AEntity;
  FState  := AStateEnum;
end;

function TBusinessProposalBeforeSave.Execute: IBusinessProposalBeforeSave;
begin
  Result := Self;
  HandleAttributes;
end;

function TBusinessProposalBeforeSave.HandleAttributes: IBusinessProposalBeforeSave;
begin
  Result := Self;
  HandleBusinessProposal;
  HandleBusinessProposalItemList;
end;

function TBusinessProposalBeforeSave.HandleBusinessProposal: IBusinessProposalBeforeSave;
begin
//
end;

function TBusinessProposalBeforeSave.HandleBusinessProposalItem(AEntity: TBusinessProposalItem): IBusinessProposalBeforeSave;
begin
//
end;

function TBusinessProposalBeforeSave.HandleBusinessProposalItemList: IBusinessProposalBeforeSave;
var
  lBusinessProposalItem: TBusinessProposalItem;
begin
  for lBusinessProposalItem in FEntity.business_proposal_item_list do
    HandleBusinessProposalItem(lBusinessProposalItem);
end;

class function TBusinessProposalBeforeSave.Make(AEntity: TBusinessProposal; AStateEnum: TEntityState): IBusinessProposalBeforeSave;
begin
  Result := Self.Create(AEntity, AStateEnum);
end;

end.

