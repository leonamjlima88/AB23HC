unit uAppParam.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IAppParamMTB = Interface(IEntityMemTable)
    ['{39323B8E-B4F5-4485-8AA6-B47B4AD8AD95}']
    function  AppParam: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IAppParamMTB;
    function  ToJsonString: String;
    function  CreateAppParamIndexMemTable: IZLMemTable;
  end;

  TAppParamMTB = class(TInterfacedObject, IAppParamMTB)
  private
    FAppParam: IZLMemTable;

    // AppParam
    procedure AppParamAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IAppParamMTB;

    // AppParam
    function  AppParam: IZLMemTable;
    function  FromJsonString(AJsonString: String): IAppParamMTB;
    function  ToJsonString: String;
    function  CreateAppParamMemTable: IZLMemTable;
    function  CreateAppParamIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TAppParamMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TAppParamMTB.AppParam: IZLMemTable;
begin
  Result := FAppParam;
end;

procedure TAppParamMTB.AppParamAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TAppParamMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TAppParamMTB.CreateAppParamIndexMemTable: IZLMemTable;
begin
  Result := CreateAppParamMemTable;
end;

function TAppParamMTB.CreateAppParamMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',          ftLargeint)
    .AddField('acl_role_id', ftLargeint)
    .AddField('group_name',  ftString, 255)
    .AddField('title',       ftString, 255)
    .AddField('value',       ftString, 5000)
    .CreateDataSet
  .Active(True);

  // Formatar Dataset
  THlp.FormatDataSet(Result.DataSet);

  // Eventos
  With Result.DataSet do
  begin
    AfterInsert := AppParamAfterInsert;
  end;
end;

function TAppParamMTB.FromJsonString(AJsonString: String): IAppParamMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // AppParam
  FAppParam.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TAppParamMTB.Initialize;
begin
  FAppParam := CreateAppParamMemTable;
end;

class function TAppParamMTB.Make: IAppParamMTB;
begin
  Result := Self.Create;
end;

function TAppParamMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // AppParam
  lSObj := SO(FAppParam.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TAppParamMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // AppParam
  With FAppParam do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('group_name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Grupo do parâmetro] é obrigatório' + #13;

    if FieldByName('title').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome do parâmetro] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
