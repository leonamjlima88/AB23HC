unit uBusinessProposal.Repository.SQL;

interface

uses
  uBase.Repository,
  uBusinessProposal.Repository.Interfaces,
  uBusinessProposal.SQLBuilder.Interfaces,
  uZLConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uBusinessProposal,
  uBusinessProposalItem.SQLBuilder.Interfaces,
  uZLMemTable.Interfaces;

type
  TBusinessProposalRepositorySQL = class(TBaseRepository, IBusinessProposalRepository)
  private
    FBusinessProposalSQLBuilder: IBusinessProposalSQLBuilder;
    FBusinessProposalItemSQLBuilder: IBusinessProposalItemSQLBuilder;
    constructor Create(AConn: IZLConnection; ASQLBuilder: IBusinessProposalSQLBuilder);
    function DataSetToEntity(ADtsBusinessProposal: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    function LoadBusinessProposalItemsToShow(ABusinessProposal: TBusinessProposal): IBusinessProposalRepository;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IZLConnection; ASQLBuilder: IBusinessProposalSQLBuilder): IBusinessProposalRepository;
    function Show(AId, ATenantId: Int64): TBusinessProposal;
    function Store(ABusinessProposal: TBusinessProposal; AManageTransaction: Boolean): Int64; overload;
    function Update(ABusinessProposal: TBusinessProposal; AId: Int64; AManageTransaction: Boolean): Boolean; overload;
    function DataForReportById(AId, ATenantId: Int64; ABusinessProposal, ABusinessProposalItem: IZLMemTable): IBusinessProposalRepository;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize,
  uBusinessProposalItem,
  uZLQry.Interfaces,
  System.SysUtils,
  uQtdStr,
  uHlp,
  uApplication.Types,
  uSQLBuilder.Factory,
  uLegalEntityNumber.VO;

{ TBusinessProposalRepositorySQL }

class function TBusinessProposalRepositorySQL.Make(AConn: IZLConnection; ASQLBuilder: IBusinessProposalSQLBuilder): IBusinessProposalRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TBusinessProposalRepositorySQL.Create(AConn: IZLConnection; ASQLBuilder: IBusinessProposalSQLBuilder);
begin
  inherited Create;
  FConn                           := AConn;
  FSQLBuilder                     := ASQLBuilder;
  FBusinessProposalSQLBuilder     := ASQLBuilder;
  FBusinessProposalItemSQLBuilder := TSQLBuilderFactory.Make(FConn.DriverDB).BusinessProposalItem;
end;

function TBusinessProposalRepositorySQL.DataForReportById(AId, ATenantId: Int64; ABusinessProposal, ABusinessProposalItem: IZLMemTable): IBusinessProposalRepository;
var
  lQry: IZLQry;
begin
  Result := Self;

  // Cabeçalho
  lQry := FConn.MakeQry.Open(FBusinessProposalSQLBuilder.ReportById(AId, ATenantId));
  if lQry.DataSet.IsEmpty then raise Exception.Create('Record not found with id: ' + AId.ToString);
  ABusinessProposal.FromDataSet(lQry.DataSet);

  // Itens
  lQry := FConn.MakeQry.Open(FBusinessProposalItemSQLBuilder.ReportById(AId));
  ABusinessProposalItem.FromDataSet(lQry.DataSet);
end;

function TBusinessProposalRepositorySQL.DataSetToEntity(ADtsBusinessProposal: TDataSet): TBaseEntity;
var
  lBusinessProposal: TBusinessProposal;
begin
  lBusinessProposal := TBusinessProposal.FromJSON(ADtsBusinessProposal.ToJSONObjectString);

  // BusinessProposal - Virtuais
  lBusinessProposal.person.id                := ADtsBusinessProposal.FieldByName('person_id').AsLargeInt;
  lBusinessProposal.person.name              := ADtsBusinessProposal.FieldByName('person_name').AsString;
  lBusinessProposal.seller.id                := ADtsBusinessProposal.FieldByName('seller_id').AsLargeInt;
  lBusinessProposal.seller.name              := ADtsBusinessProposal.FieldByName('seller_name').AsString;
  lBusinessProposal.created_by_acl_user.name := ADtsBusinessProposal.FieldByName('created_by_acl_user_name').AsString;
  lBusinessProposal.updated_by_acl_user.id   := ADtsBusinessProposal.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lBusinessProposal.updated_by_acl_user.name := ADtsBusinessProposal.FieldByName('updated_by_acl_user_name').AsString;

  Result := lBusinessProposal;
