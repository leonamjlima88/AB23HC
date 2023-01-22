unit uBusinessProposal.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IBusinessProposalMTB = Interface(IEntityMemTable)
    ['{2A1C20F5-6992-4CDE-B7DD-73FCEA67AE53}']
    // BusinessProposal
    function  BusinessProposal: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IBusinessProposalMTB;
    function  ToJsonString: String;
    function  CreateBusinessProposalIndexMemTable: IZLMemTable;
    procedure BusinessProposalSetPerson(APersonId: Int64);
    procedure BusinessProposalSetSeller(ASellerId: Int64);
    procedure BusinessProposalCalcTotals;

    // BusinessProposalItem
    function  BusinessProposalItemList: IZLMemTable;
    function  ValidateCurrentBusinessProposalItem: String;
  end;

  TBusinessProposalMTB = class(TInterfacedObject, IBusinessProposalMTB)
  private
    FBusinessProposal: IZLMemTable;
    FBusinessProposalItemList: IZLMemTable;

    // BusinessProposal
    procedure BusinessProposalAfterInsert(DataSet: TDataSet);

    // BusinessProposalItemList
    procedure BusinessProposalItemListAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IBusinessProposalMTB;

    // BusinessProposal
    function  BusinessProposal: IZLMemTable;
    function  CreateBusinessProposalMemTable: IZLMemTable;
    function  CreateBusinessProposalIndexMemTable: IZLMemTable;
    procedure BusinessProposalSetPerson(APersonId: Int64);
    procedure BusinessProposalSetSeller(ASellerId: Int64);
    procedure BusinessProposalCalcTotals;

    // BusinessProposalItemList
    function  BusinessProposalItemList: IZLMemTable;
    procedure BusinessProposalItemListCalcFields(DataSet: TDataSet);
    function  CreateBusinessProposalItemListMemTable: IZLMemTable;
    function  FromJsonString(AJsonString: String): IBusinessProposalMTB;
    function  ToJsonString: String;

    procedure Initialize;
    function  Validate: String;
    function  ValidateCurrentBusinessProposalItem: String;
  end;

implementation

{ TBusinessProposalMTB }

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

function TBusinessProposalMTB.BusinessProposal: IZLMemTable;
begin
  Result := FBusinessProposal;
end;

procedure TBusinessProposalMTB.BusinessProposalAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

procedure TBusinessProposalMTB.BusinessProposalCalcTotals;
var
  lSumBusinessProposalItemTotal: Double;
  lBookMark: TBookMark;
begin
  if not (FBusinessProposal.DataSet.State in [dsInsert, dsEdit]) then
    Exit;

  // Calcular
  lSumBusinessProposalItemTotal := 0;
  if Assigned(FBusinessProposalItemList) and FBusinessProposalItemList.Active then
  Begin
    Try
      FBusinessProposalItemList.DataSet.DisableControls;
      lBookMark := FBusinessProposalItemList.DataSet.GetBookmark;

      FBusinessProposalItemList.First;
      while not FBusinessProposalItemList.Eof do
      begin
        lSumBusinessProposalItemTotal := lSumBusinessProposalItemTotal + FBusinessProposalItemList.FieldByName('total').AsFloat;

        FBusinessProposalItemList.Next;
        Application.ProcessMessages;
      end;
    finally
      FBusinessProposalItemList.DataSet.GotoBookmark(lBookMark);
      FBusinessProposalItemList.DataSet.EnableControls;
      FBusinessProposalItemList.DataSet.FreeBookmark(lBookMark);
    end;
  end;

  // Resultado
  FBusinessProposal.FieldByName('sum_business_proposal_item_total').AsFloat := lSumBusinessProposalItemTotal;
end;

function TBusinessProposalMTB.BusinessProposalItemList: IZLMemTable;
begin
  Result := FBusinessProposalItemList;
end;

procedure TBusinessProposalMTB.BusinessProposalItemListAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

procedure TBusinessProposalMTB.BusinessProposalItemListCalcFields(DataSet: TDataSet);
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

