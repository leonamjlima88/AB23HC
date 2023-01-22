unit uTenant;

interface

uses
  uApplication.Types,
  uAclUser,
  uBase.Entity,
  Data.DB,
  uCity,
  System.Generics.Collections,
  XSuperObject,
  uLegalEntityNumber.VO;

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
    Flegal_entity_number: ILegalEntityNumberVO;
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

    // OneToOne
    Fcity: TCity;

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
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;

    // OneToOne
    property city: TCity read Fcity write Fcity;

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
  if Assigned(Fcity) then Fcity.Free;

  inherited;
end;

procedure TTenant.Initialize;
begin
  Flegal_entity_number := TLegalEntityNumberVO.Make(EmptyStr);
  Fcreated_at          := now;
  Fcity                := TCity.Create;
end;

procedure TTenant.Validate;
begin
//
end;

end.