end;

function TBusinessProposalRepositorySQL.LoadBusinessProposalItemsToShow(ABusinessProposal: TBusinessProposal): IBusinessProposalRepository;
var
  lBusinessProposalItem: TBusinessProposalItem;
begin
  Result := Self;
  With FConn.MakeQry.Open(FBusinessProposalItemSQLBuilder.SelectByBusinessProposalId(ABusinessProposal.id)) do
  begin
    DataSet.First;
    while not DataSet.Eof do
    begin
      lBusinessProposalItem := TBusinessProposalItem.FromJSON(DataSet.ToJSONObjectString);

      lBusinessProposalItem.product.id         := DataSet.FieldByName('product_id').AsLargeInt;
      lBusinessProposalItem.product.name       := DataSet.FieldByName('product_name').AsString;
      lBusinessProposalItem.product_unit.id    := DataSet.FieldByName('product_unit_id').AsLargeInt;
      lBusinessProposalItem.product_unit.name  := DataSet.FieldByName('product_unit_name').AsString;
      ABusinessProposal.business_proposal_item_list.Add(lBusinessProposalItem);
      DataSet.Next;
    end;
  end;
end;

function TBusinessProposalRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FBusinessProposalSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TBusinessProposalRepositorySQL.Show(AId, ATenantId: Int64): TBusinessProposal;
var
  lBusinessProposal: TBusinessProposal;
begin
  Result := nil;

  // BusinessProposal
  lBusinessProposal := ShowById(AId, ATenantId) as TBusinessProposal;
  if not Assigned(lBusinessProposal) then
    Exit;

  // BusinessProposalItems
  LoadBusinessProposalItemsToShow(lBusinessProposal);

  Result := lBusinessProposal;
end;

function TBusinessProposalRepositorySQL.Store(ABusinessProposal: TBusinessProposal; AManageTransaction: Boolean): Int64;
var
  lPk: Int64;
  lBusinessProposalItem: TBusinessProposalItem;
  lQry: IZLQry;
begin
  // Instanciar Qry
  lQry := FConn.MakeQry;

  Try
    if AManageTransaction then
      FConn.StartTransaction;

    // Incluir BusinessProposal
    lPk := inherited Store(ABusinessProposal);

    // Incluir BusinessProposalItems
    for lBusinessProposalItem in ABusinessProposal.business_proposal_item_list do
    begin
      lBusinessProposalItem.business_proposal_id := lPk;
      lQry.ExecSQL(FBusinessProposalItemSQLBuilder.InsertInto(lBusinessProposalItem))
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

function TBusinessProposalRepositorySQL.Update(ABusinessProposal: TBusinessProposal; AId: Int64; AManageTransaction: Boolean): Boolean;
var
  lBusinessProposalItem: TBusinessProposalItem;
  lQry: IZLQry;
begin
  // Instanciar Qry
  lQry := FConn.MakeQry;

  Try
    if AManageTransaction then
      FConn.StartTransaction;

    // Atualizar BusinessProposal
    inherited Update(ABusinessProposal, AId);

    // Atualizar BusinessProposalItems
    lQry.ExecSQL(FBusinessProposalItemSQLBuilder.DeleteByBusinessProposalId(AId));
    for lBusinessProposalItem in ABusinessProposal.business_proposal_item_list do
    begin
      lBusinessProposalItem.business_proposal_id := AId;
      lQry.ExecSQL(FBusinessProposalItemSQLBuilder.InsertInto(lBusinessProposalItem))
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

procedure TBusinessProposalRepositorySQL.Validate(AEntity: TBaseEntity);
var
  lBusinessProposal: TBusinessProposal;
begin
  lBusinessProposal := AEntity as TBusinessProposal;
  // ...
end;

end.
