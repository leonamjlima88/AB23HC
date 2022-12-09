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
    Fid: integer;
    Flogin: string;
    Facl_role_id: integer;
    Fis_superuser: SmallInt;
    Facl_role: TAclRole;
    Flast_token: string;
    Flast_expiration: TDateTime;
  public
    constructor Create;
    destructor Destroy; override;

    property id: integer read Fid write Fid;
    property name: string read Fname write Fname;
    property login: string read Flogin write Flogin;
    property login_password: string read Flogin_password write Flogin_password;
    property acl_role_id: integer read Facl_role_id write Facl_role_id;
    [DISABLEREAD]
    property is_superuser: SmallInt read Fis_superuser write Fis_superuser;
    property last_token: string read Flast_token write Flast_token;
    property last_expiration: TDateTime read Flast_expiration write Flast_expiration;

    // OneToOne
    property acl_role: TAclRole read Facl_role write Facl_role;
  end;

implementation

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

end.
