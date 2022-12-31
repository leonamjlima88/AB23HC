unit uAclUser;

interface

uses
  uAclRole,
  uBase.Entity,
  System.Generics.Collections,
  uAppParam;

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
    Fapp_param_list: TObjectList<TAppParam>;
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

    // OneToMany
    property app_param_list: TObjectList<TAppParam> read Fapp_param_list write Fapp_param_list;

    class function FromJsonString(AJsonString: String): TAclUser;
    function ToJsonString: String;
  end;

implementation

uses
  System.SysUtils;

{ TAclUser }

constructor TAclUser.Create;
begin
  Facl_role       := TAclRole.Create;
  Fapp_param_list := TObjectList<TAppParam>.Create;
end;

destructor TAclUser.Destroy;
begin
  if Assigned(Facl_role)       then Facl_role.Free;
  if Assigned(Fapp_param_list) then Fapp_param_list.Free;
  inherited;
end;

class function TAclUser.FromJsonString(AJsonString: String): TAclUser;
begin
//
end;

function TAclUser.ToJsonString: String;
begin
//
end;

end.
