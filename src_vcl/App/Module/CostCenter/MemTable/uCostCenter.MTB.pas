unit uCostCenter.MTB;

interface

uses
  uEntity.MemTable.Interfaces,
  uZLMemTable.Interfaces,
  Data.DB;

type
  ICostCenterMTB = Interface(IEntityMemTable)
    ['{BC66EEEB-8D7E-438E-87C1-1FAF9341A08D}']
    function  CostCenter: IZLMemTable;
    function  Validate: String;
    function  FromJsonString(AJsonString: String): ICostCenterMTB;
    function  ToJsonString: String;
    function  CreateCostCenterIndexMemTable: IZLMemTable;
  end;

  TCostCenterMTB = class(TInterfacedObject, ICostCenterMTB)
  private
    FCostCenter: IZLMemTable;

    // CostCenter
    procedure CostCenterAfterInsert(DataSet: TDataSet);
  public
    constructor Create;
    class function Make: ICostCenterMTB;

    // CostCenter
    function  CostCenter: IZLMemTable;
    function  FromJsonString(AJsonString: String): ICostCenterMTB;
    function  ToJsonString: String;
    function  CreateCostCenterMemTable: IZLMemTable;
    function  CreateCostCenterIndexMemTable: IZLMemTable;

    procedure Initialize;
    function  Validate: String;
  end;

implementation

{ TCostCenterMTB }

uses
  uMemTable.Factory,
  DataSet.Serialize,
  System.SysUtils,
  XSuperObject,
  Vcl.Forms,
  uHlp;

function TCostCenterMTB.CostCenter: IZLMemTable;
begin
  Result := FCostCenter;
end;

procedure TCostCenterMTB.CostCenterAfterInsert(DataSet: TDataSet);
begin
  THlp.FillDataSetWithZero(DataSet);
end;

constructor TCostCenterMTB.Create;
begin
  inherited Create;
  Initialize;
end;

function TCostCenterMTB.CreateCostCenterIndexMemTable: IZLMemTable;
begin
  Result := CreateCostCenterMemTable;
end;

function TCostCenterMTB.CreateCostCenterMemTable: IZLMemTable;
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
    AfterInsert := CostCenterAfterInsert;
  end;
end;

function TCostCenterMTB.FromJsonString(AJsonString: String): ICostCenterMTB;
var
  lSObj: ISuperObject;
begin
  Result := Self;
  lSObj  := SO(AJsonString);

  // CostCenter
  FCostCenter.DataSet.LoadFromJSON(lSObj.AsJSON);
end;

procedure TCostCenterMTB.Initialize;
begin
  FCostCenter := CreateCostCenterMemTable;
end;

class function TCostCenterMTB.Make: ICostCenterMTB;
begin
  Result := Self.Create;
end;

function TCostCenterMTB.ToJsonString: String;
var
  lSObj: ISuperObject;
begin
  // CostCenter
  lSObj := SO(FCostCenter.DataSet.ToJSONObjectString);

  // Resultado
  Result := lSObj.AsJSON;
end;

function TCostCenterMTB.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  // CostCenter
  With FCostCenter do
  begin
    lIsInserting := FieldByName('id').AsInteger <= 0;

    if FieldByName('name').AsString.Trim.IsEmpty then
      lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;
  end;

  Result := lErrors;
end;

end.
