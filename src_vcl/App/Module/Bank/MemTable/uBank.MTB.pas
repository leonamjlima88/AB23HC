unit uBank.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IBankMTB = Interface(IEntityMemTable)
    ['{EB3B5070-A4EF-4566-A07C-AC7BF73E5D2C}']
    function  Bank: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IBankMTB;
    function  ToJsonString: String;
    function  CreateBankIndexMemTable: IZLMemTable;
  end;

  TBankMTB = class(TInterfacedObject, IBankMTB)
  private
    FBank: IZLMemTable;

    // Bank
    procedure BankAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IBankMTB;

    // Bank
    function  Bank: IZLMemTable;
    function  FromJsonString(AJsonString: String): IBankMTB;
    function  ToJsonString: String;
    function  CreateBankMemTable: IZLMemTable;
    function  CreateBankIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TBankMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TBankMTB.Bank: IZLMemTable;
begin
  Result := FBank;
end;

procedure TBankMTB.BankAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TBankMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TBankMTB.CreateBankIndexMemTable: IZLMemTable;
begin
  Result := CreateBankMemTable;
end;

function TBankMTB.CreateBankMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 100)
    .AddField('code',                     ftString, 3)
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
    AfterInsert := BankAfterInsert;
  end;
end;

function TBankMTB.FromJsonString(AJsonString: String): IBankMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // Bank
  FBank.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TBankMTB.Initialize;
begin
  FBank := CreateBankMemTable;
end;

class function TBankMTB.Make: IBankMTB;
begin
  Result := Self.Create;
end;

function TBankMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // Bank
  lSObj := SO(FBank.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TBankMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // Bank
  With FBank do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;

    if FieldByName('code').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Código do banco] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
