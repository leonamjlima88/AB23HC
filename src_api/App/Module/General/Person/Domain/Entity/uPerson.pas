unit uPerson;

interface

uses
  uApplication.Types,
  uAclUser,
  uBase.Entity,
  Data.DB,
  uCity,
  uPersonContact,
  System.Generics.Collections,
  XSuperObject,
  uLegalEntityNumber.VO;

type
  TPerson = class(TBaseEntity)
  private
    Fid: Int64;
    Fname: string;
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
    Flegal_entity_number: ILegalEntityNumberVO;
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
    Fcreated_at: TDateTime;
    Fupdated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_id: Int64;
    Ftenant_id: Int64;

    // OneToOne
    Fcity: TCity;
    Fupdated_by_acl_user: TAclUser;
    Fcreated_by_acl_user: TAclUser;

    // OneToMany
    Fperson_contact_list: TObjectList<TPersonContact>;

    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property alias_name: String read Falias_name write Falias_name;
    property legal_entity_number: ILegalEntityNumberVO read Flegal_entity_number write Flegal_entity_number;
    property icms_taxpayer: SmallInt read Ficms_taxpayer write Ficms_taxpayer;
    property state_registration: String read Fstate_registration write Fstate_registration;
    property municipal_registration: String read Fmunicipal_registration write Fmunicipal_registration;
    property zipcode: String read Fzipcode write Fzipcode;
    property address: String read Faddress write Faddress;
    property address_number: String read Faddress_number write Faddress_number;
    property complement: String read Fcomplement write Fcomplement;
    property district: String read Fdistrict write Fdistrict;
    property city_id: Int64 read Fcity_id write Fcity_id;
    property reference_point: String read Freference_point write Freference_point;
    property phone_1: String read Fphone_1 write Fphone_1;
    property phone_2: String read Fphone_2 write Fphone_2;
    property phone_3: String read Fphone_3 write Fphone_3;
    property company_email: String read Fcompany_email write Fcompany_email;
    property financial_email: String read Ffinancial_email write Ffinancial_email;
    property internet_page: String read Finternet_page write Finternet_page;
    property note: String read Fnote write Fnote;
    property bank_note: String read Fbank_note write Fbank_note;
    property commercial_note: String read Fcommercial_note write Fcommercial_note;
    property is_customer: SmallInt read Fis_customer write Fis_customer;
    property is_seller: SmallInt read Fis_seller write Fis_seller;
    property is_supplier: SmallInt read Fis_supplier write Fis_supplier;
    property is_carrier: SmallInt read Fis_carrier write Fis_carrier;
    property is_technician: SmallInt read Fis_technician write Fis_technician;
    property is_employee: SmallInt read Fis_employee write Fis_employee;
    property is_other: SmallInt read Fis_other write Fis_other;
    property is_final_customer: SmallInt read Fis_final_customer write Fis_final_customer;
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;

    // OneToOne
    property city: TCity read Fcity write Fcity;
    property created_by_acl_user: TAclUser read Fcreated_by_acl_user write Fcreated_by_acl_user;
    property updated_by_acl_user: TAclUser read Fupdated_by_acl_user write Fupdated_by_acl_user;

    // OneToMany
    property person_contact_list: TObjectList<TPersonContact> read Fperson_contact_list write Fperson_contact_list;

    procedure Validate; override;
    procedure BeforeSave(AState: TEntityState);
    procedure BeforeSaveAndValidate(AState: TEntityState);
  end;

implementation

uses
  System.SysUtils,
  uHlp,
  uPerson.BeforeSave;

{ TPerson }

procedure TPerson.BeforeSave(AState: TEntityState);
begin
  TPersonBeforeSave.Make(Self, AState).Execute;
end;

constructor TPerson.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TPerson.Destroy;
begin
  if Assigned(Fcity)                then Fcity.Free;
  if Assigned(Fperson_contact_list) then Fperson_contact_list.Free;
  if Assigned(Fcreated_by_acl_user) then Fcreated_by_acl_user.Free;
  if Assigned(Fupdated_by_acl_user) then Fupdated_by_acl_user.Free;

  inherited;
end;

procedure TPerson.Initialize;
begin
  Flegal_entity_number := TLegalEntityNumberVO.Make(EmptyStr);
  Fcreated_by_acl_user := TAclUser.Create;
  Fupdated_by_acl_user := TAclUser.Create;
  Fcity                := TCity.Create;
  Fperson_contact_list := TObjectList<TPersonContact>.Create;
end;

procedure TPerson.Validate;
var
  lIsInserting: Boolean;
  lHasAtLeastOneFilled: Boolean;
  lPersonContact: TPersonContact;
begin
  if (Ftenant_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['tenant_id']));

  // Tipo de Pessoa
  lHasAtLeastOneFilled := (Fis_customer > 0)   or (Fis_seller > 0)   or
                          (Fis_supplier > 0)   or (Fis_carrier > 0)  or
                          (Fis_technician > 0) or (Fis_employee > 0) or
                          (Fis_other > 0);
  if not lHasAtLeastOneFilled then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['person_type']));

  lIsInserting := Fid = 0;
  case lIsInserting of
    True: Begin
      if (Fcreated_by_acl_user_id <= 0) then
        raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['created_by_acl_user_id']));
    end;
    False: Begin
      if (Fupdated_by_acl_user_id <= 0) then
        raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['updated_by_acl_user_id']));
    end;
  end;

  // Validar Contatos
  for lPersonContact in Fperson_contact_list do
    lPersonContact.Validate;
end;

procedure TPerson.BeforeSaveAndValidate(AState: TEntityState);
begin
  BeforeSave(AState);
  Validate;
end;

end.
