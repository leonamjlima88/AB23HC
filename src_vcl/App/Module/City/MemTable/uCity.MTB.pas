unit uCity.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  ICityMTB = Interface(IEntityMemTable)
    ['{670B84EE-15BC-4966-8752-44557D82913E}']
    function  City: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): ICityMTB;
    function  ToJsonString: String;
    function  CreateCityIndexMemTable: IZLMemTable;
  end;

  TCityMTB = class(TInterfacedObject, ICityMTB)
  private
    FCity: IZLMemTable;

    // City
    procedure CityAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: ICityMTB;

    // City
    function  City: IZLMemTable;
    function  FromJsonString(AJsonString: String): ICityMTB;
    function  ToJsonString: String;
    function  CreateCityMemTable: IZLMemTable;
    function  CreateCityIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TCityMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TCityMTB.City: IZLMemTable;
begin
  Result := FCity;
end;

procedure TCityMTB.CityAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TCityMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TCityMTB.CreateCityIndexMemTable: IZLMemTable;
begin
  Result := CreateCityMemTable;
end;

function TCityMTB.CreateCityMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 100)
    .AddField('state',                    ftString, 2)
    .AddField('country',                  ftString, 100)
		.AddField('ibge_code',                ftString, 30)
		.AddField('country_ibge_code',        ftString, 30)
		.AddField('identification',           ftString, 100)
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
    AfterInsert := CityAfterInsert;
  end;
end;

function TCityMTB.FromJsonString(AJsonString: String): ICityMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // City
  FCity.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TCityMTB.Initialize;
begin
  FCity := CreateCityMemTable;
end;

class function TCityMTB.Make: ICityMTB;
begin
  Result := Self.Create;
end;

function TCityMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // City
  lSObj := SO(FCity.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TCityMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // City
  With FCity do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;

    if FieldByName('state').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [UF] é obrigatório' + #13;

    if FieldByName('country').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [País] é obrigatório' + #13;

    if FieldByName('ibge_code').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Código IBGE] é obrigatório' + #13;

    if FieldByName('country_ibge_code').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Código IBGE do País] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
