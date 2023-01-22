unit uSale.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uApplication.Types,
  System.Generics.Collections,
  uSale.Base.DTO;

type
  TSaleShowDTO = class(TSaleBaseDTO)
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
    Fsum_sale_item_total: Double;
    Fsum_sale_payment_amount: Double;
    Fpayment_total: Double;
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
    [SwagProp('sum_sale_item_total', 'Total dos itens', false)]
    property sum_sale_item_total: Double read Fsum_sale_item_total write Fsum_sale_item_total;

    [SwagNumber] {calcFields}
    [SwagProp('sum_sale_payment_amount', 'Total do pagamento', false)]
    property sum_sale_payment_amount: Double read Fsum_sale_payment_amount write Fsum_sale_payment_amount;

    [SwagNumber] {calcFields}
    [SwagProp('payment_total', 'Total do pagamento com acréscimo/desconto', false)]
    property payment_total: Double read Fpayment_total write Fpayment_total;

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
  TSaleShowResponseDTO = class(TResponseDTO)
  private
    Fdata: TSaleShowDTO;
  public
    property data: TSaleShowDTO read Fdata write Fdata;
  end;

  TSaleIndexDataResponseDTO = class
  private
    Fmeta: TResponseMetaDTO;
    Fresult: TObjectList<TSaleShowDTO>;
  public
    property result: TObjectList<TSaleShowDTO> read Fresult write Fresult;
    property meta: TResponseMetaDTO read Fmeta write Fmeta;
  end;

  TSaleIndexResponseDTO = class(TResponseDTO)
  private
    Fdata: TSaleIndexDataResponseDTO;
  public
    property data: TSaleIndexDataResponseDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation

uses
  XSuperObject;

end.
