unit uProduct.Repository.SQL;

interface

uses
  uBase.Repository,
  uProduct.Repository.Interfaces,
  uProduct.SQLBuilder.Interfaces,
  uConnection.Interfaces,
  Data.DB,
  uBase.Entity,
  uPageFilter,
  uSelectWithFilter,
  uProduct;

type
  TProductRepositorySQL = class(TBaseRepository, IProductRepository)
  private
    FProductSQLBuilder: IProductSQLBuilder;
    constructor Create(AConn: IConnection; ASQLBuilder: IProductSQLBuilder);
    function DataSetToEntity(ADtsProduct: TDataSet): TBaseEntity; override;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; override;
    function FieldExists(AColumName, AColumnValue: String; AId: Int64): Boolean;
    procedure Validate(AEntity: TBaseEntity); override;
  public
    class function Make(AConn: IConnection; ASQLBuilder: IProductSQLBuilder): IProductRepository;
    function Show(AId: Int64): TProduct;
 end;

implementation

uses
  XSuperObject,
  DataSet.Serialize,
  System.SysUtils,
  uApplication.Types;

{ TProductRepositorySQL }

class function TProductRepositorySQL.Make(AConn: IConnection; ASQLBuilder: IProductSQLBuilder): IProductRepository;
begin
  Result := Self.Create(AConn, ASQLBuilder);
end;

constructor TProductRepositorySQL.Create(AConn: IConnection; ASQLBuilder: IProductSQLBuilder);
begin
  inherited Create;
  FConn              := AConn;
  FSQLBuilder        := ASQLBuilder;
  FProductSQLBuilder := ASQLBuilder;
end;

function TProductRepositorySQL.DataSetToEntity(ADtsProduct: TDataSet): TBaseEntity;
var
  lProduct: TProduct;
begin
  lProduct := TProduct.FromJSON(ADtsProduct.ToJSONObjectString);

  // Product - Virtuais
  lProduct.&unit.id                 := ADtsProduct.FieldByName('unit_id').AsLargeInt;
  lProduct.&unit.name               := ADtsProduct.FieldByName('unit_name').AsString;
  lProduct.category.id              := ADtsProduct.FieldByName('category_id').AsLargeInt;
  lProduct.category.name            := ADtsProduct.FieldByName('category_name').AsString;
  lProduct.brand.id                 := ADtsProduct.FieldByName('brand_id').AsLargeInt;
  lProduct.brand.name               := ADtsProduct.FieldByName('brand_name').AsString;
  lProduct.size.id                  := ADtsProduct.FieldByName('size_id').AsLargeInt;
  lProduct.size.name                := ADtsProduct.FieldByName('size_name').AsString;
  lProduct.storage_location.id      := ADtsProduct.FieldByName('storage_location_id').AsLargeInt;
  lProduct.storage_location.name    := ADtsProduct.FieldByName('storage_location_name').AsString;
  lProduct.created_by_acl_user.id   := ADtsProduct.FieldByName('created_by_acl_user_id').AsLargeInt;
  lProduct.created_by_acl_user.name := ADtsProduct.FieldByName('created_by_acl_user_name').AsString;
  lProduct.updated_by_acl_user.id   := ADtsProduct.FieldByName('updated_by_acl_user_id').AsLargeInt;
  lProduct.updated_by_acl_user.name := ADtsProduct.FieldByName('updated_by_acl_user_name').AsString;

  Result := lProduct;
end;

function TProductRepositorySQL.SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter;
begin
  Result := FProductSQLBuilder.SelectAllWithFilter(APageFilter);
end;

function TProductRepositorySQL.Show(AId: Int64): TProduct;
begin
  Result := ShowById(AId) as TProduct;
end;

function TProductRepositorySQL.FieldExists(AColumName, AColumnValue: String; AId: Int64): Boolean;
begin
  Result := not FConn.MakeQry.Open(
    FProductSQLBuilder.RegisteredFields(AColumName, AColumnValue, AId)
  ).DataSet.IsEmpty;
end;

procedure TProductRepositorySQL.Validate(AEntity: TBaseEntity);
var
  lProduct: TProduct;
begin
  lProduct := AEntity as TProduct;

  // Verificar se sku_code j� existe
  if not lProduct.sku_code.Trim.IsEmpty then
  begin
    if FieldExists('product.sku_code', lProduct.sku_code, lProduct.id) then
      raise Exception.Create(Format(FIELD_WITH_VALUE_IS_IN_USE, ['product.sku_code', lProduct.sku_code]));
  end;

  // Verificar se ean_code j� existe
  if not lProduct.ean_code.Trim.IsEmpty then
  begin
    if FieldExists('product.ean_code', lProduct.ean_code, lProduct.id) then
      raise Exception.Create(Format(FIELD_WITH_VALUE_IS_IN_USE, ['product.ean_code', lProduct.ean_code]));
  end;

  // Verificar se manufacturing_code j� existe
  if not lProduct.manufacturing_code.Trim.IsEmpty then
  begin
    if FieldExists('product.manufacturing_code', lProduct.manufacturing_code, lProduct.id) then
      raise Exception.Create(Format(FIELD_WITH_VALUE_IS_IN_USE, ['product.manufacturing_code', lProduct.manufacturing_code]));
  end;
end;

end.
