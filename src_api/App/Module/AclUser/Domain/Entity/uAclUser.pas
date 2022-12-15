unit uAclUser;

interface

uses
  uApplication.Types,
  uAclRole,
  XSuperObject,
  uBase.Entity;

type
  TAclUser = class(TBaseEntity)
  private
    Fname: string;
    Flogin_password: string;
    Fid: Int64;
    Flogin: string;
    Facl_role_id: Int64;
    Fis_superuser: SmallInt;
    Facl_role: TAclRole;
    Flast_token: string;
    Flast_expiration: TDateTime;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property login: string read Flogin write Flogin;
    property login_password: string read Flogin_password write Flogin_password;
    property acl_role_id: Int64 read Facl_role_id write Facl_role_id;
    property is_superuser: SmallInt read Fis_superuser write Fis_superuser;
    property last_token: string read Flast_token write Flast_token;
    property last_expiration: TDateTime read Flast_expiration write Flast_expiration;

    // OneToOne
    property acl_role: TAclRole read Facl_role write Facl_role;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils;

{ TAclUser }

constructor TAclUser.Create;
begin
  Facl_role := TAclRole.Create;
end;

destructor TAclUser.Destroy;
begin
  if Assigned(Facl_role) then Facl_role.Free;
  inherited;
end;

procedure TAclUser.Validate;
begin
  if Fname.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['name']));

  if Flogin.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['login']));

  if Flogin_password.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['login_password']));

  if (Facl_role_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['acl_role_id']));
end;

end.
