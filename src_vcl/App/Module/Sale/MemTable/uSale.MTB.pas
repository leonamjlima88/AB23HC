unit uSale.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  ISaleMTB = Interface(IEntityMemTable)
    ['{8923A39F-1DBF-4E36-A41C-F5B4C67042B7}']
    // Sale
    function  Sale: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): ISaleMTB;
    function  ToJsonString: String;
    function  CreateSaleIndexMemTable: IZLMemTable;
    procedure SaleSetPerson(APersonId: Int64);
    procedure SaleSetSeller(ASellerId: Int64);
    procedure SaleCalcTotals;

    // SaleItem
    function  SaleItemList: IZLMemTable;
    function  ValidateCurrentSaleItem: String;
  end;

  TSaleMTB = class(TInterfacedObject, ISaleMTB)
  private
    FSale: IZLMemTable;
    FSaleItemList: IZLMemTable;

    // Sale
    procedure SaleAfterInsert(DataSet: TDataSet);

    // SaleItemList
    procedure SaleItemListAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: ISaleMTB;

    // Sale
    function  Sale: IZLMemTable;
    function  CreateSaleMemTable: IZLMemTable;
    function  CreateSaleIndexMemTable: IZLMemTable;
    procedure SaleSetPerson(APersonId: Int64);
    procedure SaleSetSeller(ASellerId: Int64);
    procedure SaleCalcTotals;

    // SaleItemList
    function  SaleItemList: IZLMemTable;
    procedure SaleItemListCalcFields(DataSet: TDataSet);
    function  CreateSaleItemListMemTable: IZLMemTable;
    function  FromJsonString(AJsonString: String): ISaleMTB;
    function  ToJsonString: String;

    procedure Initialize;
    function  Validate: String;
    function  ValidateCurrentSaleItem: String;
  end;

implementation

{ TSaleMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp,
  uPerson.MTB,
  uPerson.Service,
  Quick.Threads,
  Vcl.Dialogs,
  uApplication.Types,
  uHandle.Exception,
  uPerson.TypeInput;

function TSaleMTB.Sale: IZLMemTable;
begin
  Result := FSale;
end;

procedure TSaleMTB.SaleAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

procedure TSaleMTB.SaleCalcTotals;
var
  lSumSaleItemTotal: Double;
  lSumSalePaymentAmount: Double;
  lBookMark: TBookMark;
begin
  if not (FSale.DataSet.State in [dsInsert, dsEdit]) then
    Exit;

  lSumSaleItemTotal := 0;
  if Assigned(FSaleItemList) and FSaleItemList.Active then
  Begin
    Try
      FSaleItemList.DataSet.DisableControls;
      lBookMark := FSaleItemList.DataSet.GetBookmark;

      FSaleItemList.First;
      while not FSaleItemList.Eof do
      begin
        lSumSaleItemTotal := lSumSaleItemTotal + FSaleItemList.FieldByName('total').AsFloat;

        FSaleItemList.Next;
        Application.ProcessMessages;
      end;
    finally
      FSaleItemList.DataSet.GotoBookmark(lBookMark);
      FSaleItemList.DataSet.EnableControls;
      FSaleItemList.DataSet.FreeBookmark(lBookMark);
    end;
  end;

  // Resultado
  FSale.FieldByName('sum_sale_item_total').AsFloat := lSumSaleItemTotal;
end;

function TSaleMTB.SaleItemList: IZLMemTable;
begin
  Result := FSaleItemList;
end;

procedure TSaleMTB.SaleItemListAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

procedure TSaleMTB.SaleItemListCalcFields(DataSet: TDataSet);
var
  lQuantity, lPrice, lUnitDiscount, lSubTotal, lTotal: Double;
begin
  lQuantity     := DataSet.FieldByName('quantity').AsFloat;
  lPrice        := DataSet.FieldByName('price').AsFloat;
  lUnitDiscount := DataSet.FieldByName('unit_discount').AsFloat;
  lSubTotal     := lQuantity * lPrice;
  lTotal        := lSubTotal - (lQuantity * lUnitDiscount);

  DataSet.FieldByName('subtotal').AsFloat := lSubTotal;
  DataSet.FieldByName('total').AsFloat    := lTotal;
end;

procedure TSaleMTB.SaleSetPerson(APersonId: Int64);
var
  lMTB: IPersonMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (APersonId <= 0) then Exit;
      lMTB := TPersonService.Make.ShowByIdAndPersonType(TPersonTypeInput.Make.id(APersonId).is_customer(true));
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
        lKeepGoing := FSale.DataSet.Active and (FSale.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          APersonId := 0;
          Exit;
        End;

        // Carregar resultado
        With FSale do
        begin
          FieldByName('person_id').AsLargeInt := lMTB.Person.FieldByName('id').AsLargeInt;
          FieldByName('person_name').AsString := lMTB.Person.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (APersonId <= 0) and (FSale.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FSale do
          begin
            FieldByName('person_id').Clear;
            FieldByName('person_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

procedure TSaleMTB.SaleSetSeller(ASellerId: Int64);
var
  lMTB: IPersonMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (ASellerId <= 0) then Exit;
      lMTB := TPersonService.Make.ShowByIdAndPersonType(TPersonTypeInput.Make.id(ASellerId).is_seller(true));
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
        lKeepGoing := FSale.DataSet.Active and (FSale.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          ASellerId := 0;
          Exit;
        End;

        // Carregar resultado
        With FSale do
        begin
          FieldByName('seller_id').AsLargeInt := lMTB.Person.FieldByName('id').AsLargeInt;
          FieldByName('seller_name').AsString := lMTB.Person.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (ASellerId <= 0) and (FSale.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FSale do
          begin
            FieldByName('seller_id').Clear;
            FieldByName('seller_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

constructor TSaleMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TSaleMTB.CreateSaleItemListMemTable: IZLMemTable;
begin
  // SaleItemList
  Result := TMemTableFactory.Make
    .AddField('id',                ftLargeint)
    .AddField('product_id',        ftLargeint)
    .AddField('note',              ftString, 5000)
    .AddField('quantity',          ftFloat)
    .AddField('price',             ftFloat)
    .AddField('unit_discount',     ftFloat)
    .AddField('subtotal',          ftFloat, 0, fkInternalCalc)
    .AddField('total',             ftFloat, 0, fkInternalCalc)
    .AddField('product_name',      ftString, 255)
    .AddField('product_unit_id',   ftLargeint)
    .AddField('product_unit_name', ftString, 10)
    .CreateDataSet
  .Active(True);

  // Formatar Dataset
  THlp.FormatDataSet(Result.DataSet);

  // Eventos
  With Result do
  begin
    DataSet.AfterInsert  := SaleItemListAfterInsert;
    DataSet.OnCalcFields := SaleItemListCalcFields;
  end;
end;

function TSaleMTB.CreateSaleIndexMemTable: IZLMemTable;
begin
  Result := CreateSaleMemTable;
end;

function TSaleMTB.CreateSaleMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                               ftLargeint)
    .AddField('person_id',                        ftLargeint)
    .AddField('seller_id',                        ftLargeInt)
    .AddField('note',                             ftString, 5000)
    .AddField('internal_note',                    ftString, 5000)
    .AddField('status',                           ftSmallInt)
    .AddField('sum_sale_item_total',              ftFloat)
    .AddField('sum_sale_payment_amount',          ftFloat)
    .AddField('payment_discount',                 ftFloat)
    .AddField('payment_increase',                 ftFloat)
    .AddField('payment_total',                    ftFloat)
    .AddField('created_at',                       ftDateTime)
    .AddField('updated_at',                       ftDateTime)
    .AddField('person_name',                      ftString, 255)
    .AddField('seller_name',                      ftString, 255)
    .AddField('created_by_acl_user_id',           ftLargeint)
    .AddField('created_by_acl_user_name',         ftString, 100)
    .AddField('updated_by_acl_user_id',           ftLargeint)
    .AddField('updated_by_acl_user_name',         ftString, 100)
    .CreateDataSet
  .Active(True);

  // Formatar Dataset
  THlp.FormatDataSet(Result.DataSet);

  // Eventos
  With Result do
  begin
    DataSet.AfterInsert := SaleAfterInsert;
  end;
end;

function TSaleMTB.FromJsonString(AJsonString: String): ISaleMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // Sale
  FSale.DataSet.LoadFromJSON(lSObj.AsJSON);

  // SaleItemList
  FSaleItemList.DataSet.LoadFromJSON(lSObj.A['sale_item_list'].AsJSON);
end;

procedure TSaleMTB.Initialize;
begin
  FSale         := CreateSaleMemTable;
  FSaleItemList := CreateSaleItemListMemTable;
end;

class function TSaleMTB.Make: ISaleMTB;
begin
  Result := Self.Create;
end;

function TSaleMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // Sale
  lSObj := SO(FSale.DataSet.ToJSONObjectString);

  // SaleItemList
  lSObj.A['sale_item_list'] := SA(FSaleItemList.DataSet.ToJSONArrayString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TSaleMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
  lCurrentError: String;
  lI: Integer;
  lBookMark: TBookMark;
begin
  // Sale
  With FSale do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if (FieldByName('seller_id').AsLargeInt <= 0) then
      lErrors := lErrors + 'O campo [Vendedor] é obrigatório' + #13;
  end;

  // SaleItem
  if (FSaleItemList.RecordCount <= 0) then
    lErrors := lErrors + 'Nenhum item informado' + #13;
  With FSaleItemList.DataSet do
  begin
    Try
      DisableControls;
      lBookMark := GetBookmark;
      lI := 0;
      First;
      while not Eof do
      begin
        Inc(lI);
        lCurrentError := '  ' + ValidateCurrentSaleItem;
        if not lCurrentError.Trim.IsEmpty then
          lErrors := lErrors + 'Em Venda > Item > Posição: ' + THlp.strZero(lI.ToString,2) + ' > ' + #13 + lCurrentError + #13;

        Next;
        Application.ProcessMessages;
      end;
    finally
      GotoBookmark(lBookMark);
      EnableControls;
      FreeBookmark(lBookMark);
    end;
  end;

  Result := lErrors;
end;

function TSaleMTB.ValidateCurrentSaleItem: String;
var
  lErrors: String;
begin
  With FSaleItemList do
  begin
    if (FieldByName('product_id').AsLargeInt <= 0) then
      lErrors := lErrors + 'O campo [Produto] é obrigatório' + #13;

    if (FieldByName('quantity').AsLargeInt <= 0) then
      lErrors := lErrors + 'O campo [Quantidade] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
