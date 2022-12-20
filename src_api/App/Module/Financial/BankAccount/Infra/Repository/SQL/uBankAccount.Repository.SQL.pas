unit uBankAccount.Repository.SQL;

interface

uses
  uBase.Repository,
  uBankAccount.Repository.Interfaces,
  uBankAccount.SQLBuilder.Interfaces,
  uConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uBankAccount;

type
  TBankAccountRepositorySQL = class(TBaseRepository, IBankAccountRepository)
  private
    FBankAccountSQLBuilder: IBankAccountSQLBuilder;
    constructor Create(AConn: IConnection; ASQLBuilder: IBankAccountSQLBuilder);
    function DataSetToEntity(ADtsBankAccount: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IConnection; ASQLBuilder: IBankAccountSQLBuilder): IBankAccountRepository;
    function Show(AId, ATenantId: Int64): TBankAccount;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TBankAccountRepositorySQL }

class function TBankAccountRepositorySQL.Make(AConn: IConnection; ASQLBuilder: IBankAccountSQLBuilder): IBankAccountRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TBankAccountRepositorySQL.Create(AConn: IConnection; ASQLBuilder: IBankAccountSQLBuilder);
begin
  inherited Create;
  FConn            := AConn;
  FSQLBuilder      := ASQLBuilder;
  FBankAccountSQLBuilder := ASQLBuilder;
end;

function TBankAccountRepositorySQL.DataSetToEntity(ADtsBankAccount: TDataSet): TBaseEntity;
var
  lBankAccount: TBankAccount;
begin
  lBankAccount := TBankAccount.FromJSON(ADtsBankAccount.ToJSONObjectString);

  // BankAccount - Virtuais
  lBankAccount.bank.id                  := ADtsBankAccount.FieldByName('bank_id').AsLargeInt;
  lBankAccount.bank.name                := ADtsBankAccount.FieldByName('bank_name').AsString;
  lBankAccount.created_by_acl_user.id   := ADtsBankAccount.FieldByName('created_by_acl_user_id').AsLargeInt;
  lBankAccount.created_by_acl_user.name := ADtsBankAccount.FieldByName('created_by_acl_user_name').AsString;
  lBankAccount.updated_by_acl_user.id   := ADtsBankAccount.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lBankAccount.updated_by_acl_user.name := ADtsBankAccount.FieldByName('updated_by_acl_user_name').AsString;

  Result := lBankAccount;
end;

function TBankAccountRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FBankAccountSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TBankAccountRepositorySQL.Show(AId, ATenantId: Int64): TBankAccount;
begin
  Result := ShowById(AId, ATenantId) as TBankAccount;
end;

procedure TBankAccountRepositorySQL.Validate(AEntity: TBaseEntity);
begin
//
end;

end.


