unit uCFOP.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TCFOPBaseDTO = class
  private
    Fname: string;
    Fcode: string;
    Foperation_type: SmallInt;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagString(10)]
    [SwagProp('code', 'Código do CFOP. Ex: 5405', true)]
    property code: string read Fcode write Fcode;

    [SwagNumber(0, 1)]
    [SwagProp('operation_type', 'Tipo de Operação [0-Entrada, 1-Saída]', false)]
    property operation_type: SmallInt read Foperation_type write Foperation_type;
  end;

implementation

end.
