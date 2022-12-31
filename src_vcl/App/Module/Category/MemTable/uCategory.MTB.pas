unit uCategory.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  ICategoryMTB = Interface(IEntityMemTable)
    ['{8AC3FFCF-20A5-4688-9478-382D91A3850D}']
    function  Category: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): ICategoryMTB;
    function  ToJsonString: String;
    function  CreateCategoryIndexMemTable: IZLMemTable;
  end;

  TCategoryMTB = class(TInterfacedObject, ICategoryMTB)
  private
    FCategory: IZLMemTable;

    // Category
    procedure CategoryAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: ICategoryMTB;

    // Category
    function  Category: IZLMemTable;
    function  FromJsonString(AJsonString: String): ICategoryMTB;
    function  ToJsonString: String;
    function  CreateCategoryMemTable: IZLMemTable;
    function  CreateCategoryIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TCategoryMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TCategoryMTB.Category: IZLMemTable;
begin
  Result := FCategory;
end;

procedure TCategoryMTB.CategoryAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TCategoryMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TCategoryMTB.CreateCategoryIndexMemTable: IZLMemTable;
begin
  Result := CreateCategoryMemTable;
end;

function TCategoryMTB.CreateCategoryMemTable: IZLMemTable;
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
    AfterInsert := CategoryAfterInsert;
  end;
end;

function TCategoryMTB.FromJsonString(AJsonString: String): ICategoryMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // Category
  FCategory.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TCategoryMTB.Initialize;
begin
  FCategory := CreateCategoryMemTable;
end;

class function TCategoryMTB.Make: ICategoryMTB;
begin
  Result := Self.Create;
end;

function TCategoryMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // Category
  lSObj := SO(FCategory.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TCategoryMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // Category
  With FCategory do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
