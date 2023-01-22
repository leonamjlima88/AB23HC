unit uSale;

interface

uses
  uApplication.Types,
  uAclUser,
  uBase.Entity,
  Data.DB,
  uPerson,
  uSaleItem,
  uSalePayment,
  System.Generics.Collections,
  XSuperObject,
  uSaleStatus.Types;

type
  TSale = class(TBaseEntity)
  private
    Fperson_id: Int64;
    Fupdated_at: TDateTime;
    Fpayment_increase: double;
    Fcreated_at: TDateTime;
    Fid: Int64;
    Fupdated_by_acl_user_id: Int64;
    Fpayment_discount: double;
    Fstatus: TSaleStatus;
    Fnote: string;
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
    Fsale_item_list: TObjectList<TSaleItem>;
    Fsale_payment_list: TObjectList<TSalePayment>;

    procedure Initialize;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property id: Int64 read Fid write Fid;
    property person_id: Int64 read Fperson_id write Fperson_id;
    property seller_id: Int64 read Fseller_id write Fseller_id;
    property note: string read Fnote write Fnote;
    property internal_note: string read Finternal_note write Finternal_note;
    property status: TSaleStatus read Fstatus write Fstatus;
    property payment_discount: double read Fpayment_discount write Fpayment_discount;
    property payment_increase: double read Fpayment_increase write Fpayment_increase;
    property created_at: TDateTime read Fcreated_at write Fcreated_at;
    property updated_at: TDateTime read Fupdated_at write Fupdated_at;
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;

    // CalcFields
    function sum_sale_item_total: Double;
    function sum_sale_payment_amount: Double;
    function payment_total: Double;

    // OneToOne
    property person: TPerson read Fperson write Fperson;
    property seller: TPerson read Fseller write Fseller;
    property created_by_acl_user: TAclUser read Fcreated_by_acl_user write Fcreated_by_acl_user;
    property updated_by_acl_user: TAclUser read Fupdated_by_acl_user write Fupdated_by_acl_user;

    // OneToMany
    property sale_item_list: TObjectList<TSaleItem> read Fsale_item_list write Fsale_item_list;
    property sale_payment_list: TObjectList<TSalePayment> read Fsale_payment_list write Fsale_payment_list;

    procedure Validate; override;
    procedure BeforeSave(AState: TEntityState);
    procedure BeforeSaveAndValidate(AState: TEntityState);
  end;

implementation

uses
  System.SysUtils,
  uHlp;

{ TSale }

procedure TSale.BeforeSave(AState: TEntityState);
begin
//
end;

constructor TSale.Create;
begin
  inherited Create;
  Initialize;
end;

destructor TSale.Destroy;
begin
  if Assigned(Fperson)                      then Fperson.Free;
  if Assigned(Fseller)                      then Fseller.Free;
  if Assigned(Fsale_item_list)              then Fsale_item_list.Free;
  if Assigned(Fsale_payment_list)           then Fsale_payment_list.Free;
  if Assigned(Fcreated_by_acl_user)         then Fcreated_by_acl_user.Free;
  if Assigned(Fupdated_by_acl_user)         then Fupdated_by_acl_user.Free;

  inherited;
end;

procedure TSale.Initialize;
begin
  Fcreated_by_acl_user         := TAclUser.Create;
  Fupdated_by_acl_user         := TAclUser.Create;
  Fperson                      := TPerson.Create;
  Fseller                      := TPerson.Create;
  Fsale_item_list              := TObjectList<TSaleItem>.Create;
  Fsale_payment_list           := TObjectList<TSalePayment>.Create;
end;

function TSale.sum_sale_item_total: Double;
var
  lSaleItem: TSaleItem;
begin
  Result := 0;
  for lSaleItem in Fsale_item_list do
    Result := Result + lSaleItem.total;
end;

function TSale.sum_sale_payment_amount: Double;
var
  lSalePayment: TSalePayment;
begin
  Result := 0;
  for lSalePayment in Fsale_payment_list do
    Result := Result + lSalePayment.amount;
end;

function TSale.payment_total: Double;
begin
  Result := (sum_sale_payment_amount + Fpayment_increase) - Fpayment_discount;
end;

procedure TSale.Validate;
var
  lIsInserting: Boolean;
  lSaleItem: TSaleItem;
begin
  if (Ftenant_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['tenant_id']));

  if (Fseller_id <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['seller_id']));

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
  if (Fsale_item_list.Count <= 0) then
    raise Exception.Create(Format(FIELD_WAS_NOT_INFORMED, ['sale_item_list']));
  for lSaleItem in Fsale_item_list do
    lSaleItem.Validate;
end;

procedure TSale.BeforeSaveAndValidate(AState: TEntityState);
begin
  BeforeSave(AState);
  Validate;
end;

end.
