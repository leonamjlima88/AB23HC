unit uNCM;

interface

uses
  uApplication.Types,
  uAclUser,
  uBase.Entity,
  Data.DB;

type
  TNCM = class(TBaseEntity)
  private
    Fid: Int64;
    Fname: string;
    Fnational_rate: double;
    Fstate_rate: double;
    Fcest: string;
    Fadditional_information: string;
    Fncm: string;
    Fstart_of_validity: TDate;
    Fimported_rate: double;
    Fmunicipal_rate: double;
    Fend_of_validity: TDate;
    Fcreated_at: TDateTime;
    Fupdated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_id: Int64;

    // OneToOne
    Fupdated_by_acl_user: TAclUser;
    Fcreated_by_acl_user: TAclUser;

    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property ncm: string read Fncm write Fncm;
    property national_rate: double read Fnational_rate write Fnational_rate;
    property imported_rate: double read Fimported_rate write Fimported_rate;
    property state_rate: double read Fstate_rate write Fstate_rate;
    property municipal_rate: double read Fmunicipal_rate write Fmunicipal_rate;
    property cest: string read Fcest write Fcest;
    property additional_information: string read Fadditional_information write Fadditional_information;
    property start_of_validity: TDate read Fstart_of_validity write Fstart_of_validity;
    property end_of_validity: TDate read Fend_of_validity write Fend_of_validity;
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;

    // OneToOne
    property created_by_acl_user: TAclUser read Fcreated_by_acl_user write Fcreated_by_acl_user;
    property updated_by_acl_user: TAclUser read Fupdated_by_acl_user write Fupdated_by_acl_user;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils;

{ TNCM }

constructor TNCM.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TNCM.Destroy;
begin
  if Assigned(Fcreated_by_acl_user) then Fcreated_by_acl_user.Free;
  if Assigned(Fupdated_by_acl_user) then Fupdated_by_acl_user.Free;
  inherited;
end;

procedure TNCM.Initialize;
begin
  Fcreated_at          := now;
  Fcreated_by_acl_user := TAclUser.Create;
  Fupdated_by_acl_user := TAclUser.Create;
end;

procedure TNCM.Validate;
var
  lIsInserting: Boolean;
begin
  if Fname.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['name']));

  if fncm.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['ncm']));

  lIsInserting := Fid = 0;
  case lIsInserting of
    True: Begin
      if (Fcreated_by_acl_user_id <= 0) then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['created_by_acl_user_id']));
    end;
    False: Begin
      if (Fupdated_by_acl_user_id <= 0) then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['updated_by_acl_user_id']));
    end;
  end;
end;

end.
