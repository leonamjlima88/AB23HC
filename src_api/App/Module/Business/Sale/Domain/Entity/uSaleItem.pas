unit uSaleItem;

interface

uses
  uBase.Entity,
  uProduct,
  uUnit;

type
  TSaleItem = class(TBaseEntity)
  private
    Funit_discount: Double;
    Fproduct_id: Int64;
    Fprice: Double;
    Fsale_id: Int64;
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
    property sale_id: Int64 read Fsale_id write Fsale_id;
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

{ TSaleItem }

constructor TSaleItem.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TSaleItem.Destroy;
begin
  if Assigned(Fproduct)      then Fproduct.Free;
  if Assigned(Fproduct_unit) then Fproduct_unit.Free;
  inherited;
end;

procedure TSaleItem.Initialize;
begin
  Fproduct      := TProduct.Create;
  Fproduct_unit := TUnit.Create;
end;

function TSaleItem.subtotal: Double;
begin
  Result := Fquantity * Fprice;
end;

function TSaleItem.total: Double;
begin
  Result := subtotal - (Fquantity * Funit_discount);
end;

procedure TSaleItem.Validate;
begin
  if (Fquantity <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['sale.quantity']));
end;

end.
