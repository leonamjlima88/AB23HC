unit uPersonContact;

interface

uses
  uBase.Entity;

type
  TPersonContact = class(TBaseEntity)
  private
    Fid: Int64;
    Fperson_id: Int64;
    Fname: string;
    Femail: string;
    Fphone: string;
    Fnote: string;
    Fein: string;
    Ftype: string;
    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property person_id: Int64 read Fperson_id write Fperson_id;
    property name: string read Fname write Fname;
    property ein: string read Fein write Fein;
    property &type: string read Ftype write Ftype;
    property note: string read Fnote write Fnote;
    property phone: string read Fphone write Fphone;
    property email: string read Femail write Femail;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils;

{ TPersonContact }

constructor TPersonContact.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TPersonContact.Destroy;
begin
  inherited;
end;

procedure TPersonContact.Initialize;
begin
  //
end;

procedure TPersonContact.Validate;
//var
//  lIsInserting: Boolean;
begin
//  if Fperson_id.Trim.IsEmpty then
//    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['person_id']));
//
//  if Falias_person_id.Trim.IsEmpty then
//    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['alias_person_id']));
//
//  lIsInserting := Fid = 0;
//  case lIsInserting of
//    True: Begin
//      if (Fcreated_at <= 0)             then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['created_at']));
//      if (Fcreated_by_acl_user_id <= 0) then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['created_by_acl_user_id']));
//    end;
//    False: Begin
//      if (Fupdated_at <= 0)             then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['updated_at']));
//      if (Fupdated_by_acl_user_id <= 0) then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['updated_by_acl_user_id']));
//    end;
//  end;
end;

end.
