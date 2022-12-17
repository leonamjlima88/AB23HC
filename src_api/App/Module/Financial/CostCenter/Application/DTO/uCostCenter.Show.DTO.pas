unit uCostCenter.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uApplication.Types,
  System.Generics.Collections,
  uCostCenter,
  uCostCenter.Base.DTO;

type
  TCostCenterShowDTO = class(TCostCenterBaseDTO)
  private
    Fid: Int64;
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

    class function FromEntity(ACostCenter: TCostCenter): TCostCenterShowDTO;
  end;

  {$REGION 'Swagger DOC'}
  TCostCenterShowResponseDTO = class(TResponseDTO)
  private
    Fdata: TCostCenterShowDTO;
  public
    property data: TCostCenterShowDTO read Fdata write Fdata;
  end;

  TCostCenterIndexDataResponseDTO = class
  private
    Fmeta: TResponseMetaDTO;
    Fresult: TObjectList<TCostCenterShowDTO>;
  public
    property result: TObjectList<TCostCenterShowDTO> read Fresult write Fresult;
    property meta: TResponseMetaDTO read Fmeta write Fmeta;
  end;

  TCostCenterIndexResponseDTO = class(TResponseDTO)
  private
    Fdata: TCostCenterIndexDataResponseDTO;
  public
    property data: TCostCenterIndexDataResponseDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation

uses
  XSuperObject;

{ TCostCenterShowDTO }

class function TCostCenterShowDTO.FromEntity(ACostCenter: TCostCenter): TCostCenterShowDTO;
begin
  // Instanciar, retornar DTO e tratar campos diferenciados
  Result                          := TCostCenterShowDTO.FromJSON(ACostCenter.AsJSON);
  Result.created_by_acl_user_name := ACostCenter.created_by_acl_user.name;
  Result.updated_by_acl_user_name := ACostCenter.updated_by_acl_user.name;
end;

end.
