unit uBusinessProposal.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uApplication.Types,
  System.Generics.Collections,
  uBusinessProposal.Base.DTO;

type
  TBusinessProposalShowDTO = class(TBusinessProposalBaseDTO)
  private
    Fupdated_at: TDateTime;
    Fupdated_by_acl_user_name: String;
    Fcreated_at: TDateTime;
    Fseller_name: String;
    Fcreated_by_acl_user_name: String;
    Fid: Int64;
    Fupdated_by_acl_user_id: Int64;
    Fperson_name: String;
    Fcreated_by_acl_user_id: Int64;
    Fsum_business_proposal_item_total: Double;
  public
    [SwagNumber]
    [SwagProp('id', 'ID', true)]
    property id: Int64 read Fid write Fid;

    [SwagString(100)] {virtual}
    [SwagProp('person_name', 'Nome do cliente', true)]
    property person_name: String read Fperson_name write Fperson_name;

    [SwagString(100)] {virtual}
    [SwagProp('seller_name', 'Estado', false)]
    property seller_name: String read Fseller_name write Fseller_name;

    [SwagNumber] {calcFields}
    [SwagProp('sum_business_proposal_item_total', 'sum_business_proposal_item_total', false)]
    property sum_business_proposal_item_total: Double read Fsum_business_proposal_item_total write Fsum_business_proposal_item_total;

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
  TBusinessProposalShowResponseDTO = class(TResponseDTO)
  private
    Fdata: TBusinessProposalShowDTO;
  public
    property data: TBusinessProposalShowDTO read Fdata write Fdata;
  end;

  TBusinessProposalIndexDataResponseDTO = class
  private
    Fmeta: TResponseMetaDTO;
    Fresult: TObjectList<TBusinessProposalShowDTO>;
  public
    property result: TObjectList<TBusinessProposalShowDTO> read Fresult write Fresult;
    property meta: TResponseMetaDTO read Fmeta write Fmeta;
  end;

  TBusinessProposalIndexResponseDTO = class(TResponseDTO)
  private
    Fdata: TBusinessProposalIndexDataResponseDTO;
  public
    property data: TBusinessProposalIndexDataResponseDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation

uses
  XSuperObject;

end.
