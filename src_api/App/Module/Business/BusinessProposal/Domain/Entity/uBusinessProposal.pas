unit uBusinessProposal;

interface

uses
  uApplication.Types,
  uAclUser,
  uBase.Entity,
  Data.DB,
  uPerson,
  uBusinessProposalItem,
  System.Generics.Collections,
  XSuperObject,
  uBusinessProposalStatus.Types;

type
  TBusinessProposal = class(TBaseEntity)
  private
    Fperson_id: Int64;
    Fupdated_at: TDateTime;
    Fdelivery_forecast: string;
    Frequester: string;
    Fcreated_at: TDateTime;
    Fpayment_term_note: string;
    Fid: Int64;
    Fupdated_by_acl_user_id: Int64;
    Fstatus: TBusinessProposalStatus;
    Fnote: string;
    Fexpiration_date: TDate;
    Fseller_id: Int64;
    Fcreated_by_acl_user_id: Int64;
    Ftenant_id: Int64;
    Finternal_note: string;

    // OneToOne
    Fperson: TPerson;
    Fseller: TPerson;
    Fupdated_by_acl_user: TAclUser;
    Fcreated_by_acl_user: TAclUser;

    // OneToMany
    Fbusiness_proposal_item_list: TObjectList<TBusinessProposalItem>;

    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property person_id: Int64 read Fperson_id write Fperson_id;
    property requester: string read Frequester write Frequester;
    property expiration_date: TDate read Fexpiration_date write Fexpiration_date;
    property delivery_forecast: string read Fdelivery_forecast write Fdelivery_forecast;
    property seller_id: Int64 read Fseller_id write Fseller_id;
    property note: string read Fnote write Fnote;
    property internal_note: string read Finternal_note write Finternal_note;
    property payment_term_note: string read Fpayment_term_note write Fpayment_term_note;
    property status: TBusinessProposalStatus read Fstatus write Fstatus;
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;

    // CalcFields
    function sum_business_proposal_item_total: Double;

    // OneToOne
    property person: TPerson read Fperson write Fperson;
    property seller: TPerson read Fseller write Fseller;
    property created_by_acl_user: TAclUser read Fcreated_by_acl_user write Fcreated_by_acl_user;
    property updated_by_acl_user: TAclUser read Fupdated_by_acl_user write Fupdated_by_acl_user;

    // OneToMany
    property business_proposal_item_list: TObjectList<TBusinessProposalItem> read Fbusiness_proposal_item_list write Fbusiness_proposal_item_list;

    procedure Validate; override;
    procedure BeforeSave(AState: TEntityState);
    procedure BeforeSaveAndValidate(AState: TEntityState);
  end;

implementation

uses
  System.SysUtils,
  uHlp;

{ TBusinessProposal }

procedure TBusinessProposal.BeforeSave(AState: TEntityState);
begin
//
end;

constructor TBusinessProposal.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TBusinessProposal.Destroy;
begin
  if Assigned(Fperson)                      then Fperson.Free;
  if Assigned(Fseller)                      then Fseller.Free;
  if Assigned(Fbusiness_proposal_item_list) then Fbusiness_proposal_item_list.Free;
  if Assigned(Fcreated_by_acl_user)         then Fcreated_by_acl_user.Free;
  if Assigned(Fupdated_by_acl_user)         then Fupdated_by_acl_user.Free;

  inherited;
end;

procedure TBusinessProposal.Initialize;
begin
  Fcreated_by_acl_user         := TAclUser.Create;
  Fupdated_by_acl_user         := TAclUser.Create;
  Fperson                      := TPerson.Create;
  Fseller                      := TPerson.Create;
  Fbusiness_proposal_item_list := TObjectList<TBusinessProposalItem>.Create;
end;

function TBusinessProposal.sum_business_proposal_item_total: Double;
var
  lBusinessProposalItem: TBusinessProposalItem;
begin
  Result := 0;
  for lBusinessProposalItem in Fbusiness_proposal_item_list do
    Result := Result + lBusinessProposalItem.total;
end;

procedure TBusinessProposal.Validate;
var
  lIsInserting: Boolean;
  lBusinessProposalItem: TBusinessProposalItem;
begin
  if (Ftenant_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['tenant_id']));

  lIsInserting := Fid = 0;
  case lIsInserting of
    True: Begin
      if (Fcreated_by_acl_user_id <= 0) then
        raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['created_by_acl_user_id']));
    end;
    False: Begin
      if (Fupdated_by_acl_user_id <= 0) then
        raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['updated_by_acl_user_id']));
    end;
  end;

  // Validar itens
  if (Fbusiness_proposal_item_list.Count <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['business_proposal_item_list']));
  for lBusinessProposalItem in Fbusiness_proposal_item_list do
    lBusinessProposalItem.Validate;
end;

procedure TBusinessProposal.BeforeSaveAndValidate(AState: TEntityState);
begin
  BeforeSave(AState);
  Validate;
end;

end.
