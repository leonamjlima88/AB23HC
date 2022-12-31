unit uChartOfAccount.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IChartOfAccountMTB = Interface(IEntityMemTable)
    ['{C36B2233-4784-4900-BBCF-C98D7CFC9818}']
    function  ChartOfAccount: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IChartOfAccountMTB;
    function  ToJsonString: String;
    function  CreateChartOfAccountIndexMemTable: IZLMemTable;
  end;

  TChartOfAccountMTB = class(TInterfacedObject, IChartOfAccountMTB)
  private
    FChartOfAccount: IZLMemTable;

    // ChartOfAccount
    procedure ChartOfAccountAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IChartOfAccountMTB;

    // ChartOfAccount
    function  ChartOfAccount: IZLMemTable;
    function  FromJsonString(AJsonString: String): IChartOfAccountMTB;
    function  ToJsonString: String;
    function  CreateChartOfAccountMemTable: IZLMemTable;
    function  CreateChartOfAccountIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TChartOfAccountMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TChartOfAccountMTB.ChartOfAccount: IZLMemTable;
begin
  Result := FChartOfAccount;
end;

procedure TChartOfAccountMTB.ChartOfAccountAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TChartOfAccountMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TChartOfAccountMTB.CreateChartOfAccountIndexMemTable: IZLMemTable;
begin
  Result := CreateChartOfAccountMemTable;
end;

function TChartOfAccountMTB.CreateChartOfAccountMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 100)
    .AddField('hierarchy_code',           ftString, 100)
    .AddField('is_analytical',            ftSmallint)
    .AddField('note',                     ftString, 5000)
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
    AfterInsert := ChartOfAccountAfterInsert;
  end;
end;

function TChartOfAccountMTB.FromJsonString(AJsonString: String): IChartOfAccountMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // ChartOfAccount
  FChartOfAccount.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TChartOfAccountMTB.Initialize;
begin
  FChartOfAccount := CreateChartOfAccountMemTable;
end;

class function TChartOfAccountMTB.Make: IChartOfAccountMTB;
begin
  Result := Self.Create;
end;

function TChartOfAccountMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // ChartOfAccount
  lSObj := SO(FChartOfAccount.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TChartOfAccountMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // ChartOfAccount
  With FChartOfAccount do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;

    if FieldByName('hierarchy_code').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Hierarquia] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
