unit uCity.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uApplication.Types,
  System.Generics.Collections,
  uCity;

type
  TCityShowDTO = class
  private
    Fid: Int64;
    Fname: String;
    Fidentification: string;
    Fcountry_ibge_code: string;
    Fstate: string;
    Fcountry: string;
    Fibge_code: string;
    Fcreated_at: TDateTime;
    Fcreated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_name: String;
    Fupdated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fupdated_by_acl_user_name: String;
  public
    [SwagNumber]
    [SwagProp('id', 'ID', true)]
    property id: Int64 read Fid write Fid;

    [SwagString]
    [SwagProp('name', 'Nome', true)]
    property name: String read Fname write Fname;

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

    [SwagDate(DATETIME_DISPLAY_FORMAT)]
    [SwagProp('created_at', CREATED_AT_DISPLAY, true)]
    property created_at: TDateTime read Fcreated_at write Fcreated_at;

    [SwagNumber]
    [SwagProp('created_by_acl_user_id', CREATED_BY_ACL_USER_ID, true)]
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;

    [SwagString]
    [SwagProp('created_by_acl_user_name', CREATED_BY_ACL_USER_NAME, true)]
    property created_by_acl_user_name: String read Fcreated_by_acl_user_name write Fcreated_by_acl_user_name;

    [SwagDate(DATETIME_DISPLAY_FORMAT)]
    [SwagProp('updated_at', UPDATED_AT_DISPLAY)]
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;

    [SwagNumber]
    [SwagProp('updated_by_acl_user_id', UPDATED_BY_ACL_USER_ID)]
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;

    [SwagString]
    [SwagProp('updated_by_acl_user_name', UPDATED_BY_ACL_USER_NAME)]
    property updated_by_acl_user_name: String read Fupdated_by_acl_user_name write Fupdated_by_acl_user_name;

    class function FromEntity(ACity: TCity): TCityShowDTO;
  end;

  {$REGION 'Swagger DOC'}
  TCityShowResponseDTO = class(TResponseDTO)
  private
    Fdata: TCityShowDTO;
  public
    property data: TCityShowDTO read Fdata write Fdata;
  end;

  TCityIndexDataResponseDTO = class
  private
    Fmeta: TResponseMetaDTO;
    Fresult: TObjectList<TCityShowDTO>;
  public
    property result: TObjectList<TCityShowDTO> read Fresult write Fresult;
    property meta: TResponseMetaDTO read Fmeta write Fmeta;
  end;

  TCityIndexResponseDTO = class(TResponseDTO)
  private
    Fdata: TCityIndexDataResponseDTO;
  public
    property data: TCityIndexDataResponseDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation

uses
  XSuperObject;

{ TCityShowDTO }

class function TCityShowDTO.FromEntity(ACity: TCity): TCityShowDTO;
begin
  // Instanciar, retornar DTO e tratar campos diferenciados
  Result                          := TCityShowDTO.FromJSON(ACity.AsJSON);
  Result.created_by_acl_user_name := ACity.created_by_acl_user.name;
  Result.updated_by_acl_user_name := ACity.updated_by_acl_user.name;
end;

end.
