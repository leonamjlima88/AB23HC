unit uBusinessProposal.Mapper;

interface

uses
  uMapper.Interfaces,
  uBusinessProposal,
  uBusinessProposal.DTO,
  uBusinessProposal.Show.DTO;

type
  TBusinessProposalMapper = class(TInterfacedObject, IMapper)
  public
    class function BusinessProposalDtoToEntity(ABusinessProposalDTO: TBusinessProposalDTO): TBusinessProposal;
    class function EntityToBusinessProposalShowDto(ABusinessProposal: TBusinessProposal): TBusinessProposalShowDTO;
  end;

implementation

uses
  uBusinessProposalItem,
  XSuperObject,
  uLegalEntityNumber.VO,
  System.SysUtils,
  uApplication.Types,
  uBusinessProposalItem.Base.DTO;

{ TBusinessProposalMapper }

class function TBusinessProposalMapper.EntityToBusinessProposalShowDto(ABusinessProposal: TBusinessProposal): TBusinessProposalShowDTO;
var
  lBusinessProposalShowDTO: TBusinessProposalShowDTO;
  lI: Integer;
begin
  if not Assigned(ABusinessProposal) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lBusinessProposalShowDTO := TBusinessProposalShowDTO.FromJSON(ABusinessProposal.AsJSON);

  // Tratar campos específicos
  lBusinessProposalShowDTO.person_name                      := ABusinessProposal.person.name;
  lBusinessProposalShowDTO.seller_name                      := ABusinessProposal.seller.name;
  lBusinessProposalShowDTO.sum_business_proposal_item_total := ABusinessProposal.sum_business_proposal_item_total;
  lBusinessProposalShowDTO.created_by_acl_user_name         := ABusinessProposal.created_by_acl_user.name;
  lBusinessProposalShowDTO.updated_by_acl_user_name         := ABusinessProposal.updated_by_acl_user.name;

  for lI := 0 to Pred(lBusinessProposalShowDTO.business_proposal_item_list.Count) do
  begin
    With lBusinessProposalShowDTO.business_proposal_item_list.Items[lI] do
    begin
      product_name      := ABusinessProposal.business_proposal_item_list.Items[lI].product.name;
      product_unit_id   := ABusinessProposal.business_proposal_item_list.Items[lI].product_unit.id;
      product_unit_name := ABusinessProposal.business_proposal_item_list.Items[lI].product_unit.name;
      subtotal          := ABusinessProposal.business_proposal_item_list.Items[lI].subtotal;
      total             := ABusinessProposal.business_proposal_item_list.Items[lI].total;
    end;
  end;

  Result := lBusinessProposalShowDTO;
end;

class function TBusinessProposalMapper.BusinessProposalDtoToEntity(ABusinessProposalDTO: TBusinessProposalDTO): TBusinessProposal;
var
  lBusinessProposal: TBusinessProposal;
begin
  // Mapear campos por JSON
  lBusinessProposal := TBusinessProposal.FromJSON(ABusinessProposalDTO.AsJSON);

  Result := lBusinessProposal;
end;

end.
