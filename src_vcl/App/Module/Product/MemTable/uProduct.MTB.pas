unit uProduct.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IProductMTB = Interface(IEntityMemTable)
    ['{407E4CA4-5E72-4D47-85CC-5A4CDE167916}']
    function  Product: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IProductMTB;
    function  ToJsonString: String;
    function  CreateProductIndexMemTable: IZLMemTable;
    procedure ProductSetUnit(AUnitId: Int64);
    procedure ProductSetNCM(ANCMId: Int64);
    procedure ProductSetCategory(ACategoryId: Int64);
    procedure ProductSetBrand(ABrandId: Int64);
    procedure ProductSetSize(ASizeId: Int64);
    procedure ProductSetStorageLocation(AStorageLocationId: Int64);
  end;

  TProductMTB = class(TInterfacedObject, IProductMTB)
  private
    FProduct: IZLMemTable;

    // Product
    procedure ProductAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IProductMTB;

    // Product
    function  Product: IZLMemTable;
    function  FromJsonString(AJsonString: String): IProductMTB;
    function  ToJsonString: String;
    function  CreateProductMemTable: IZLMemTable;
    function  CreateProductIndexMemTable: IZLMemTable;
    procedure ProductSetUnit(AUnitId: Int64);
    procedure ProductSetNCM(ANCMId: Int64);
    procedure ProductSetCategory(ACategoryId: Int64);
    procedure ProductSetBrand(ABrandId: Int64);
    procedure ProductSetSize(ASizeId: Int64);
    procedure ProductSetStorageLocation(AStorageLocationId: Int64);

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TProductMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp,
  uUnit.MTB,
  uUnit.Service,
  Quick.Threads,
  Vcl.Dialogs,
  uApplication.Types,
  uHandle.Exception,
  uNCM.MTB,
  uNCM.Service,
  uCategory.MTB,
  uCategory.Service,
  uBrand.MTB,
  uBrand.Service,
  uSize.MTB,
  uSize.Service,
  uStorageLocation.MTB,
  uStorageLocation.Service;

function TProductMTB.Product: IZLMemTable;
begin
  Result := FProduct;
end;

procedure TProductMTB.ProductAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);

  DataSet.FieldByName('unit_id').AsInteger := 1;
  DataSet.FieldByName('ncm_id').AsInteger := 1;
end;

