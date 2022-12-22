unit uPaymentTerm.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uApplication.Types,
  System.Generics.Collections,
  uPaymentTerm.Base.DTO;

type
  TPaymentTermShowDTO = class(TPaymentTermBaseDTO)
  private
    Fid: Int64;
    Fcreated_at: TDateTime;
    Fcreated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_name: String;
    Fupdated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fupdated_by_acl_user_name: String;
    Fdocument_name: String;
    Fbank_account_name: String;
  public
    [SwagNumber]
    [SwagProp('id', 'ID', true)]
    property id: Int64 read Fid write Fid;

    [SwagString(100)] {virtual}
    [SwagProp('bank_account_name', 'Conta bancária', true)]
    property bank_account_name: String read Fbank_account_name write Fbank_account_name;

    [SwagString(100)] {virtual}
    [SwagProp('document_name', 'Documento', true)]
    property document_name: String read Fdocument_name write Fdocument_name;

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
  TPaymentTermShowResponseDTO = class(TResponseDTO)
  private
    Fdata: TPaymentTermShowDTO;
  public
    property data: TPaymentTermShowDTO read Fdata write Fdata;
  end;

  TPaymentTermIndexDataResponseDTO = class
  private
    Fmeta: TResponseMetaDTO;
    Fresult: TObjectList<TPaymentTermShowDTO>;
  public
    property result: TObjectList<TPaymentTermShowDTO> read Fresult write Fresult;
    property meta: TResponseMetaDTO read Fmeta write Fmeta;
  end;

  TPaymentTermIndexResponseDTO = class(TResponseDTO)
  private
    Fdata: TPaymentTermIndexDataResponseDTO;
  public
    property data: TPaymentTermIndexDataResponseDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation


end.
