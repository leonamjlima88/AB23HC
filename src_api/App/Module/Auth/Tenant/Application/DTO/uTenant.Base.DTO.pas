unit uTenant.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  System.Generics.Collections;

type
  TTenantBaseDTO = class
  private
    Fname: string;
    Faddress_number: String;
    Fdistrict: String;
    Fcompany_email: String;
    Finternet_page: String;
    Falias_name: String;
    Fstate_registration: String;
    Ficms_taxpayer: SmallInt;
    Ffinancial_email: String;
    Freference_point: String;
    Fzipcode: String;
    Fnote: String;
    Fcomplement: String;
    Flegal_entity_number: String;
    Faddress: String;
    Fbank_note: String;
    Fphone_2: String;
    Fphone_3: String;
    Fcommercial_note: String;
    Fcity_id: Int64;
    Fphone_1: String;
    Fmunicipal_registration: String;
    Fcreated_by_acl_user_id: Int64;
    Fupdated_by_acl_user_id: Int64;
  public
    constructor Create;
    destructor Destroy; override;

    [SwagString(100)]
    [SwagProp('name', 'Nome / Raz�o Social', true)]
    property name: string read Fname write Fname;

    [SwagString(100)]
    [SwagProp('alias_name', 'Apelido / Fantasia', true)]
    property alias_name: String read Falias_name write Falias_name;

    [SwagString(20)]
    [SwagProp('legal_entity_number', 'CPF / CNPJ', false)]
    property legal_entity_number: String read Flegal_entity_number write Flegal_entity_number;

    [SwagNumber]
    [SwagProp('icms_taxpayer', 'Contribuinte de ICMS', false)]
    property icms_taxpayer: SmallInt read Ficms_taxpayer write Ficms_taxpayer;

    [SwagString(20)]
    [SwagProp('state_registration', 'Inscri��o Estadual', false)]
    property state_registration: String read Fstate_registration write Fstate_registration;

    [SwagString(20)]
    [SwagProp('municipal_registration', 'Inscri��o Municipal', false)]
    property municipal_registration: String read Fmunicipal_registration write Fmunicipal_registration;

    [SwagString(8, 8)]
    [SwagProp('zipcode', 'CEP', false)]
    property zipcode: String read Fzipcode write Fzipcode;

    [SwagString(100)]
    [SwagProp('address', 'Endere�o', false)]
    property address: String read Faddress write Faddress;

    [SwagString(15)]
    [SwagProp('address_number', 'N�mero do endere�o', false)]
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

    [SwagString(100)]
    [SwagProp('reference_point', 'Ponto de Refer�ncia', false)]
    property reference_point: String read Freference_point write Freference_point;

    [SwagString(14)]
    [SwagProp('phone_1', 'Telefone 1', false)]
    property phone_1: String read Fphone_1 write Fphone_1;

    [SwagString(14)]
    [SwagProp('phone_2', 'Telefone 2', false)]
    property phone_2: String read Fphone_2 write Fphone_2;

    [SwagString(14)]
    [SwagProp('phone_3', 'Telefone 3', false)]
    property phone_3: String read Fphone_3 write Fphone_3;

    [SwagString(100)]
    [SwagProp('company_email', 'E-mail da companhia', false)]
    property company_email: String read Fcompany_email write Fcompany_email;

    [SwagString(100)]
    [SwagProp('financial_email', 'E-mail do financeiro', false)]
    property financial_email: String read Ffinancial_email write Ffinancial_email;

    [SwagString(255)]
    [SwagProp('internet_page', 'P�gina de internet', false)]
    property internet_page: String read Finternet_page write Finternet_page;

    [SwagString]
    [SwagProp('note', 'Observa��o', false)]
    property note: String read Fnote write Fnote;

    [SwagString]
    [SwagProp('bank_note', 'Refer�ncia Banc�ria', false)]
    property bank_note: String read Fbank_note write Fbank_note;

    [SwagString]
    [SwagProp('commercial_note', 'Refer�ncia Comercial', false)]
    property commercial_note: String read Fcommercial_note write Fcommercial_note;
  end;

implementation

{ TTenantBaseDTO }

constructor TTenantBaseDTO.Create;
begin
end;

destructor TTenantBaseDTO.Destroy;
begin
  inherited;
end;

end.
