unit uBusinessProposal.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  System.Generics.Collections,
  uBusinessProposalItem.Base.DTO,
  uApplication.Types;

type
  TBusinessProposalBaseDTO = class
  private
    Fperson_id: Int64;
    Fdelivery_forecast: string;
    Frequester: string;
    Fpayment_term_note: string;
    Fstatus: SmallInt;
    Fnote: string;
    Fexpiration_date: TDate;
    Fseller_id: Int64;
    Finternal_note: string;

    // OneToMany
    Fbusiness_proposal_item_list: TObjectList<TBusinessProposalItemBaseDTO>;
  public
    constructor Create;
    destructor Destroy; override;

    [SwagNumber]
    [SwagProp('person_id', 'ID do cliente', false)]
    property person_id: Int64 read Fperson_id write Fperson_id;

    [SwagString(100)]
    [SwagProp('requester', 'Solicitante', false)]
    property requester: string read Frequester write Frequester;

    [SwagDate(DATETIME_DISPLAY_FORMAT)]
    [SwagProp('expiration_date', CREATED_AT_DISPLAY, true)]
    property expiration_date: TDate read Fexpiration_date write Fexpiration_date;

    [SwagString(100)]
    [SwagProp('delivery_forecast', 'Previsão de entrega', false)]
    property delivery_forecast: string read Fdelivery_forecast write Fdelivery_forecast;

    [SwagNumber]
    [SwagProp('seller_id', 'ID do vendedor', true)]
    property seller_id: Int64 read Fseller_id write Fseller_id;

    [SwagString]
    [SwagProp('note', 'Observação', false)]
    property note: string read Fnote write Fnote;

    [SwagString]
    [SwagProp('internal_note', 'Observação interna', false)]
    property internal_note: string read Finternal_note write Finternal_note;

    [SwagString]
    [SwagProp('payment_term_note', 'Pagamento', false)]
    property payment_term_note: string read Fpayment_term_note write Fpayment_term_note;

    [SwagNumber]
    [SwagProp('status', 'Status [0-Pendente, 1-Aprovada, 2-Cancelada]')]
    property status: SmallInt read Fstatus write Fstatus;

    // OneToMany
    property business_proposal_item_list: TObjectList<TBusinessProposalItemBaseDTO> read Fbusiness_proposal_item_list write Fbusiness_proposal_item_list;
  end;

implementation

{ TBusinessProposalBaseDTO }

constructor TBusinessProposalBaseDTO.Create;
begin
  Fbusiness_proposal_item_list := TObjectList<TBusinessProposalItemBaseDTO>.Create;
end;

destructor TBusinessProposalBaseDTO.Destroy;
begin
  if Assigned(Fbusiness_proposal_item_list) then Fbusiness_proposal_item_list.Free;
  inherited;
end;

end.
