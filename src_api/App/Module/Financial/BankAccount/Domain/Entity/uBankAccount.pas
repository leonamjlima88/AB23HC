unit uBankAccount;

interface

uses
  uApplication.Types,
  uAclUser,
  uBase.Entity,
  Data.DB,
  uBank;

type
  TBankAccount = class(TBaseEntity)
  private
    Fid: Int64;
    Fname: string;
    Fbank_id: Int64;
    Fnote: string;
    Fcreated_at: TDateTime;
    Fupdated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_id: Int64;

    // OneToOne
    Fbank: TBank;
    Fupdated_by_acl_user: TAclUser;
    Fcreated_by_acl_user: TAclUser;

    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property bank_id: Int64 read Fbank_id write Fbank_id;
    property note: string read Fnote write Fnote;
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;

    // OneToOne
    property bank: TBank read Fbank write Fbank;
    property created_by_acl_user: TAclUser read Fcreated_by_acl_user write Fcreated_by_acl_user;
    property updated_by_acl_user: TAclUser read Fupdated_by_acl_user write Fupdated_by_acl_user;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils;

{ TBankAccount }

constructor TBankAccount.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TBankAccount.Destroy;
begin
  if Assigned(Fbank)                then Fbank.Free;
  if Assigned(Fcreated_by_acl_user) then Fcreated_by_acl_user.Free;
  if Assigned(Fupdated_by_acl_user) then Fupdated_by_acl_user.Free;
  inherited;
end;

procedure TBankAccount.Initialize;
begin
  Fcreated_at          := now;
  Fbank                := TBank.Create;
  Fcreated_by_acl_user := TAclUser.Create;
  Fupdated_by_acl_user := TAclUser.Create;
end;

procedure TBankAccount.Validate;
var
  lIsInserting: Boolean;
begin
  if Fname.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['name']));

  if (Fbank_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['bank']));

  lIsInserting := Fid = 0;
  case lIsInserting of
    True: Begin
      if (Fcreated_at <= 0)             then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['created_at']));
      if (Fcreated_by_acl_user_id <= 0) then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['created_by_acl_user_id']));
    end;
    False: Begin
      if (Fupdated_at <= 0)             then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['updated_at']));
      if (Fupdated_by_acl_user_id <= 0) then raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['updated_by_acl_user_id']));
    end;
  end;
end;

end.
