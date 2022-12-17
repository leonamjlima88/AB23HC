unit uBrand.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TBrandBaseDTO = class
  private
    Fname: string;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;
  end;

implementation

end.