procedure TProductMTB.ProductSetNCM(ANCMId: Int64);
var
  lMTB: INCMMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (ANCMId <= 0) then Exit;
      lMTB := TNCMService.Make.Show(ANCMId);
    end)
  .OnException_Sync(
    procedure(ATask : ITask; AException : Exception)
    begin
      MessageDlg(
        OOPS_MESSAGE + #13 +
        THandleException.TranslateToLayMessage(AException.Message) + #13 + #13 +
        'Mensagem Técnica: ' + AException.Message,
        mtWarning, [mbOK], 0
      );
    end)
  .OnTerminated_Sync(
    procedure(ATask: ITask)
    var
      lKeepGoing: Boolean;
    begin
      Try
        lKeepGoing := FProduct.DataSet.Active and (FProduct.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          ANCMId := 0;
          Exit;
        End;

        // Carregar resultado
        With FProduct do
        begin
          FieldByName('ncm_id').AsLargeInt := lMTB.NCM.FieldByName('id').AsLargeInt;
          FieldByName('ncm_name').AsString := lMTB.NCM.FieldByName('name').AsString;
          FieldByName('ncm_ncm').AsString  := lMTB.NCM.FieldByName('ncm').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (ANCMId <= 0) and (FProduct.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FProduct do
          begin
            FieldByName('ncm_id').Clear;
            FieldByName('ncm_name').Clear;
            FieldByName('ncm_ncm').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

procedure TProductMTB.ProductSetSize(ASizeId: Int64);
var
  lMTB: ISizeMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (ASizeId <= 0) then Exit;
      lMTB := TSizeService.Make.Show(ASizeId);
    end)
  .OnException_Sync(
    procedure(ATask : ITask; AException : Exception)
    begin
      MessageDlg(
        OOPS_MESSAGE + #13 +
        THandleException.TranslateToLayMessage(AException.Message) + #13 + #13 +
        'Mensagem Técnica: ' + AException.Message,
        mtWarning, [mbOK], 0
      );
    end)
  .OnTerminated_Sync(
    procedure(ATask: ITask)
    var
      lKeepGoing: Boolean;
    begin
      Try
        lKeepGoing := FProduct.DataSet.Active and (FProduct.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          ASizeId := 0;
          Exit;
        End;

        // Carregar resultado
        With FProduct do
        begin
          FieldByName('size_id').AsLargeInt := lMTB.Size.FieldByName('id').AsLargeInt;
          FieldByName('size_name').AsString := lMTB.Size.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (ASizeId <= 0) and (FProduct.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FProduct do
          begin
            FieldByName('size_id').Clear;
            FieldByName('size_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

procedure TProductMTB.ProductSetStorageLocation(AStorageLocationId: Int64);
var
  lMTB: IStorageLocationMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (AStorageLocationId <= 0) then Exit;
      lMTB := TStorageLocationService.Make.Show(AStorageLocationId);
    end)
  .OnException_Sync(
    procedure(ATask : ITask; AException : Exception)
    begin
      MessageDlg(
        OOPS_MESSAGE + #13 +
        THandleException.TranslateToLayMessage(AException.Message) + #13 + #13 +
        'Mensagem Técnica: ' + AException.Message,
        mtWarning, [mbOK], 0
      );
    end)
  .OnTerminated_Sync(
    procedure(ATask: ITask)
    var
      lKeepGoing: Boolean;
    begin
      Try
        lKeepGoing := FProduct.DataSet.Active and (FProduct.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          AStorageLocationId := 0;
          Exit;
        End;

        // Carregar resultado
        With FProduct do
        begin
          FieldByName('storage_location_id').AsLargeInt := lMTB.StorageLocation.FieldByName('id').AsLargeInt;
          FieldByName('storage_location_name').AsString := lMTB.StorageLocation.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (AStorageLocationId <= 0) and (FProduct.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FProduct do
          begin
            FieldByName('storage_location_id').Clear;
            FieldByName('storage_location_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

procedure TProductMTB.ProductSetUnit(AUnitId: Int64);
var
  lMTB: IUnitMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (AUnitId <= 0) then Exit;
      lMTB := TUnitService.Make.Show(AUnitId);
    end)
  .OnException_Sync(
    procedure(ATask : ITask; AException : Exception)
    begin
      MessageDlg(
        OOPS_MESSAGE + #13 +
        THandleException.TranslateToLayMessage(AException.Message) + #13 + #13 +
        'Mensagem Técnica: ' + AException.Message,
        mtWarning, [mbOK], 0
      );
    end)
  .OnTerminated_Sync(
    procedure(ATask: ITask)
    var
      lKeepGoing: Boolean;
    begin
      Try
        lKeepGoing := FProduct.DataSet.Active and (FProduct.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          AUnitId := 0;
          Exit;
        End;

        // Carregar resultado
        With FProduct do
        begin
          FieldByName('unit_id').AsLargeInt := lMTB.&Unit.FieldByName('id').AsLargeInt;
          FieldByName('unit_name').AsString := lMTB.&Unit.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (AUnitId <= 0) and (FProduct.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FProduct do
          begin
            FieldByName('unit_id').Clear;
            FieldByName('unit_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

procedure TProductMTB.ProductSetBrand(ABrandId: Int64);
var
  lMTB: IBrandMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (ABrandId <= 0) then Exit;
      lMTB := TBrandService.Make.Show(ABrandId);
    end)
  .OnException_Sync(
    procedure(ATask : ITask; AException : Exception)
    begin
      MessageDlg(
        OOPS_MESSAGE + #13 +
        THandleException.TranslateToLayMessage(AException.Message) + #13 + #13 +
        'Mensagem Técnica: ' + AException.Message,
        mtWarning, [mbOK], 0
      );
    end)
  .OnTerminated_Sync(
    procedure(ATask: ITask)
    var
      lKeepGoing: Boolean;
    begin
      Try
        lKeepGoing := FProduct.DataSet.Active and (FProduct.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          ABrandId := 0;
          Exit;
        End;

        // Carregar resultado
        With FProduct do
        begin
          FieldByName('brand_id').AsLargeInt := lMTB.Brand.FieldByName('id').AsLargeInt;
          FieldByName('brand_name').AsString := lMTB.Brand.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (ABrandId <= 0) and (FProduct.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FProduct do
          begin
            FieldByName('brand_id').Clear;
            FieldByName('brand_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

procedure TProductMTB.ProductSetCategory(ACategoryId: Int64);
var
  lMTB: ICategoryMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (ACategoryId <= 0) then Exit;
      lMTB := TCategoryService.Make.Show(ACategoryId);
    end)
  .OnException_Sync(
    procedure(ATask : ITask; AException : Exception)
    begin
      MessageDlg(
        OOPS_MESSAGE + #13 +
        THandleException.TranslateToLayMessage(AException.Message) + #13 + #13 +
        'Mensagem Técnica: ' + AException.Message,
        mtWarning, [mbOK], 0
      );
    end)
  .OnTerminated_Sync(
    procedure(ATask: ITask)
    var
      lKeepGoing: Boolean;
    begin
      Try
        lKeepGoing := FProduct.DataSet.Active and (FProduct.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          ACategoryId := 0;
          Exit;
        End;

        // Carregar resultado
        With FProduct do
        begin
          FieldByName('category_id').AsLargeInt := lMTB.Category.FieldByName('id').AsLargeInt;
          FieldByName('category_name').AsString := lMTB.Category.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (ACategoryId <= 0) and (FProduct.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FProduct do
          begin
            FieldByName('category_id').Clear;
            FieldByName('category_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

constructor TProductMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TProductMTB.CreateProductIndexMemTable: IZLMemTable;
begin
  Result := CreateProductMemTable;
end;

function TProductMTB.CreateProductMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 255)
    .AddField('simplified_name',          ftString, 30)
    .AddField('type',                     ftSmallint)
    .AddField('sku_code',                 ftString, 45)
    .AddField('ean_code',                 ftString, 45)
    .AddField('manufacturing_code',       ftString, 45)
    .AddField('identification_code',      ftString, 45)
    .AddField('cost',                     ftFloat)
    .AddField('marketup',                 ftFloat)
    .AddField('price',                    ftFloat)
    .AddField('current_quantity',         ftFloat)
    .AddField('minimum_quantity',         ftFloat)
    .AddField('maximum_quantity',         ftFloat)
    .AddField('gross_weight',             ftFloat)
    .AddField('net_weight',               ftFloat)
    .AddField('packing_weight',           ftFloat)
    .AddField('is_to_move_the_stock',     ftSmallint)
    .AddField('is_product_for_scales',    ftSmallint)
    .AddField('internal_note',            ftString, 5000)
    .AddField('complement_note',          ftString, 5000)
    .AddField('is_discontinued',          ftSmallint)
    .AddField('unit_id',                  ftInteger)
    .AddField('ncm_id',                   ftLargeint)
    .AddField('category_id',              ftLargeint)
    .AddField('brand_id',                 ftLargeint)
    .AddField('size_id',                  ftLargeint)
    .AddField('storage_location_id',      ftLargeint)
    .AddField('genre',                    ftSmallint)
    .AddField('created_at',               ftDateTime)
    .AddField('updated_at',               ftDateTime)
    .AddField('unit_name',                ftString, 10)
    .AddField('ncm_name',                 ftString, 255)
    .AddField('ncm_ncm',                  ftString, 100)
    .AddField('category_name',            ftString, 100)
    .AddField('brand_name',               ftString, 100)
    .AddField('size_name',                ftString, 100)
    .AddField('storage_location_name',    ftString, 100)
    .AddField('created_by_acl_user_id',   ftLargeint)
    .AddField('created_by_acl_user_name', ftString, 100)
    .AddField('updated_by_acl_user_id',   ftLargeint)
    .AddField('updated_by_acl_user_name', ftString, 100)
    .CreateDataSet
  .Active(True);

  // Formatar Dataset
  THlp.FormatDataSet(Result.DataSet);

  // Eventos
  With Result.DataSet do
  begin
    AfterInsert := ProductAfterInsert;
  end;
end;

function TProductMTB.FromJsonString(AJsonString: String): IProductMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // Product
  FProduct.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TProductMTB.Initialize;
begin
  FProduct := CreateProductMemTable;
end;

class function TProductMTB.Make: IProductMTB;
begin
  Result := Self.Create;
end;

function TProductMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // Product
  lSObj := SO(FProduct.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TProductMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // Product
  With FProduct do
  begin

    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;

    if (FieldByName('unit_id').AsLargeInt <= 0) then
      lErrors := lErrors + 'O campo [Unidade de Medida] é obrigatório' + #13;

    if (FieldByName('ncm_id').AsLargeInt <= 0) then
      lErrors := lErrors + 'O campo [NCM] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
