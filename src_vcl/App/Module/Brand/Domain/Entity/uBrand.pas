unit uBrand;

interface

uses
  uBase.Entity,
  uAclUser;

type
  TBrand = class(TBaseEntity)
  private
    Fid: Int64;
    Fname: string;
    Fupdated_at: TDateTime;
    Fcreated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_id: Int64;

    // OneToOne
    Fupdated_by_acl_user: TAclUser;
    Fcreated_by_acl_user: TAclUser;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;

    // OneToOne
    property created_by_acl_user: TAclUser read Fcreated_by_acl_user write Fcreated_by_acl_user;
    property updated_by_acl_user: TAclUser read Fupdated_by_acl_user write Fupdated_by_acl_user;

    function  Validate: String; override;
    procedure Initialize; override;
  end;

implementation

uses
  System.SysUtils,
  uUserLogged;

{ TBrand }

constructor TBrand.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TBrand.Destroy;
begin
  if Assigned(Fcreated_by_acl_user) then Fcreated_by_acl_user.Free;
  if Assigned(Fupdated_by_acl_user) then Fupdated_by_acl_user.Free;
  inherited;
end;

procedure TBrand.Initialize;
begin
  Fcreated_at               := now;
  Fcreated_by_acl_user      := TAclUser.Create;
  Fupdated_by_acl_user      := TAclUser.Create;
  Fcreated_by_acl_user_id   := UserLogged.Current.id;
  Fcreated_by_acl_user.id   := UserLogged.Current.id;
  Fcreated_by_acl_user.name := UserLogged.Current.name;
end;

function TBrand.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  lIsInserting := id = 0;

  if Fname.Trim.IsEmpty then
    lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;

  Result := lErrors;
  Notify('Validation', 'Sem erros', nil);
end;

end.
