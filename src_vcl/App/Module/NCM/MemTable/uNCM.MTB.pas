unit uNCM.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  INCMMTB = Interface(IEntityMemTable)
    ['{7C49351F-5DA9-46C6-84CF-0A891AC70C1D}']
    function  NCM: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): INCMMTB;
    function  ToJsonString: String;
    function  CreateNCMIndexMemTable: IZLMemTable;
  end;

  TNCMMTB = class(TInterfacedObject, INCMMTB)
  private
    FNCM: IZLMemTable;

    // NCM
    procedure NCMAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: INCMMTB;

    // NCM
    function  NCM: IZLMemTable;
    function  FromJsonString(AJsonString: String): INCMMTB;
    function  ToJsonString: String;
    function  CreateNCMMemTable: IZLMemTable;
    function  CreateNCMIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TNCMMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TNCMMTB.NCM: IZLMemTable;
begin
  Result := FNCM;
end;

procedure TNCMMTB.NCMAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TNCMMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TNCMMTB.CreateNCMIndexMemTable: IZLMemTable;
begin
  Result := CreateNCMMemTable;
end;

function TNCMMTB.CreateNCMMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 255)
    .AddField('ncm',                      ftString, 45)
    .AddField('national_rate',            ftFloat)
    .AddField('imported_rate',            ftFloat)
    .AddField('state_rate',               ftFloat)
    .AddField('municipal_rate',           ftFloat)
    .AddField('cest',                     ftString, 45)
    .AddField('additional_information',   ftString, 5000)
    .AddField('start_of_validity',        ftDate)
    .AddField('end_of_validity',          ftDate)
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
    AfterInsert := NCMAfterInsert;
  end;
end;

function TNCMMTB.FromJsonString(AJsonString: String): INCMMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // NCM
  FNCM.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TNCMMTB.Initialize;
begin
  FNCM := CreateNCMMemTable;
end;

class function TNCMMTB.Make: INCMMTB;
begin
  Result := Self.Create;
end;

function TNCMMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // NCM
  lSObj := SO(FNCM.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TNCMMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // NCM
  With FNCM do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('ncm').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [NCM] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
