unit uBank.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TBankBaseDTO = class
  private
    Fname: string;
    Fcode: string;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagString(3)]
    [SwagProp('code', 'Código', true)]
    property code: string read Fcode write Fcode;
  end;

implementation

end.
