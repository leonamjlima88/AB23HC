unit uProduct.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uApplication.Types,
  System.Generics.Collections,
  uProduct.Base.DTO;

type
  TProductShowDTO = class(TProductBaseDTO)
  private
    Fid: Int64;
    Fmarketup: Double;
    Fcategory_name: String;
    Fsize_name: String;
    Fbrand_name: String;
    Funit_name: String;
    Fncm_name: String;
    Fncm_ncm: String;
    Fstorage_location_name: String;
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

    [SwagNumber]
    [SwagProp('marketup', 'Lucro')]
    property marketup: Double read Fmarketup write Fmarketup;

    [SwagString(100)] {virtual}
    [SwagProp('unit_name', 'Unidade', true)]
    property unit_name: String read Funit_name write Funit_name;

    [SwagString(255)] {virtual}
    [SwagProp('ncm_name', 'NCM (Nome)', true)]
    property ncm_name: String read Fncm_name write Fncm_name;

    [SwagString] {virtual}
    [SwagProp('ncm_ncm', 'NCM (Código)', true)]
    property ncm_ncm: String read Fncm_ncm write Fncm_ncm;

    [SwagString(100)] {virtual}
    [SwagProp('category_name', 'Categoria', false)]
    property category_name: String read Fcategory_name write Fcategory_name;

    [SwagString(100)] {virtual}
    [SwagProp('brand_name', 'Marca', false)]
    property brand_name: String read Fbrand_name write Fbrand_name;

    [SwagString(100)] {virtual}
    [SwagProp('size_name', 'Tamanho', false)]
    property size_name: String read Fsize_name write Fsize_name;

    [SwagString(100)] {virtual}
    [SwagProp('storage_location_name', 'Local de Armazenamento', false)]
    property storage_location_name: String read Fstorage_location_name write Fstorage_location_name;

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
  end;

  {$REGION 'Swagger DOC'}
  TProductShowResponseDTO = class(TResponseDTO)
  private
    Fdata: TProductShowDTO;
  public
    property data: TProductShowDTO read Fdata write Fdata;
  end;

  TProductIndexDataResponseDTO = class
  private
    Fmeta: TResponseMetaDTO;
    Fresult: TObjectList<TProductShowDTO>;
  public
    property result: TObjectList<TProductShowDTO> read Fresult write Fresult;
    property meta: TResponseMetaDTO read Fmeta write Fmeta;
  end;

  TProductIndexResponseDTO = class(TResponseDTO)
  private
    Fdata: TProductIndexDataResponseDTO;
  public
    property data: TProductIndexDataResponseDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation

end.
