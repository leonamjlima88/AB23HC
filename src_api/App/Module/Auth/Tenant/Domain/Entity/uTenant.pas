unit uTenant;

interface

uses
  uApplication.Types,
  uAclUser,
  uBase.Entity,
  Data.DB,
  uCity,
  System.Generics.Collections,
  XSuperObject;

type
  TTenant = class(TBaseEntity)
  private
    Fid: Int64;
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
    Fcreated_at: TDateTime;
    Fupdated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_id: Int64;

    // OneToOne
    Fcity: TCity;
    Fupdated_by_acl_user: TAclUser;
    Fcreated_by_acl_user: TAclUser;

    procedure Initialize;
    function Getlegal_entity_number: String;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property alias_name: String read Falias_name write Falias_name;
    property legal_entity_number: String read Getlegal_entity_number write Flegal_entity_number;
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
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;

    // OneToOne
    property city: TCity read Fcity write Fcity;
    property created_by_acl_user: TAclUser read Fcreated_by_acl_user write Fcreated_by_acl_user;
    property updated_by_acl_user: TAclUser read Fupdated_by_acl_user write Fupdated_by_acl_user;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils,
  uHlp;

{ TTenant }

constructor TTenant.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TTenant.Destroy;
begin
  if Assigned(Fcity)                then Fcity.Free;
  if Assigned(Fcreated_by_acl_user) then Fcreated_by_acl_user.Free;
  if Assigned(Fupdated_by_acl_user) then Fupdated_by_acl_user.Free;

  inherited;
end;

function TTenant.Getlegal_entity_number: String;
begin
  Result := Thlp.OnlyNumbers(Flegal_entity_number);
end;

procedure TTenant.Initialize;
begin
  Fcreated_at          := now;
  Fcreated_by_acl_user := TAclUser.Create;
  Fupdated_by_acl_user := TAclUser.Create;
  Fcity                := TCity.Create;
end;

procedure TTenant.Validate;
var
  lIsInserting: Boolean;
  lHasAtLeastOneFilled: Boolean;
begin
  // Validar CPF/CNPJ se preenchido
  if not Flegal_entity_number.Trim.IsEmpty then
  begin
    if not THlp.CpfOrCnpjIsValid(Flegal_entity_number) then
      raise Exception.Create(Format(FIELD_WITH_VALUE_IS_INVALID, ['legal_entity_number', Flegal_entity_number]));
  end;

  lIsInserting := Fid = 0;
  case lIsInserting of
    True: Begin
      if (Fcreated_at <= 0)             then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['created_at']));
      if (Fcreated_by_acl_user_id <= 0) then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['created_by_acl_user_id']));
    end;
    False: Begin
      if (Fupdated_at <= 0)             then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['updated_at']));
      if (Fupdated_by_acl_user_id <= 0) then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['updated_by_acl_user_id']));
    end;
  end;
end;

end.
