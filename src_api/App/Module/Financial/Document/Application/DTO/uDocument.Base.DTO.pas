unit uDocument.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TDocumentBaseDTO = class
  private
    Fname: string;
    Fis_release_as_completed: SmallInt;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagNumber]
    [SwagProp('is_release_as_completed', 'Lançar documento com status de baixa em financeiro', false)]
    property is_release_as_completed: SmallInt read Fis_release_as_completed write Fis_release_as_completed;
  end;

implementation

end.
