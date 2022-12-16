unit uCity.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TCityBaseDTO = class
  private
    Fname: string;
    Fidentification: string;
    Fcountry_ibge_code: string;
    Fstate: string;
    Fcountry: string;
    Fibge_code: string;
    Fcreated_by_acl_user_id: Int64;
    Fupdated_by_acl_user_id: Int64;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagString(2)]
    [SwagProp('state', 'Estado', true)]
    property state: string read Fstate write Fstate;

    [SwagString(100)]
    [SwagProp('country', 'País', true)]
    property country: string read Fcountry write Fcountry;

    [SwagString(30)]
    [SwagProp('ibge_code', 'Código IBGE da Cidade', true)]
    property ibge_code: string read Fibge_code write Fibge_code;

    [SwagString(30)]
    [SwagProp('country_ibge_code', 'Código IBGE do País', true)]
    property country_ibge_code: string read Fcountry_ibge_code write Fcountry_ibge_code;

    [SwagString(100)]
    [SwagProp('identification', 'Identificação', false)]
    property identification: string read Fidentification write Fidentification;
  end;

implementation

end.
