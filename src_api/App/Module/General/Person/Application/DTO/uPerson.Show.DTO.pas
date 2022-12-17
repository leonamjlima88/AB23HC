unit uPerson.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uApplication.Types,
  System.Generics.Collections,
  uPerson.Base.DTO,
  uPerson;

type
  TPersonShowDTO = class(TPersonBaseDTO)
  private
    Fupdated_at: TDateTime;
    Fupdated_by_acl_user_name: String;
    Fcreated_at: TDateTime;
    Fcreated_by_acl_user_name: String;
    Fcity_ibge_code: String;
    Fcity_name: String;
    Fid: Int64;
    Fupdated_by_acl_user_id: Int64;
    Fcity_state: String;
    Fcreated_by_acl_user_id: Int64;
  public
    [SwagNumber]
    [SwagProp('id', 'ID', true)]
    property id: Int64 read Fid write Fid;

    [SwagString(100)] {virtual}
    [SwagProp('city_name', 'Cidade', false)]
    property city_name: String read Fcity_name write Fcity_name;

    [SwagString(100)] {virtual}
    [SwagProp('city_state', 'Estado', false)]
    property city_state: String read Fcity_state write Fcity_state;

    [SwagString(100)] {virtual}
    [SwagProp('city_ibge_code', 'Código IBGE da Cidade', false)]
    property city_ibge_code: String read Fcity_ibge_code write Fcity_ibge_code;

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

    class function FromEntity(APerson: TPerson): TPersonShowDTO;
  end;

  {$REGION 'Swagger DOC'}
  TPersonShowResponseDTO = class(TResponseDTO)
  private
    Fdata: TPersonShowDTO;
  public
    property data: TPersonShowDTO read Fdata write Fdata;
  end;

  TPersonIndexDataResponseDTO = class
  private
    Fmeta: TResponseMetaDTO;
    Fresult: TObjectList<TPersonShowDTO>;
  public
    property result: TObjectList<TPersonShowDTO> read Fresult write Fresult;
    property meta: TResponseMetaDTO read Fmeta write Fmeta;
  end;

  TPersonIndexResponseDTO = class(TResponseDTO)
  private
    Fdata: TPersonIndexDataResponseDTO;
  public
    property data: TPersonIndexDataResponseDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation

uses
  XSuperObject;

{ TPersonShowDTO }

class function TPersonShowDTO.FromEntity(APerson: TPerson): TPersonShowDTO;
begin
  // Instanciar, retornar DTO e tratar campos diferenciados
  Result                          := TPersonShowDTO.FromJSON(APerson.AsJSON);
  Result.ein                      := APerson.ein;
  Result.city_name                := APerson.city.name;
  Result.city_state               := APerson.city.state;
  Result.city_ibge_code           := APerson.city.ibge_code;
  Result.created_by_acl_user_name := APerson.created_by_acl_user.name;
  Result.updated_by_acl_user_name := APerson.updated_by_acl_user.name;
end;

end.
