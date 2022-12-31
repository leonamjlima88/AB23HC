unit uCity;

interface

uses
  uApplication.Types,
  uAclUser,
  uBase.Entity,
  Data.DB;

type
  TCity = class(TBaseEntity)
  private
    Fid: Int64;
    Fname: string;
    Fidentification: string;
    Fcountry_ibge_code: string;
    Fstate: string;
    Fcountry: string;
    Fibge_code: string;
    Fcreated_at: TDateTime;
    Fupdated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_id: Int64;
    Fupdated_by_acl_user: TAclUser;
    Fcreated_by_acl_user: TAclUser;
    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property state: string read Fstate write Fstate;
    property country: string read Fcountry write Fcountry;
    property ibge_code: string read Fibge_code write Fibge_code;
    property country_ibge_code: string read Fcountry_ibge_code write Fcountry_ibge_code;
    property identification: string read Fidentification write Fidentification;
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
  System.SysUtils,
  uHlp,
  System.StrUtils;

{ TCity }

constructor TCity.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TCity.Destroy;
begin
  if Assigned(Fcreated_by_acl_user) then Fcreated_by_acl_user.Free;
  if Assigned(Fupdated_by_acl_user) then Fupdated_by_acl_user.Free;
  inherited;
end;

procedure TCity.Initialize;
begin
  Fcreated_at          := now;
  Fcreated_by_acl_user := TAclUser.Create;
  Fupdated_by_acl_user := TAclUser.Create;
end;

procedure TCity.Validate;
var
  lIsInserting: Boolean;
begin
  if Fname.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['name']));

  if not MatchStr(Fstate.Trim.ToUpper, THlp.StateList) then
    raise Exception.Create(Format(FIELD_WITH_VALUE_IS_INVALID, ['state', Fstate.Trim.ToUpper]));

  if Fcountry.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['country']));

  if Fibge_code.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['ibge_code']));

  if Fcountry_ibge_code.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['country_ibge_code']));

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
