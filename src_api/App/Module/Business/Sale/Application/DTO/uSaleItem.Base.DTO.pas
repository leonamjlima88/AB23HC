unit uSaleItem.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TSaleItemBaseDTO = class
  private
    Funit_discount: Double;
    Fproduct_id: Int64;
    Fprice: Double;
    Fid: Int64;
    Fnote: String;
    Fquantity: Double;
    Fsubtotal: Double;
    Ftotal: Double;
    Fproduct_unit_name: String;
    Fproduct_name: String;
    Fproduct_unit_id: Int64;
  public
    [SwagNumber]
    [SwagProp('id', 'ID', false)]
    property id: Int64 read Fid write Fid;

    [SwagNumber]
    [SwagProp('product_id', 'ID do produto', true)]
    property product_id: Int64 read Fproduct_id write Fproduct_id;

    [SwagString(255)]
    [SwagProp('note', 'Observação', false)]
    property note: String read Fnote write Fnote;

    [SwagNumber]
    [SwagProp('quantity', 'Quantidade', false)]
    property quantity: Double read Fquantity write Fquantity;

    [SwagNumber]
    [SwagProp('price', 'Preço', false)]
    property price: Double read Fprice write Fprice;

    [SwagNumber]
    [SwagProp('unit_discount', 'Desconto por unidade', false)]
    property unit_discount: Double read Funit_discount write Funit_discount;

    [SwagNumber] {calcFields}
    [SwagProp('subtotal', 'Subtotal', false)]
    property subtotal: Double read Fsubtotal write Fsubtotal;

    [SwagNumber] {calcFields}
    [SwagProp('total', 'total', false)]
    property total: Double read Ftotal write Ftotal;

    [SwagString(255)] {virtual}
    [SwagProp('product_name', 'Nome do produto', false)]
    property product_name: String read Fproduct_name write Fproduct_name;

    [SwagNumber] {virtual}
    [SwagProp('product_unit_id', 'ID da unidade de medida', false)]
    property product_unit_id: Int64 read Fproduct_unit_id write Fproduct_unit_id;

    [SwagString(100)] {virtual}
    [SwagProp('product_unit_name', 'Unidade de medida', false)]
    property product_unit_name: String read Fproduct_unit_name write Fproduct_unit_name;
  end;

implementation

end.
