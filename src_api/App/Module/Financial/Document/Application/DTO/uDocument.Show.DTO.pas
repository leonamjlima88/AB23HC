unit uDocument.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uApplication.Types,
  System.Generics.Collections,
  uDocument,
  uDocument.Base.DTO;

type
  TDocumentShowDTO = class(TDocumentBaseDTO)
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

    class function FromEntity(ADocument: TDocument): TDocumentShowDTO;
  end;

  {$REGION 'Swagger DOC'}
  TDocumentShowResponseDTO = class(TResponseDTO)
  private
    Fdata: TDocumentShowDTO;
  public
    property data: TDocumentShowDTO read Fdata write Fdata;
  end;

  TDocumentIndexDataResponseDTO = class
  private
    Fmeta: TResponseMetaDTO;
    Fresult: TObjectList<TDocumentShowDTO>;
  public
    property result: TObjectList<TDocumentShowDTO> read Fresult write Fresult;
    property meta: TResponseMetaDTO read Fmeta write Fmeta;
  end;

  TDocumentIndexResponseDTO = class(TResponseDTO)
  private
    Fdata: TDocumentIndexDataResponseDTO;
  public
    property data: TDocumentIndexDataResponseDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation

uses
  XSuperObject;

{ TDocumentShowDTO }

class function TDocumentShowDTO.FromEntity(ADocument: TDocument): TDocumentShowDTO;
begin
  // Instanciar, retornar DTO e tratar campos diferenciados
  Result                          := TDocumentShowDTO.FromJSON(ADocument.AsJSON);
  Result.created_by_acl_user_name := ADocument.created_by_acl_user.name;
  Result.updated_by_acl_user_name := ADocument.updated_by_acl_user.name;
end;

end.
