unit uDocument.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IDocumentMTB = Interface(IEntityMemTable)
    ['{1A3B1C8A-C669-4B6E-A157-E1F764F02FE2}']
    function  Document: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IDocumentMTB;
    function  ToJsonString: String;
    function  CreateDocumentIndexMemTable: IZLMemTable;
  end;

  TDocumentMTB = class(TInterfacedObject, IDocumentMTB)
  private
    FDocument: IZLMemTable;

    // Document
    procedure DocumentAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IDocumentMTB;

    // Document
    function  Document: IZLMemTable;
    function  FromJsonString(AJsonString: String): IDocumentMTB;
    function  ToJsonString: String;
    function  CreateDocumentMemTable: IZLMemTable;
    function  CreateDocumentIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TDocumentMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TDocumentMTB.Document: IZLMemTable;
begin
  Result := FDocument;
end;

procedure TDocumentMTB.DocumentAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TDocumentMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TDocumentMTB.CreateDocumentIndexMemTable: IZLMemTable;
begin
  Result := CreateDocumentMemTable;
end;

function TDocumentMTB.CreateDocumentMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 100)
    .AddField('is_release_as_completed',  ftSmallint)
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
    AfterInsert := DocumentAfterInsert;
  end;
end;

function TDocumentMTB.FromJsonString(AJsonString: String): IDocumentMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // Document
  FDocument.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TDocumentMTB.Initialize;
begin
  FDocument := CreateDocumentMemTable;
end;

class function TDocumentMTB.Make: IDocumentMTB;
begin
  Result := Self.Create;
end;

function TDocumentMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // Document
  lSObj := SO(FDocument.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TDocumentMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // Document
  With FDocument do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
