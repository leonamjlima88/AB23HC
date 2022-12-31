unit uSize.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  ISizeMTB = Interface(IEntityMemTable)
    ['{DD2E2697-F3BF-4C41-831B-BCE0D45A66C4}']
    function  Size: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): ISizeMTB;
    function  ToJsonString: String;
    function  CreateSizeIndexMemTable: IZLMemTable;
  end;

  TSizeMTB = class(TInterfacedObject, ISizeMTB)
  private
    FSize: IZLMemTable;

    // Size
    procedure SizeAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: ISizeMTB;

    // Size
    function  Size: IZLMemTable;
    function  FromJsonString(AJsonString: String): ISizeMTB;
    function  ToJsonString: String;
    function  CreateSizeMemTable: IZLMemTable;
    function  CreateSizeIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TSizeMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TSizeMTB.Size: IZLMemTable;
begin
  Result := FSize;
end;

procedure TSizeMTB.SizeAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TSizeMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TSizeMTB.CreateSizeIndexMemTable: IZLMemTable;
begin
  Result := CreateSizeMemTable;
end;

function TSizeMTB.CreateSizeMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 100)
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
    AfterInsert := SizeAfterInsert;
  end;
end;

function TSizeMTB.FromJsonString(AJsonString: String): ISizeMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // Size
  FSize.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TSizeMTB.Initialize;
begin
  FSize := CreateSizeMemTable;
end;

class function TSizeMTB.Make: ISizeMTB;
begin
  Result := Self.Create;
end;

function TSizeMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // Size
  lSObj := SO(FSize.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TSizeMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // Size
  With FSize do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
