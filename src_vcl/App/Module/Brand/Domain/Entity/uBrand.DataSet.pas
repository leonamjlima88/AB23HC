unit uBrand.DataSet;

interface

uses
  uZLMemTable.Interfaces;

type
  IBrandDataSet = Interface
    ['{C893B139-99C4-4350-AEB6-4A648E7B9783}']
    function Brand: IZLMemTable;
    function Validate: String;
    function FromJsonString(AJsonString: String): IBrandDataSet;
    function ToJsonString: String;
  end;

  TBrandDataSet = class(TInterfacedObject, IBrandDataSet)
  private
    FBrand: IZLMemTable;
  public
    constructor Create;
    class function Make: IBrandDataSet;

    function Brand: IZLMemTable;
    function FromJsonString(AJsonString: String): IBrandDataSet;
    function ToJsonString: String;

    procedure Initialize;
    function Validate: String;
  end;

implementation

{ TBrandDataSet }

uses
  uMemTable.Factory,
  Data.DB,
  DataSet.Serialize,
  System.SysUtils;

function TBrandDataSet.Brand: IZLMemTable;
begin
  Result := FBrand;
end;

constructor TBrandDataSet.Create;
begin
  inherited Create;
  Initialize;
end;

function TBrandDataSet.FromJsonString(AJsonString: String): IBrandDataSet;
begin
  Result := Self;
  FBrand.DataSet.LoadFromJSON(AJsonString);
end;

procedure TBrandDataSet.Initialize;
begin
  FBrand := TMemTableFactory.Make
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
end;

class function TBrandDataSet.Make: IBrandDataSet;
begin
  Result := Self.Create;
end;

function TBrandDataSet.ToJsonString: String;
begin
  Result := FBrand.DataSet.ToJSONObjectString;
end;

function TBrandDataSet.Validate: String;
var
  lIsInserting: Boolean;
  lErrors: String;
begin
  lIsInserting := FBrand.DataSet.FieldByName('id').AsInteger <= 0;

  if FBrand.DataSet.FieldByName('name').AsString.Trim.IsEmpty then
    lErrors := lErrors + 'O campo [Nome] é obrigatório' + #13;

  Result := lErrors;
end;

end.
