unit uSale.Repository.SQL;

interface

uses
  uBase.Repository,
  uSale.Repository.Interfaces,
  uSale.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uSale,
  uSaleItem.SQLBuilder.Interfaces,
  uSalePayment.SQLBuilder.Interfaces,
  uZLMemTable.Interfaces;

type
  TSaleRepositorySQL = class(TBaseRepository, ISaleRepository)
  private
    FSaleSQLBuilder: ISaleSQLBuilder;
    FSaleItemSQLBuilder: ISaleItemSQLBuilder;
    FSalePaymentSQLBuilder: ISalePaymentSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: ISaleSQLBuilder);
    function DataSetToEntity(ADtsSale: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    function LoadSaleItemsToShow(ASale: TSale): ISaleRepository;
    function LoadSalePaymentsToShow(ASale: TSale): ISaleRepository;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: ISaleSQLBuilder): ISaleRepository;
    function Show(AId, ATenantId: Int64): TSale;
    function Store(ASale: TSale; AManageTransaction: Boolean): Int64; overload;
    function Update(ASale: TSale; AId: Int64; AManageTransaction: Boolean): Boolean; overload;
    function DataForReportById(AId, ATenantId: Int64; ASale, ASaleItem: IZLMemTable): ISaleRepository;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize,
  uSaleItem,
  uSalePayment,
  uZLQry.Interfaces,
  System.SysUtils,
  uQtdStr,
  uHlp,
  uApplication.Types,
  uSQLBuilder.Factory,
  uLegalEntityNumber.VO;

{ TSaleRepositorySQL }

class function TSaleRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: ISaleSQLBuilder): ISaleRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TSaleRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: ISaleSQLBuilder);
begin
  inherited Create;
  FConn                  := AConn;
  FSQLBuilder            := ASQLBuilder;
  FSaleSQLBuilder        := ASQLBuilder;
  FSaleItemSQLBuilder    := TSQLBuilderFactory.Make(FConn.DriverDB).SaleItem;
  FSalePaymentSQLBuilder := TSQLBuilderFactory.Make(FConn.DriverDB).SalePayment;
end;

function TSaleRepositorySQL.DataForReportById(AId, ATenantId: Int64; ASale, ASaleItem: IZLMemTable): ISaleRepository;
var
  lQry: IZLQry;
begin
  Result := Self;

  // Cabeçalho
  lQry := FConn.MakeQry.Open(FSaleSQLBuilder.ReportById(AId, ATenantId));
  if lQry.DataSet.IsEmpty then raise Exception.Create('Record not found with id: ' + AId.ToString);
  ASale.FromDataSet(lQry.DataSet);

  // Itens
  lQry := FConn.MakeQry.Open(FSaleItemSQLBuilder.ReportById(AId));
  ASaleItem.FromDataSet(lQry.DataSet);
end;

function TSaleRepositorySQL.DataSetToEntity(ADtsSale: TDataSet): TBaseEntity;
var
  lSale: TSale;
begin
  lSale := TSale.FromJSON(ADtsSale.ToJSONObjectString);

  // Sale - Virtuais
  lSale.person.id                := ADtsSale.FieldByName('person_id').AsLargeInt;
  lSale.person.name              := ADtsSale.FieldByName('person_name').AsString;
  lSale.seller.id                := ADtsSale.FieldByName('seller_id').AsLargeInt;
  lSale.seller.name              := ADtsSale.FieldByName('seller_name').AsString;
  lSale.created_by_acl_user.name := ADtsSale.FieldByName('created_by_acl_user_name').AsString;
  lSale.updated_by_acl_user.id   := ADtsSale.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lSale.updated_by_acl_user.name := ADtsSale.FieldByName('updated_by_acl_user_name').AsString;

  Result := lSale;
end;

function TSaleRepositorySQL.LoadSaleItemsToShow(ASale: TSale): ISaleRepository;
var
  lSaleItem: TSaleItem;
begin
  Result := Self;
  With FConn.MakeQry.Open(FSaleItemSQLBuilder.SelectBySaleId(ASale.id)) do
  begin
    DataSet.First;
    while not DataSet.Eof do
    begin
      lSaleItem := TSaleItem.FromJSON(DataSet.ToJSONObjectString);

      lSaleItem.product.id         := DataSet.FieldByName('product_id').AsLargeInt;
      lSaleItem.product.name       := DataSet.FieldByName('product_name').AsString;
      lSaleItem.product_unit.id    := DataSet.FieldByName('product_unit_id').AsLargeInt;
      lSaleItem.product_unit.name  := DataSet.FieldByName('product_unit_name').AsString;
      ASale.sale_item_list.Add(lSaleItem);
      DataSet.Next;
    end;
  end;
