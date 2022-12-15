unit uPerson.Show.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uApplication.Types,
  System.Generics.Collections,
  uPerson,
  uPersonContact.DTO;

type
  TPersonShowDTO = class
  private
    Fid: Int64;
    Fname: String;
    Faddress_number: String;
    Fis_supplier: SmallInt;
    Fdistrict: String;
    Fis_seller: SmallInt;
    Fcompany_email: String;
    Finternet_page: String;
    Falias_name: String;
    Fis_final_customer: SmallInt;
    Fstate_registration: String;
    Ficms_taxpayer: SmallInt;
    Ffinancial_email: String;
    Freference_point: String;
    Fzipcode: String;
    Fis_employee: SmallInt;
    Fnote: String;
    Fcomplement: String;
    Fein: String;
    Fis_other: SmallInt;
    Fis_carrier: SmallInt;
    Fis_customer: SmallInt;
    Faddress: String;
    Fbank_note: String;
    Fphone_2: String;
    Fphone_3: String;
    Fcommercial_note: String;
    Fcity_id: Int64;
    Fphone_1: String;
    Fis_technician: SmallInt;
    Fmunicipal_registration: String;
    Fcity_ibge_code: String;
    Fcity_name: String;
    Fcity_state: String;
    Fcreated_at: TDateTime;
    Fcreated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_name: String;
    Fupdated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fupdated_by_acl_user_name: String;

    // OneToMany
    Fperson_contact_list: TObjectList<TPersonContactDTO>;
  public
    constructor create;
    destructor Destroy; override;

    [SwagNumber]
    [SwagProp('id', 'ID', true)]
    property id: Int64 read Fid write Fid;

    [SwagString]
    [SwagProp('name', 'Nome', true)]
    property name: String read Fname write Fname;

    [SwagString(100)]
    [SwagProp('alias_name', 'Apelido / Fantasia', true)]
    property alias_name: String read Falias_name write Falias_name;

    [SwagString(20)]
    [SwagProp('ein', 'CPF / CNPJ', false)]
    property ein: String read Fein write Fein;

    [SwagNumber]
    [SwagProp('icms_taxpayer', 'Contribuinte de ICMS', false)]
    property icms_taxpayer: SmallInt read Ficms_taxpayer write Ficms_taxpayer;

    [SwagString(20)]
    [SwagProp('state_registration', 'Inscrição Estadual', false)]
    property state_registration: String read Fstate_registration write Fstate_registration;

    [SwagString(20)]
    [SwagProp('municipal_registration', 'Inscrição Municipal', false)]
    property municipal_registration: String read Fmunicipal_registration write Fmunicipal_registration;

    [SwagString(10)]
    [SwagProp('zipcode', 'CEP', false)]
    property zipcode: String read Fzipcode write Fzipcode;

    [SwagString(100)]
    [SwagProp('address', 'Endereço', false)]
    property address: String read Faddress write Faddress;

    [SwagString(15)]
    [SwagProp('address_number', 'Número do endereço', false)]
    property address_number: String read Faddress_number write Faddress_number;

    [SwagString(100)]
    [SwagProp('complement', 'Complemento', false)]
    property complement: String read Fcomplement write Fcomplement;

    [SwagString(100)]
    [SwagProp('district', 'bairro', false)]
    property district: String read Fdistrict write Fdistrict;

    [SwagNumber]
    [SwagProp('city_id', 'ID da Cidade', false)]
    property city_id: Int64 read Fcity_id write Fcity_id;

    [SwagString(100)] {virtual}
    [SwagProp('city_name', 'Cidade', false)]
    property city_name: String read Fcity_name write Fcity_name;

    [SwagString(100)] {virtual}
    [SwagProp('city_state', 'Estado', false)]
    property city_state: String read Fcity_state write Fcity_state;

    [SwagString(100)] {virtual}
    [SwagProp('city_ibge_code', 'Código IBGE da Cidade', false)]
    property city_ibge_code: String read Fcity_ibge_code write Fcity_ibge_code;

    [SwagString(100)]
    [SwagProp('reference_point', 'Ponto de Referência', false)]
    property reference_point: String read Freference_point write Freference_point;

    [SwagString(40)]
    [SwagProp('phone_1', 'Telefone 1', false)]
    property phone_1: String read Fphone_1 write Fphone_1;

    [SwagString(40)]
    [SwagProp('phone_2', 'Telefone 2', false)]
    property phone_2: String read Fphone_2 write Fphone_2;

    [SwagString(40)]
    [SwagProp('phone_3', 'Telefone 3', false)]
    property phone_3: String read Fphone_3 write Fphone_3;

    [SwagString(100)]
    [SwagProp('company_email', 'E-mail da companhia', false)]
    property company_email: String read Fcompany_email write Fcompany_email;

    [SwagString(100)]
    [SwagProp('financial_email', 'E-mail do financeiro', false)]
    property financial_email: String read Ffinancial_email write Ffinancial_email;

    [SwagString(255)]
    [SwagProp('internet_page', 'Página de internet', false)]
    property internet_page: String read Finternet_page write Finternet_page;

    [SwagString]
    [SwagProp('note', 'Observação', false)]
    property note: String read Fnote write Fnote;

    [SwagString]
    [SwagProp('bank_note', 'Referência Bancária', false)]
    property bank_note: String read Fbank_note write Fbank_note;

    [SwagString]
    [SwagProp('commercial_note', 'Referência Comercial', false)]
    property commercial_note: String read Fcommercial_note write Fcommercial_note;

    [SwagNumber]
    [SwagProp('is_customer', 'Cliente? [0=false, 1=true]', false)]
    property is_customer: SmallInt read Fis_customer write Fis_customer;

    [SwagNumber]
    [SwagProp('is_seller', 'Vendedor? [0=false, 1=true]', false)]
    property is_seller: SmallInt read Fis_seller write Fis_seller;

    [SwagNumber]
    [SwagProp('is_supplier', 'Fornecedor? [0=false, 1=true]', false)]
    property is_supplier: SmallInt read Fis_supplier write Fis_supplier;

    [SwagNumber]
    [SwagProp('is_carrier', 'Transportador? [0=false, 1=true]', false)]
    property is_carrier: SmallInt read Fis_carrier write Fis_carrier;

    [SwagNumber]
    [SwagProp('is_technician', 'Técnico? [0=false, 1=true]', false)]
    property is_technician: SmallInt read Fis_technician write Fis_technician;

    [SwagNumber]
    [SwagProp('is_employee', 'Funcionário? [0=false, 1=true]', false)]
    property is_employee: SmallInt read Fis_employee write Fis_employee;

    [SwagNumber]
    [SwagProp('is_other', 'Outros? [0=false, 1=true]', false)]
    property is_other: SmallInt read Fis_other write Fis_other;

    [SwagNumber]
    [SwagProp('is_final_customer', 'Consumidor Final? [0=false, 1=true]', false)]
    property is_final_customer: SmallInt read Fis_final_customer write Fis_final_customer;

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

    // OneToMany
    property person_contact_list: TObjectList<TPersonContactDTO> read Fperson_contact_list write Fperson_contact_list;

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

constructor TPersonShowDTO.create;
begin
  Fperson_contact_list := TObjectList<TPersonContactDTO>.Create;
end;

destructor TPersonShowDTO.Destroy;
begin
  if Assigned(Fperson_contact_list) then Fperson_contact_list.Free;
  inherited;
end;

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
