unit uPersonShowByIdAndPersonType.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TPersonShowByIdAndPersonTypeDTO = class
  private
    Fis_supplier: SmallInt;
    Fis_seller: SmallInt;
    Fid: Int64;
    Fis_employee: SmallInt;
    Fis_other: SmallInt;
    Fis_carrier: SmallInt;
    Fis_customer: SmallInt;
    Ftenant_id: Int64;
    Fis_technician: SmallInt;
  public
    [SwagNumber]
    [SwagProp('id', 'ID', true)]
    property id: Int64 read Fid write Fid;

    [SwagNumber]
    [SwagProp('is_customer', 'Cliente?', false)]
    property is_customer: SmallInt read Fis_customer write Fis_customer;

    [SwagNumber]
    [SwagProp('is_seller', 'Vendedor?', false)]
    property is_seller: SmallInt read Fis_seller write Fis_seller;

    [SwagNumber]
    [SwagProp('is_supplier', 'Fornecedor?', false)]
    property is_supplier: SmallInt read Fis_supplier write Fis_supplier;

    [SwagNumber]
    [SwagProp('is_carrier', 'Transportador?', false)]
    property is_carrier: SmallInt read Fis_carrier write Fis_carrier;

    [SwagNumber]
    [SwagProp('is_technician', 'Técnico?', false)]
    property is_technician: SmallInt read Fis_technician write Fis_technician;

    [SwagNumber]
    [SwagProp('is_employee', 'Funcionário?', false)]
    property is_employee: SmallInt read Fis_employee write Fis_employee;

    [SwagNumber]
    [SwagProp('is_other', 'Outros?', false)]
    property is_other: SmallInt read Fis_other write Fis_other;

    [SwagIgnore]
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;
  end;

implementation

end.