end;

function TSaleRepositorySQL.LoadSalePaymentsToShow(ASale: TSale): ISaleRepository;
var
  lSalePayment: TSalePayment;
begin
  Result := Self;
  With FConn.MakeQry.Open(FSalePaymentSQLBuilder.SelectBySaleId(ASale.id)) do
  begin
    DataSet.First;
    while not DataSet.Eof do
    begin
      lSalePayment := TSalePayment.FromJSON(DataSet.ToJSONObjectString);

      lSalePayment.bank_account.id   := DataSet.FieldByName('bank_account_id').AsLargeInt;
      lSalePayment.bank_account.name := DataSet.FieldByName('bank_account_name').AsString;
      lSalePayment.document.id       := DataSet.FieldByName('document_id').AsLargeInt;
      lSalePayment.document.name     := DataSet.FieldByName('document_name').AsString;
      ASale.sale_payment_list.Add(lSalePayment);
      DataSet.Next;
    end;
  end;
end;

function TSaleRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FSaleSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TSaleRepositorySQL.Show(AId, ATenantId: Int64): TSale;
var
  lSale: TSale;
begin
  Result := nil;

  // Sale
  lSale := ShowById(AId, ATenantId) as TSale;
  if not Assigned(lSale) then
    Exit;

  // SaleItems
  LoadSaleItemsToShow(lSale);

  // SalePayments
  LoadSalePaymentsToShow(lSale);

  Result := lSale;
end;

function TSaleRepositorySQL.Store(ASale: TSale; AManageTransaction: Boolean): Int64;
var
  lPk: Int64;
  lSaleItem: TSaleItem;
  lSalePayment: TSalePayment;
  lQry: IZLQry;
begin
  // Instanciar Qry
  lQry := FConn.MakeQry;

  Try
    if AManageTransaction then
      FConn.StartTransaction;

    // Incluir Sale
    lPk := inherited Store(ASale);

    // Incluir SaleItems
    for lSaleItem in ASale.sale_item_list do
    begin
      lSaleItem.sale_id := lPk;
      lQry.ExecSQL(FSaleItemSQLBuilder.InsertInto(lSaleItem))
    end;

    // Incluir SalePayments
    for lSalePayment in ASale.sale_payment_list do
    begin
      lSalePayment.sale_id := lPk;
      lQry.ExecSQL(FSalePaymentSQLBuilder.InsertInto(lSalePayment))
    end;

    if AManageTransaction then
      FConn.CommitTransaction;
  except on E: Exception do
    Begin
      if AManageTransaction then
        FConn.RollBackTransaction;
      raise;
    end;
  end;

  Result := lPk;
end;

function TSaleRepositorySQL.Update(ASale: TSale; AId: Int64; AManageTransaction: Boolean): Boolean;
var
  lSaleItem: TSaleItem;
  lSalePayment: TSalePayment;
  lQry: IZLQry;
begin
  // Instanciar Qry
  lQry := FConn.MakeQry;

  Try
    if AManageTransaction then
      FConn.StartTransaction;

    // Atualizar Sale
    inherited Update(ASale, AId);

    // Atualizar SaleItems
    lQry.ExecSQL(FSaleItemSQLBuilder.DeleteBySaleId(AId));
    for lSaleItem in ASale.sale_item_list do
    begin
      lSaleItem.sale_id := AId;
      lQry.ExecSQL(FSaleItemSQLBuilder.InsertInto(lSaleItem))
    end;

    // Atualizar SalePayments
    lQry.ExecSQL(FSalePaymentSQLBuilder.DeleteBySaleId(AId));
    for lSalePayment in ASale.sale_payment_list do
    begin
      lSalePayment.sale_id := AId;
      lQry.ExecSQL(FSalePaymentSQLBuilder.InsertInto(lSalePayment))
    end;

    if AManageTransaction then
      FConn.CommitTransaction;
  except on E: Exception do
    Begin
      if AManageTransaction then
        FConn.RollBackTransaction;
      raise;
    end;
  end;

  Result := True;
end;

procedure TSaleRepositorySQL.Validate(AEntity: TBaseEntity);
var
  lSale: TSale;
begin
  lSale := AEntity as TSale;
  // ...
end;

end.
