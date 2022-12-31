unit uBankAccount.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IBankAccountMTB = Interface(IEntityMemTable)
    ['{1A9CAE28-597D-4340-9785-BB218B8BE1D6}']
    function  BankAccount: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IBankAccountMTB;
    function  ToJsonString: String;
    function  CreateBankAccountIndexMemTable: IZLMemTable;
    procedure BankAccountSetBank(ABankId: Int64);
  end;

  TBankAccountMTB = class(TInterfacedObject, IBankAccountMTB)
  private
    FBankAccount: IZLMemTable;

    // BankAccount
    procedure BankAccountAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IBankAccountMTB;

    // BankAccount
    function  BankAccount: IZLMemTable;
    function  FromJsonString(AJsonString: String): IBankAccountMTB;
    function  ToJsonString: String;
    function  CreateBankAccountMemTable: IZLMemTable;
    function  CreateBankAccountIndexMemTable: IZLMemTable;
    procedure BankAccountSetBank(ABankId: Int64);

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TBankAccountMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp,
  uBank.MTB,
  Quick.Threads,
  uBank.Service,
  Vcl.Dialogs,
  uApplication.Types,
  uHandle.Exception;

function TBankAccountMTB.BankAccount: IZLMemTable;
begin
  Result := FBankAccount;
end;

procedure TBankAccountMTB.BankAccountAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TBankAccountMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TBankAccountMTB.CreateBankAccountIndexMemTable: IZLMemTable;
begin
  Result := CreateBankAccountMemTable;
end;

function TBankAccountMTB.CreateBankAccountMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 100)
    .AddField('bank_id',                  ftLargeint)
    .AddField('note',                     ftString, 5000)
    .AddField('bank_name',                ftString, 100)
    .AddField('created_at',               ftDateTime)
    .AddField('updated_at',               ftDateTime)
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
    AfterInsert := BankAccountAfterInsert;
  end;
end;

function TBankAccountMTB.FromJsonString(AJsonString: String): IBankAccountMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // BankAccount
  FBankAccount.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TBankAccountMTB.Initialize;
begin
  FBankAccount := CreateBankAccountMemTable;
end;

class function TBankAccountMTB.Make: IBankAccountMTB;
begin
  Result := Self.Create;
end;

procedure TBankAccountMTB.BankAccountSetBank(ABankId: Int64);
var
  lMTB: IBankMTB;
begin
  // Executar Task
  TRunTask.Execute(
    procedure(ATask: ITask)
    begin
      if (ABankId <= 0) then Exit;
      lMTB := TBankService.Make.Show(ABankId);
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
        lKeepGoing := FBankAccount.DataSet.Active and (FBankAccount.DataSet.State in [dsInsert, dsEdit]);
        if ((Assigned(LMTB) = False) or (lKeepGoing = False)) then
        Begin
          ABankId := 0;
          Exit;
        End;

        // Carregar resultado
        With FBankAccount do
        begin
          FieldByName('bank_id').AsLargeInt      := lMTB.Bank.FieldByName('id').AsLargeInt;
          FieldByName('bank_name').AsString      := lMTB.Bank.FieldByName('name').AsString;
        end;
      finally
        // Limpar se não encontrar
        if (ABankId <= 0) and (FBankAccount.DataSet.State in [dsInsert, dsEdit]) then
        Begin
          With FBankAccount do
          begin
            FieldByName('bank_id').Clear;
            FieldByName('bank_name').Clear;
          end;
        end;
      end;
    end)
  .Run;
end;

function TBankAccountMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // BankAccount
  lSObj := SO(FBankAccount.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TBankAccountMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // BankAccount
  With FBankAccount do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;

    if FieldByName('bank_id').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Banco] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
