unit uNCM.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TNCMBaseDTO = class
  private
    Fname: string;
    Fnational_rate: double;
    Fstate_rate: double;
    Fcest: string;
    Fadditional_information: string;
    Fncm: string;
    Fstart_of_validity: TDate;
    Fimported_rate: double;
    Fmunicipal_rate: double;
    Fend_of_validity: TDate;
  public
    [SwagString(255)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagString(8)]
    [SwagProp('ncm', 'NCM', true)]
    property ncm: string read Fncm write Fncm;

    [SwagNumber]
    [SwagProp('national_rate', 'Alíquota nacional', false)]
    property national_rate: double read Fnational_rate write Fnational_rate;

    [SwagNumber]
    [SwagProp('imported_rate', 'Alíquota importada', false)]
    property imported_rate: double read Fimported_rate write Fimported_rate;

    [SwagNumber]
    [SwagProp('state_rate', 'Alíquota estadual', false)]
    property state_rate: double read Fstate_rate write Fstate_rate;

    [SwagNumber]
    [SwagProp('municipal_rate', 'Alíquota municipal', false)]
    property municipal_rate: double read Fmunicipal_rate write Fmunicipal_rate;

    [SwagString(45)]
    [SwagProp('cest', 'CEST', false)]
    property cest: string read Fcest write Fcest;

    [SwagString]
    [SwagProp('additional_information', 'Informação adicional', false)]
    property additional_information: string read Fadditional_information write Fadditional_information;

    [SwagDate('YYYY-MM-DD')]
    [SwagProp('start_of_validity', 'Validade inicial', false)]
    property start_of_validity: TDate read Fstart_of_validity write Fstart_of_validity;

    [SwagDate('YYYY-MM-DD')]
    [SwagProp('end_of_validity', 'Validade final', false)]
    property end_of_validity: TDate read Fend_of_validity write Fend_of_validity;
  end;

implementation

end.
