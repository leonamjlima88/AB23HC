unit uBrand.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IBrandMTB = Interface(IEntityMemTable)
    ['{8B377CE0-5BFD-4632-91FA-2E8C56B6E668}']
    function  Brand: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IBrandMTB;
    function  ToJsonString: String;
    function  CreateBrandIndexMemTable: IZLMemTable;
  end;

  TBrandMTB = class(TInterfacedObject, IBrandMTB)
  private
    FBrand: IZLMemTable;

    // Brand
    procedure BrandAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IBrandMTB;

    // Brand
    function  Brand: IZLMemTable;
    function  FromJsonString(AJsonString: String): IBrandMTB;
    function  ToJsonString: String;
    function  CreateBrandMemTable: IZLMemTable;
    function  CreateBrandIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TBrandMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TBrandMTB.Brand: IZLMemTable;
begin
  Result := FBrand;
end;

procedure TBrandMTB.BrandAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TBrandMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TBrandMTB.CreateBrandIndexMemTable: IZLMemTable;
begin
  Result := CreateBrandMemTable;
end;

function TBrandMTB.CreateBrandMemTable: IZLMemTable;
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
    AfterInsert := BrandAfterInsert;
  end;
end;

function TBrandMTB.FromJsonString(AJsonString: String): IBrandMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // Brand
  FBrand.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TBrandMTB.Initialize;
begin
  FBrand := CreateBrandMemTable;
end;

class function TBrandMTB.Make: IBrandMTB;
begin
  Result := Self.Create;
end;

function TBrandMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // Brand
  lSObj := SO(FBrand.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TBrandMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // Brand
  With FBrand do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
