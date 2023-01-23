unit uSale.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  System.Generics.Collections,
  uSaleItem.Base.DTO,
  uSalePayment.Base.DTO,
  uApplication.Types,
  uSaleStatus.Types;

type
  TSaleBaseDTO = class
  private
    Fperson_id: Int64;
    Fseller_id: Int64;
    Fnote: string;
    Finternal_note: string;
    Fstatus: TSaleStatus;
    Fpayment_increase: SmallInt;
    Fpayment_discount: SmallInt;

    // OneToMany
    Fsale_item_list: TObjectList<TSaleItemBaseDTO>;
    Fsale_payment_list: TObjectList<TSalePaymentBaseDTO>;
  public
    constructor Create;
    destructor Destroy; override;

    [SwagNumber]
    [SwagProp('person_id', 'ID do cliente', false)]
    property person_id: Int64 read Fperson_id write Fperson_id;

    [SwagNumber]
    [SwagProp('seller_id', 'ID do vendedor', true)]
    property seller_id: Int64 read Fseller_id write Fseller_id;

    [SwagString]
    [SwagProp('note', 'Observação', false)]
    property note: string read Fnote write Fnote;

    [SwagString]
    [SwagProp('internal_note', 'Observação interna', false)]
    property internal_note: string read Finternal_note write Finternal_note;

    [SwagNumber]
    [SwagProp('status', 'Status [0-Pendente, 1-Aprovada, 2-Cancelada]')]
    property status: TSaleStatus read Fstatus write Fstatus;

    [SwagNumber]
    [SwagProp('payment_discount', 'Desconto em pagamento ($)')]
    property payment_discount: SmallInt read Fpayment_discount write Fpayment_discount;

    [SwagNumber]
    [SwagProp('payment_increase', 'Acréscimo em pagamento ($)')]
    property payment_increase: SmallInt read Fpayment_increase write Fpayment_increase;

    // OneToMany
    property sale_item_list: TObjectList<TSaleItemBaseDTO> read Fsale_item_list write Fsale_item_list;
    property sale_payment_list: TObjectList<TSalePaymentBaseDTO> read Fsale_payment_list write Fsale_payment_list;
  end;

implementation

{ TSaleBaseDTO }

constructor TSaleBaseDTO.Create;
begin
  Fsale_item_list    := TObjectList<TSaleItemBaseDTO>.Create;
  Fsale_payment_list := TObjectList<TSalePaymentBaseDTO>.Create;
end;

destructor TSaleBaseDTO.Destroy;
begin
  if Assigned(Fsale_item_list)    then Fsale_item_list.Free;
  if Assigned(Fsale_payment_list) then Fsale_payment_list.Free;
  inherited;
end;

end.
