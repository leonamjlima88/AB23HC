unit uCFOP.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  ICFOPMTB = Interface(IEntityMemTable)
    ['{0E764038-A1E9-4824-B440-180A082F7DE1}']
    function  CFOP: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): ICFOPMTB;
    function  ToJsonString: String;
    function  CreateCFOPIndexMemTable: IZLMemTable;
  end;

  TCFOPMTB = class(TInterfacedObject, ICFOPMTB)
  private
    FCFOP: IZLMemTable;

    // CFOP
    procedure CFOPAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: ICFOPMTB;

    // CFOP
    function  CFOP: IZLMemTable;
    function  FromJsonString(AJsonString: String): ICFOPMTB;
    function  ToJsonString: String;
    function  CreateCFOPMemTable: IZLMemTable;
    function  CreateCFOPIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TCFOPMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TCFOPMTB.CFOP: IZLMemTable;
begin
  Result := FCFOP;
end;

procedure TCFOPMTB.CFOPAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TCFOPMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TCFOPMTB.CreateCFOPIndexMemTable: IZLMemTable;
begin
  Result := CreateCFOPMemTable;
end;

function TCFOPMTB.CreateCFOPMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 100)
    .AddField('code',                     ftString, 10)
    .AddField('operation_type',           ftSmallint)
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
    AfterInsert := CFOPAfterInsert;
  end;
end;

function TCFOPMTB.FromJsonString(AJsonString: String): ICFOPMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // CFOP
  FCFOP.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TCFOPMTB.Initialize;
begin
  FCFOP := CreateCFOPMemTable;
end;

class function TCFOPMTB.Make: ICFOPMTB;
begin
  Result := Self.Create;
end;

function TCFOPMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // CFOP
  lSObj := SO(FCFOP.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TCFOPMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // CFOP
  With FCFOP do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;

    if FieldByName('code').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Código do CFOP] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
