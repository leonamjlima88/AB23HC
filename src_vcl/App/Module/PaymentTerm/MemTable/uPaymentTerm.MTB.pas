unit uPaymentTerm.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IPaymentTermMTB = Interface(IEntityMemTable)
    ['{8B377CE0-5BFD-4632-91FA-2E8C56B6E668}']
    function  PaymentTerm: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IPaymentTermMTB;
    function  ToJsonString: String;
    function  CreatePaymentTermIndexMemTable: IZLMemTable;
    procedure PaymentTermSetBankAccount(ABankAccountId: Int64);
    procedure PaymentTermSetDocument(ADocumentId: Int64);
  end;

  TPaymentTermMTB = class(TInterfacedObject, IPaymentTermMTB)
  private
    FPaymentTerm: IZLMemTable;

    // PaymentTerm
    procedure PaymentTermAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IPaymentTermMTB;

    // PaymentTerm
    function  PaymentTerm: IZLMemTable;
    function  FromJsonString(AJsonString: String): IPaymentTermMTB;
    function  ToJsonString: String;
    function  CreatePaymentTermMemTable: IZLMemTable;
    function  CreatePaymentTermIndexMemTable: IZLMemTable;
    procedure PaymentTermSetBankAccount(ABankAccountId: Int64);
    procedure PaymentTermSetDocument(ADocumentId: Int64);

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TPaymentTermMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp,
  uBankAccount.MTB,
  Quick.Threads,
  uBankAccount.Service,
  Vcl.Dialogs,
  uApplication.Types,
  uHandle.Exception,
  uDocument.MTB,
  uDocument.Service;

function TPaymentTermMTB.PaymentTerm: IZLMemTable;
begin
  Result := FPaymentTerm;
end;

procedure TPaymentTermMTB.PaymentTermAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
  DataSet.FieldByName('number_of_installments').AsInteger := 1;
end;

procedure TPaymentTermMTB.PaymentTermSetBankAccount(ABankAccountId: Int64);
var
  lMTB: IBankAccountMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (ABankAccountId <= 0) then Exit;
      lMTB := TBankAccountService.Make.Show(ABankAccountId);
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
        lKeepGoing := FPaymentTerm.DataSet.Active and (FPaymentTerm.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          ABankAccountId := 0;
          Exit;
        End;

        // Carregar resultado
        With FPaymentTerm do
        begin
          FieldByName('bank_account_id').AsLargeInt      := lMTB.BankAccount.FieldByName('id').AsLargeInt;
          FieldByName('bank_account_name').AsString      := lMTB.BankAccount.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (ABankAccountId <= 0) and (FPaymentTerm.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FPaymentTerm do
          begin
            FieldByName('bank_account_id').Clear;
            FieldByName('bank_account_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

procedure TPaymentTermMTB.PaymentTermSetDocument(ADocumentId: Int64);
var
  lMTB: IDocumentMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (ADocumentId <= 0) then Exit;
      lMTB := TDocumentService.Make.Show(ADocumentId);
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
        lKeepGoing := FPaymentTerm.DataSet.Active and (FPaymentTerm.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          ADocumentId := 0;
          Exit;
        End;

        // Carregar resultado
        With FPaymentTerm do
        begin
          FieldByName('document_id').AsLargeInt      := lMTB.Document.FieldByName('id').AsLargeInt;
          FieldByName('document_name').AsString      := lMTB.Document.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (ADocumentId <= 0) and (FPaymentTerm.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FPaymentTerm do
          begin
            FieldByName('document_id').Clear;
            FieldByName('document_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

constructor TPaymentTermMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TPaymentTermMTB.CreatePaymentTermIndexMemTable: IZLMemTable;
begin
  Result := CreatePaymentTermMemTable;
end;

function TPaymentTermMTB.CreatePaymentTermMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                            ftLargeint)
    .AddField('name',                          ftString, 100)
    .AddField('number_of_installments',        ftSmallint)
    .AddField('first_installment_in',          ftSmallint)
    .AddField('interval_between_installments', ftSmallint)
    .AddField('bank_account_id',               ftLargeint)
    .AddField('document_id',                   ftLargeint)
    .AddField('bank_account_name',             ftString, 100)
    .AddField('document_name',                 ftString, 100)
    .AddField('created_at',                    ftDateTime)
    .AddField('updated_at',                    ftDateTime)
    .AddField('created_by_acl_user_id',        ftLargeint)
    .AddField('created_by_acl_user_name',      ftString, 100)
    .AddField('updated_by_acl_user_id',        ftLargeint)
    .AddField('updated_by_acl_user_name',      ftString, 100)
    .CreateDataSet
  .Active(True);

  // Formatar Dataset
  THlp.FormatDataSet(Result.DataSet);

  // Eventos
  With Result.DataSet do
  begin
    AfterInsert := PaymentTermAfterInsert;
  end;
end;

function TPaymentTermMTB.FromJsonString(AJsonString: String): IPaymentTermMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // PaymentTerm
  FPaymentTerm.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TPaymentTermMTB.Initialize;
begin
  FPaymentTerm := CreatePaymentTermMemTable;
end;

class function TPaymentTermMTB.Make: IPaymentTermMTB;
begin
  Result := Self.Create;
end;

function TPaymentTermMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // PaymentTerm
  lSObj := SO(FPaymentTerm.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TPaymentTermMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // PaymentTerm
  With FPaymentTerm do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;

    if (FieldByName('number_of_installments').AsInteger <= 0) then
      lErrors := lErrors + 'O campo [Total de Parcelas] é obrigatório' + #13;

    if (FieldByName('bank_account_id').AsInteger <= 0) then
      lErrors := lErrors + 'O campo [Conta Bancária] é obrigatório' + #13;

    if (FieldByName('document_id').AsInteger <= 0) then
      lErrors := lErrors + 'O campo [Documento] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
