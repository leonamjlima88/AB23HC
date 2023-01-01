unit uOperationType.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IOperationTypeMTB = Interface(IEntityMemTable)
    ['{54CF28CF-DD56-482D-8E17-D62729B534B1}']
    function  OperationType: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IOperationTypeMTB;
    function  ToJsonString: String;
    function  CreateOperationTypeIndexMemTable: IZLMemTable;
  end;

  TOperationTypeMTB = class(TInterfacedObject, IOperationTypeMTB)
  private
    FOperationType: IZLMemTable;

    // OperationType
    procedure OperationTypeAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IOperationTypeMTB;

    // OperationType
    function  OperationType: IZLMemTable;
    function  FromJsonString(AJsonString: String): IOperationTypeMTB;
    function  ToJsonString: String;
    function  CreateOperationTypeMemTable: IZLMemTable;
    function  CreateOperationTypeIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TOperationTypeMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TOperationTypeMTB.OperationType: IZLMemTable;
begin
  Result := FOperationType;
end;

procedure TOperationTypeMTB.OperationTypeAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
  DataSet.FieldByName('document_type').AsInteger := 1;
  DataSet.FieldByName('issue_purpose').AsInteger := 1;
end;

constructor TOperationTypeMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TOperationTypeMTB.CreateOperationTypeIndexMemTable: IZLMemTable;
begin
  Result := CreateOperationTypeMemTable;
end;

function TOperationTypeMTB.CreateOperationTypeMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                           ftLargeint)
    .AddField('name',                         ftString, 100)
    .AddField('document_type',                ftSmallint)
    .AddField('issue_purpose',                ftSmallint)
    .AddField('operation_nature_description', ftString, 255)
    .AddField('created_at',                   ftDateTime)
    .AddField('updated_at',                   ftDateTime)
    .AddField('created_by_acl_user_id',       ftLargeint)
    .AddField('created_by_acl_user_name',     ftString, 100)
    .AddField('updated_by_acl_user_id',       ftLargeint)
    .AddField('updated_by_acl_user_name',     ftString, 100)
    .CreateDataSet
  .Active(True);

  // Formatar Dataset
  THlp.FormatDataSet(Result.DataSet);

  // Eventos
  With Result.DataSet do
  begin
    AfterInsert := OperationTypeAfterInsert;
  end;
end;

function TOperationTypeMTB.FromJsonString(AJsonString: String): IOperationTypeMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // OperationType
  FOperationType.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TOperationTypeMTB.Initialize;
begin
  FOperationType := CreateOperationTypeMemTable;
end;

class function TOperationTypeMTB.Make: IOperationTypeMTB;
begin
  Result := Self.Create;
end;

function TOperationTypeMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // OperationType
  lSObj := SO(FOperationType.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TOperationTypeMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // OperationType
  With FOperationType do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;

    if FieldByName('operation_nature_description').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Natureza de operação] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
