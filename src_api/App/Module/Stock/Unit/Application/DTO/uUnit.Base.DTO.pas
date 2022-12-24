unit uUnit.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TUnitBaseDTO = class
  private
    Fname: string;
    Fdescription: string;
  public
    [SwagString(10)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagString(100)]
    [SwagProp('description', 'Descrição', false)]
    property description: string read Fdescription write Fdescription;
  end;

implementation

end.
