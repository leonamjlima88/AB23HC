unit uTaxRule;

interface

uses
  uApplication.Types,
  uAclUser,
  uBase.Entity,
  Data.DB,
  uTaxRuleState,
  System.Generics.Collections,
  XSuperObject;

type
  TTaxRule = class(TBaseEntity)
  private
    Fupdated_at: TDateTime;
    Fname: string;
    Fcreated_at: TDateTime;
    Fis_final_customer: SmallInt;
    Fid: Int64;
    Fupdated_by_acl_user_id: Int64;
    Fcreated_by_acl_user_id: Int64;
    Foperation_type_id: Int64;
    Ftenant_id: Int64;

    // OneToOne
    Fupdated_by_acl_user: TAclUser;
    Fcreated_by_acl_user: TAclUser;

    // OneToMany
    Ftax_rule_state_list: TObjectList<TTaxRuleState>;

    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property name: string read Fname write Fname;
    property operation_type_id: Int64 read Foperation_type_id write Foperation_type_id;
    property is_final_customer: SmallInt read Fis_final_customer write Fis_final_customer;
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;

    // OneToOne
    property created_by_acl_user: TAclUser read Fcreated_by_acl_user write Fcreated_by_acl_user;
    property updated_by_acl_user: TAclUser read Fupdated_by_acl_user write Fupdated_by_acl_user;

    // OneToMany
    property tax_rule_state_list: TObjectList<TTaxRuleState> read Ftax_rule_state_list write Ftax_rule_state_list;

    procedure Validate; override;
  end;

implementation

uses
  System.SysUtils,
  uHlp;

{ TTaxRule }

constructor TTaxRule.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TTaxRule.Destroy;
begin
  if Assigned(Ftax_rule_state_list) then Ftax_rule_state_list.Free;
  if Assigned(Fcreated_by_acl_user) then Fcreated_by_acl_user.Free;
  if Assigned(Fupdated_by_acl_user) then Fupdated_by_acl_user.Free;

  inherited;
end;

procedure TTaxRule.Initialize;
begin
  Fcreated_at          := now;
  Fcreated_by_acl_user := TAclUser.Create;
  Fupdated_by_acl_user := TAclUser.Create;
  Ftax_rule_state_list := TObjectList<TTaxRuleState>.Create;
end;

procedure TTaxRule.Validate;
var
  lIsInserting: Boolean;
  lTaxRuleState: TTaxRuleState;
begin
  if Fname.Trim.IsEmpty then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['name']));

  if (Ftenant_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['tenant_id']));

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

  // Validar TaxRuleState
  for lTaxRuleState in Ftax_rule_state_list do
    lTaxRuleState.Validate;
end;

end.
