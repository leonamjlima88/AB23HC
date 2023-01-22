unit uBusinessProposalItem;

interface

uses
  uBase.Entity,
  uProduct,
  uUnit;

type
  TBusinessProposalItem = class(TBaseEntity)
  private
    Funit_discount: Double;
    Fproduct_id: Int64;
    Fprice: Double;
    Fbusiness_proposal_id: Int64;
    Fid: Int64;
    Fnote: String;
    Fquantity: Double;

    // OneToOne
    Fproduct: TProduct;
    Fproduct_unit: TUnit;

    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property business_proposal_id: Int64 read Fbusiness_proposal_id write Fbusiness_proposal_id;
    property product_id: Int64 read Fproduct_id write Fproduct_id;
    property note: String read Fnote write Fnote;
    property quantity: Double read Fquantity write Fquantity;
    property price: Double read Fprice write Fprice;
    property unit_discount: Double read Funit_discount write Funit_discount;

    // OneToOne
    property product: TProduct read Fproduct write Fproduct;
    property product_unit: TUnit read Fproduct_unit write Fproduct_unit;

    // CalcFields
    function subtotal: Double;
    function total: Double;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils,
  uHlp,
  uApplication.Types;

{ TBusinessProposalItem }

constructor TBusinessProposalItem.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TBusinessProposalItem.Destroy;
begin
  if Assigned(Fproduct)      then Fproduct.Free;
  if Assigned(Fproduct_unit) then Fproduct_unit.Free;
  inherited;
end;

procedure TBusinessProposalItem.Initialize;
begin
  Fproduct      := TProduct.Create;
  Fproduct_unit := TUnit.Create;
end;

function TBusinessProposalItem.subtotal: Double;
begin
  Result := Fquantity * Fprice;
end;

function TBusinessProposalItem.total: Double;
begin
  Result := subtotal - (Fquantity * Funit_discount);
end;

procedure TBusinessProposalItem.Validate;
begin
  if (Fquantity <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['business_proposal.quantity']));
end;

end.