procedure TBusinessProposalMTB.BusinessProposalSetPerson(APersonId: Int64);
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
        lKeepGoing := FBusinessProposal.DataSet.Active and (FBusinessProposal.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          APersonId := 0;
          Exit;
        End;

        // Carregar resultado
        With FBusinessProposal do
        begin
          FieldByName('person_id').AsLargeInt := lMTB.Person.FieldByName('id').AsLargeInt;
          FieldByName('person_name').AsString := lMTB.Person.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (APersonId <= 0) and (FBusinessProposal.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FBusinessProposal do
          begin
            FieldByName('person_id').Clear;
            FieldByName('person_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

procedure TBusinessProposalMTB.BusinessProposalSetSeller(ASellerId: Int64);
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
        lKeepGoing := FBusinessProposal.DataSet.Active and (FBusinessProposal.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          ASellerId := 0;
          Exit;
        End;

        // Carregar resultado
        With FBusinessProposal do
        begin
          FieldByName('seller_id').AsLargeInt := lMTB.Person.FieldByName('id').AsLargeInt;
          FieldByName('seller_name').AsString := lMTB.Person.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (ASellerId <= 0) and (FBusinessProposal.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FBusinessProposal do
          begin
            FieldByName('seller_id').Clear;
            FieldByName('seller_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

constructor TBusinessProposalMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TBusinessProposalMTB.CreateBusinessProposalItemListMemTable: IZLMemTable;
begin
  // BusinessProposalItemList
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
    DataSet.AfterInsert  := BusinessProposalItemListAfterInsert;
    DataSet.OnCalcFields := BusinessProposalItemListCalcFields;
  end;
end;

function TBusinessProposalMTB.CreateBusinessProposalIndexMemTable: IZLMemTable;
begin
  Result := CreateBusinessProposalMemTable;
end;

function TBusinessProposalMTB.CreateBusinessProposalMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                               ftLargeint)
    .AddField('person_id',                        ftLargeint)
    .AddField('requester',                        ftString, 100)
    .AddField('expiration_date',                  ftDate)
    .AddField('delivery_forecast',                ftString, 100)
    .AddField('seller_id',                        ftLargeInt)
    .AddField('note',                             ftString, 5000)
    .AddField('internal_note',                    ftString, 5000)
    .AddField('payment_term_note',                ftString, 5000)
    .AddField('status',                           ftSmallInt)
    .AddField('sum_business_proposal_item_total', ftFloat)
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
    DataSet.AfterInsert := BusinessProposalAfterInsert;
  end;
end;

function TBusinessProposalMTB.FromJsonString(AJsonString: String): IBusinessProposalMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // BusinessProposal
  FBusinessProposal.DataSet.LoadFromJSON(lSObj.AsJSON);

  // BusinessProposalItemList
  FBusinessProposalItemList.DataSet.LoadFromJSON(lSObj.A['business_proposal_item_list'].AsJSON);
end;

procedure TBusinessProposalMTB.Initialize;
begin
  FBusinessProposal         := CreateBusinessProposalMemTable;
  FBusinessProposalItemList := CreateBusinessProposalItemListMemTable;
end;

class function TBusinessProposalMTB.Make: IBusinessProposalMTB;
begin
  Result := Self.Create;
end;

function TBusinessProposalMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // BusinessProposal
  lSObj := SO(FBusinessProposal.DataSet.ToJSONObjectString);

  // BusinessProposalItemList
  lSObj.A['business_proposal_item_list'] := SA(FBusinessProposalItemList.DataSet.ToJSONArrayString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TBusinessProposalMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
  lCurrentError: String;
  lI: Integer;
  lBookMark: TBookMark;
begin
  // BusinessProposal
  With FBusinessProposal do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if (FieldByName('seller_id').AsLargeInt <= 0) then
      lErrors := lErrors + 'O campo [Vendedor] é obrigatório' + #13;

    if (FieldByName('expiration_date').AsDateTime <= 0) then
      lErrors := lErrors + 'O campo [Validade da Proposta] é obrigatório' + #13;
  end;

  // BusinessProposalItem
  if (FBusinessProposalItemList.RecordCount <= 0) then
    lErrors := lErrors + 'Nenhum item informado' + #13;
  With FBusinessProposalItemList.DataSet do
  begin
    Try
      DisableControls;
      lBookMark := GetBookmark;
      lI := 0;
      First;
      while not Eof do
      begin
        Inc(lI);
        lCurrentError := '  ' + ValidateCurrentBusinessProposalItem;
        if not lCurrentError.Trim.IsEmpty then
          lErrors := lErrors + 'Em Proposta > Item > Posição: ' + THlp.strZero(lI.ToString,2) + ' > ' + #13 + lCurrentError + #13;

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

function TBusinessProposalMTB.ValidateCurrentBusinessProposalItem: String;
var
  lErrors: String;
begin
  With FBusinessProposalItemList do
  begin
    if (FieldByName('product_id').AsLargeInt <= 0) then
      lErrors := lErrors + 'O campo [Produto] é obrigatório' + #13;

    if (FieldByName('quantity').AsLargeInt <= 0) then
      lErrors := lErrors + 'O campo [Quantidade] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
