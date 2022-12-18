unit uPaymentTerm;

interface

uses
  uApplication.Types,
  uAclUser,
  uBase.Entity,
  Data.DB,
  uBankAccount,
  uDocument;

type
  TPaymentTerm = class(TBaseEntity)
  private
    Fid: Int64;
    Fname: string;
    Finterval_between_installments: SmallInt;
    Fnumber_of_installments: SmallInt;
    Fbank_account_id: Int64;
    Ffirst_installment_in: SmallInt;
    Fdocument_id: Int64;
    Fcreated_at: TDateTime;
    Fupdated_at: TDateTime;
    Fupdated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_id: Int64;

    // OneToOne
    Fbank_account: TBankAccount;
    Fdocument: TDocument;
    Fupdated_by_acl_user: TAclUser;
    Fcreated_by_acl_user: TAclUser;

    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property number_of_installments: SmallInt read Fnumber_of_installments write Fnumber_of_installments;
    property first_installment_in: SmallInt read Ffirst_installment_in write Ffirst_installment_in;
    property interval_between_installments: SmallInt read Finterval_between_installments write Finterval_between_installments;
    property bank_account_id: Int64 read Fbank_account_id write Fbank_account_id;
    property document_id: Int64 read Fdocument_id write Fdocument_id;
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;

    // OneToOne
    property bank_account: TBankAccount read Fbank_account write Fbank_account;
    property document: TDocument read Fdocument write Fdocument;
    property created_by_acl_user: TAclUser read Fcreated_by_acl_user write Fcreated_by_acl_user;
    property updated_by_acl_user: TAclUser read Fupdated_by_acl_user write Fupdated_by_acl_user;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils;

{ TPaymentTerm }

constructor TPaymentTerm.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TPaymentTerm.Destroy;
begin
  if Assigned(Fdocument)            then Fdocument.Free;
  if Assigned(Fbank_account)        then Fbank_account.Free;
  if Assigned(Fcreated_by_acl_user) then Fcreated_by_acl_user.Free;
  if Assigned(Fupdated_by_acl_user) then Fupdated_by_acl_user.Free;
  inherited;
end;

procedure TPaymentTerm.Initialize;
begin
  Fcreated_at          := now;
  Fbank_account        := TBankAccount.Create;
  Fdocument            := TDocument.Create;
  Fcreated_by_acl_user := TAclUser.Create;
  Fupdated_by_acl_user := TAclUser.Create;
end;

procedure TPaymentTerm.Validate;
var
  lIsInserting: Boolean;
begin
  if Fname.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['name']));

  if (Fbank_account_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['bank_account_id']));

  if (Fdocument_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['document_id']));

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
