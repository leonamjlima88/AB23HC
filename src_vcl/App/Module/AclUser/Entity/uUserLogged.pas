unit uUserLogged;

interface

uses
  SysUtils,
  uAclUser;

type
  TUserLogged = class
  private
    FUser: TAclUser;
  public
    destructor Destroy; override;

    function Current: TAclUser; overload;
    function Current(AUser: TAclUser): TUserLogged; overload;
    function CurrentHasPermissionTo(AActionName: String): Boolean;
    function GetParam(ATitle: String): String;
  end;

var
  UserLogged: TUserLogged;

implementation

uses
  uAppParam;

{ TUserLogged }

function TUserLogged.Current: TAclUser;
begin
  Result := FUser;
end;

destructor TUserLogged.Destroy;
begin
  if Assigned(FUser) then FUser.Free;
  inherited;
end;

function TUserLogged.GetParam(ATitle: String): String;
var
  lAppParam: TAppParam;
  lFound: Boolean;
begin
  ATitle := ATitle.Trim.ToLower;

  // Tentar localizar parâmetro por perfil de usuário
  lFound := False;
  for lAppParam in FUser.app_param_list do
  begin
    lFound := (lAppParam.title = ATitle) and (lAppParam.acl_role_id = FUser.acl_role_id);
    if lFound then
    begin
      Result := lAppParam.value;
      Exit;
    end;
  end;

  // Tentar localizar parâmetro global
  lFound := False;
  for lAppParam in FUser.app_param_list do
  begin
    lFound := (lAppParam.title = ATitle) and (lAppParam.acl_role_id <= 0);
    if lFound then
    begin
      Result := lAppParam.value;
      Exit;
    end;
  end;

  Result := EmptyStr;
end;

function TUserLogged.Current(AUser: TAclUser): TUserLogged;
begin
  Result := Self;
  if Assigned(FUser) then FreeAndNil(FUser);
  FUser := AUser;
end;

function TUserLogged.CurrentHasPermissionTo(AActionName: String): Boolean;
begin
  //
end;

initialization
  UserLogged := TUserLogged.Create;
finalization
  FreeAndNil(UserLogged);

end.

