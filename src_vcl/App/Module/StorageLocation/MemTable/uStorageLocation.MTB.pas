unit uStorageLocation.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IStorageLocationMTB = Interface(IEntityMemTable)
    ['{7DCD42EA-FA02-426B-8FDB-240E78206AB7}']
    function  StorageLocation: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IStorageLocationMTB;
    function  ToJsonString: String;
    function  CreateStorageLocationIndexMemTable: IZLMemTable;
  end;

  TStorageLocationMTB = class(TInterfacedObject, IStorageLocationMTB)
  private
    FStorageLocation: IZLMemTable;

    // StorageLocation
    procedure StorageLocationAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IStorageLocationMTB;

    // StorageLocation
    function  StorageLocation: IZLMemTable;
    function  FromJsonString(AJsonString: String): IStorageLocationMTB;
    function  ToJsonString: String;
    function  CreateStorageLocationMemTable: IZLMemTable;
    function  CreateStorageLocationIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TStorageLocationMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TStorageLocationMTB.StorageLocation: IZLMemTable;
begin
  Result := FStorageLocation;
end;

procedure TStorageLocationMTB.StorageLocationAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TStorageLocationMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TStorageLocationMTB.CreateStorageLocationIndexMemTable: IZLMemTable;
begin
  Result := CreateStorageLocationMemTable;
end;

function TStorageLocationMTB.CreateStorageLocationMemTable: IZLMemTable;
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
    AfterInsert := StorageLocationAfterInsert;
  end;
end;

function TStorageLocationMTB.FromJsonString(AJsonString: String): IStorageLocationMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // StorageLocation
  FStorageLocation.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TStorageLocationMTB.Initialize;
begin
  FStorageLocation := CreateStorageLocationMemTable;
end;

class function TStorageLocationMTB.Make: IStorageLocationMTB;
begin
  Result := Self.Create;
end;

function TStorageLocationMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // StorageLocation
  lSObj := SO(FStorageLocation.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TStorageLocationMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // StorageLocation
  With FStorageLocation do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
