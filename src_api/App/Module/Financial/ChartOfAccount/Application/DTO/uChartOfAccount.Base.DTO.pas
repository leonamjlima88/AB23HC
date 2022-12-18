unit uChartOfAccount.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TChartOfAccountBaseDTO = class
  private
    Fname: string;
    Fnote: string;
    Fis_analytical: SmallInt;
    Fhierarchy_code: string;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagString(100)]
    [SwagProp('hierarchy_code', 'Hierarquia', true)]
    property hierarchy_code: string read Fhierarchy_code write Fhierarchy_code;

    [SwagNumber(0,1)]
    [SwagProp('is_analytical', 'Analítico? [0=False, 1=True]', false)]
    property is_analytical: SmallInt read Fis_analytical write Fis_analytical;

    [SwagString]
    [SwagProp('note', 'Observação', false)]
    property note: string read Fnote write Fnote;
  end;

implementation

end.
