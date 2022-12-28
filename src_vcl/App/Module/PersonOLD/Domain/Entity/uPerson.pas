unit uPerson;

interface

uses
  uBase.Entity,
  uAclUser,
  uPersonContact,
  System.Generics.Collections;

type
  TPerson = class(TBaseEntity)
  private
    Fid: Int64;
    Fname: string;
    Falias_name: string;
    Fis_customer: SmallInt;
    Fupdated_at: TDateTime;
    Fcreated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_id: Int64;

    // OneToOne
    Fupdated_by_acl_user: TAclUser;
    Fcreated_by_acl_user: TAclUser;

    // OneToMany
    Fperson_contact_list: TObjectList<TPersonContact>;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property is_customer: SmallInt read Fis_customer write Fis_customer;
    property alias_name: string read Falias_name write Falias_name;
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;

    // OneToOne
    property created_by_acl_user: TAclUser read Fcreated_by_acl_user write Fcreated_by_acl_user;
    property updated_by_acl_user: TAclUser read Fupdated_by_acl_user write Fupdated_by_acl_user;

    // OneToMany
    property person_contact_list: TObjectList<TPersonContact> read Fperson_contact_list write Fperson_contact_list;

    function  Validate: String; override;
    procedure Initialize; override;
    function AddPersonContact(APersonContact: TPersonContact): TPerson;
  end;

implementation

uses
  System.SysUtils,
  uUserLogged;

{ TPerson }

function TPerson.AddPersonContact(APersonContact: TPersonContact): TPerson;
begin
  Result := Self;
  Fperson_contact_list.Add(APersonContact);
  Notify('AddPersonContact', EmptyStr, APersonContact);
end;

constructor TPerson.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TPerson.Destroy;
begin
  if Assigned(Fcreated_by_acl_user) then Fcreated_by_acl_user.Free;
  if Assigned(Fupdated_by_acl_user) then Fupdated_by_acl_user.Free;
  if Assigned(Fperson_contact_list) then Fperson_contact_list.Free;
  inherited;
end;

procedure TPerson.Initialize;
begin
  Fcreated_at               := now;
  Fcreated_by_acl_user      := TAclUser.Create;
  Fupdated_by_acl_user      := TAclUser.Create;
  Fcreated_by_acl_user_id   := UserLogged.Current.id;
  Fcreated_by_acl_user.id   := UserLogged.Current.id;
  Fcreated_by_acl_user.name := UserLogged.Current.name;
  Fis_customer              := 1;
  Fperson_contact_list      := TObjectList<TPersonContact>.Create;
end;

function TPerson.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  lIsInserting := id = 0;

  if Fname.Trim.IsEmpty then
    lErrors := lErrors + 'O campo [Razão/Nome] é obrigatório' + #13;

  if Falias_name.Trim.IsEmpty then
    lErrors := lErrors + 'O campo [Fantasia/Apelido] é obrigatório' + #13;

  Result := lErrors;
end;

end.
