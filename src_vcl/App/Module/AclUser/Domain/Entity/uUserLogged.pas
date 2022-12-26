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
  end;

var
  UserLogged: TUserLogged;

implementation

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

