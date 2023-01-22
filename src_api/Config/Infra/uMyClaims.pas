unit uMyClaims;

interface

uses
  JOSE.Core.JWT,
  JOSE.Types.JSON;

type
  TMyClaims = class(TJWTClaims)
  strict private
    function GetId: string;
    procedure SetId(const Value: string);
    function GetName: string;
    procedure SetName(const Value: string);
    function GetLogin: string;
    procedure SetLogin(const Value: string);
  private
    function GetAclRoleId: string;
    procedure SetAclRoleId(const Value: string);
    function GetIsSuperuser: string;
    procedure SetIsSuperuser(const Value: string);
    function GetTenantId: string;
    procedure SetTenantId(const Value: string);
    function GetTenantInfo: string;
    procedure SetTenantInfo(const Value: string);
  public
    property Id: string read GetId write SetId;
    property Name: string read GetName write SetName;
    property Login: string read GetLogin write SetLogin;
    property AclRoleId: string read GetAclRoleId write SetAclRoleId;
    property IsSuperuser: string read GetIsSuperuser write SetIsSuperuser;
    property TenantId: string read GetTenantId write SetTenantId;
    property TenantInfo: string read GetTenantInfo write SetTenantInfo;
  end;

implementation

{ TMyClaims }

function TMyClaims.GetAclRoleId: string;
begin
  Result := TJSONUtils.GetJSONValue('acl_role_id', FJSON).Asstring;
end;

function TMyClaims.GetId: string;
begin
  Result := TJSONUtils.GetJSONValue('id', FJSON).Asstring;
end;

function TMyClaims.GetIsSuperuser: string;
begin
  Result := TJSONUtils.GetJSONValue('is_superuser', FJSON).AsString;
end;

procedure TMyClaims.SetAclRoleId(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('acl_role_id', Value, FJSON);
end;

procedure TMyClaims.SetId(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('id', Value, FJSON);
end;

procedure TMyClaims.SetIsSuperuser(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('is_superuser', Value, FJSON);
end;

function TMyClaims.GetName: string;
begin
  Result := TJSONUtils.GetJSONValue('name', FJSON).AsString;
end;

function TMyClaims.GetTenantId: string;
begin
  Result := TJSONUtils.GetJSONValue('tenant_id', FJSON).AsString;
end;

function TMyClaims.GetTenantInfo: string;
begin
  Result := TJSONUtils.GetJSONValue('tenant_info', FJSON).AsString;
end;

procedure TMyClaims.SetName(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('name', Value, FJSON);
end;

procedure TMyClaims.SetTenantId(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('tenant_id', Value, FJSON);
end;

procedure TMyClaims.SetTenantInfo(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('tenant_info', Value, FJSON)
end;

function TMyClaims.GetLogin: string;
begin
  Result := TJSONUtils.GetJSONValue('login', FJSON).AsString;
end;

procedure TMyClaims.SetLogin(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('login', Value, FJSON);
end;

end.
