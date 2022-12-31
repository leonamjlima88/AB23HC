unit uUnit.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  IUnitMTB = Interface(IEntityMemTable)
    ['{5362E701-610B-49AD-8A22-D8A81B60F5B2}']
    function  &Unit: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): IUnitMTB;
    function  ToJsonString: String;
    function  CreateUnitIndexMemTable: IZLMemTable;
  end;

  TUnitMTB = class(TInterfacedObject, IUnitMTB)
  private
    FUnit: IZLMemTable;

    // Unit
    procedure UnitAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: IUnitMTB;

    // Unit
    function  &Unit: IZLMemTable;
    function  FromJsonString(AJsonString: String): IUnitMTB;
    function  ToJsonString: String;
    function  CreateUnitMemTable: IZLMemTable;
    function  CreateUnitIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TUnitMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TUnitMTB.&Unit: IZLMemTable;
begin
  Result := FUnit;
end;

procedure TUnitMTB.UnitAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TUnitMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TUnitMTB.CreateUnitIndexMemTable: IZLMemTable;
begin
  Result := CreateUnitMemTable;
end;

function TUnitMTB.CreateUnitMemTable: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 10)
    .AddField('description',              ftString, 100)
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
    AfterInsert := UnitAfterInsert;
  end;
end;

function TUnitMTB.FromJsonString(AJsonString: String): IUnitMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // Unit
  FUnit.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TUnitMTB.Initialize;
begin
  FUnit := CreateUnitMemTable;
end;

class function TUnitMTB.Make: IUnitMTB;
begin
  Result := Self.Create;
end;

function TUnitMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // Unit
  lSObj := SO(FUnit.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TUnitMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // Unit
  With FUnit do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
