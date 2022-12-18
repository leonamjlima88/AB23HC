unit uPaymentTerm.Repository.SQL;

interface

uses
  uBase.Repository,
  uPaymentTerm.Repository.Interfaces,
  uPaymentTerm.SQLBuilder.Interfaces,
  uConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uPaymentTerm;

type
  TPaymentTermRepositorySQL = class(TBaseRepository, IPaymentTermRepository)
  private
    FPaymentTermSQLBuilder: IPaymentTermSQLBuilder;
    constructor Create(AConn: IConnection; ASQLBuilder: IPaymentTermSQLBuilder);
    function DataSetToEntity(ADtsPaymentTerm: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IConnection; ASQLBuilder: IPaymentTermSQLBuilder): IPaymentTermRepository;
    function Show(AId: Int64): TPaymentTerm;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize;

{ TPaymentTermRepositorySQL }

class function TPaymentTermRepositorySQL.Make(AConn: IConnection; ASQLBuilder: IPaymentTermSQLBuilder): IPaymentTermRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TPaymentTermRepositorySQL.Create(AConn: IConnection; ASQLBuilder: IPaymentTermSQLBuilder);
begin
  inherited Create;
  FConn                  := AConn;
  FSQLBuilder            := ASQLBuilder;
  FPaymentTermSQLBuilder := ASQLBuilder;
end;

function TPaymentTermRepositorySQL.DataSetToEntity(ADtsPaymentTerm: TDataSet): TBaseEntity;
var
  lPaymentTerm: TPaymentTerm;
begin
  lPaymentTerm := TPaymentTerm.FromJSON(ADtsPaymentTerm.ToJSONObjectString);

  // PaymentTerm - Virtuais
  lPaymentTerm.bank_account.id          := ADtsPaymentTerm.FieldByName('bank_account_id').AsLargeInt;
  lPaymentTerm.bank_account.name        := ADtsPaymentTerm.FieldByName('bank_account_name').AsString;
  lPaymentTerm.document.id              := ADtsPaymentTerm.FieldByName('document_id').AsLargeInt;
  lPaymentTerm.document.name            := ADtsPaymentTerm.FieldByName('document_name').AsString;
  lPaymentTerm.created_by_acl_user.id   := ADtsPaymentTerm.FieldByName('created_by_acl_user_id').AsLargeInt;
  lPaymentTerm.created_by_acl_user.name := ADtsPaymentTerm.FieldByName('created_by_acl_user_name').AsString;
  lPaymentTerm.updated_by_acl_user.id   := ADtsPaymentTerm.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lPaymentTerm.updated_by_acl_user.name := ADtsPaymentTerm.FieldByName('updated_by_acl_user_name').AsString;

  Result := lPaymentTerm;
end;

function TPaymentTermRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FPaymentTermSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TPaymentTermRepositorySQL.Show(AId: Int64): TPaymentTerm;
begin
  Result := ShowById(AId) as TPaymentTerm;
end;

procedure TPaymentTermRepositorySQL.Validate(AEntity: TBaseEntity);
begin
//
end;

end.


