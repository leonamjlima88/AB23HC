unit uQry.FireDAC;

interface

uses
  uQry.Interfaces,
  FireDAC.Comp.Client,
  Data.DB;

type
  TQryFireDAC = class(TInterfacedObject, IQry)
  private
    FConnection: TFDConnection;
    FQry: TFDQuery;
    constructor Create(AConnection: TFDConnection);
  public
    class function Make(AConnection: TFDConnection): IQry;
    destructor Destroy; override;

    function Open(ASQL: String): IQry;
    function ExecSQL(ASQL: String): IQry;
    function DataSet: TDataSet;
    function Close: IQry;
    function Locate(AKeyFields, AKeyValues: String): Boolean;
  end;

implementation

uses
  System.SysUtils;

{ TQryFireDAC }

function TQryFireDAC.Close: IQry;
begin
  Result := Self;
  FQry.Close;
end;

constructor TQryFireDAC.Create(AConnection: TFDConnection);
begin
  inherited Create;
  FConnection     := AConnection;
  FQry            := TFDQuery.Create(nil);
  FQry.Connection := FConnection;
end;

function TQryFireDAC.DataSet: TDataSet;
begin
  Result := TDataSet(FQry);
end;

destructor TQryFireDAC.Destroy;
begin
  if Assigned(FQry) then FreeAndNil(FQry);

  inherited;
end;

function TQryFireDAC.ExecSQL(ASQL: String): IQry;
begin
  Result := Self;

  if FQry.Active then
    FQry.Close;

  FQry.ExecSQL(ASQL);
end;

function TQryFireDAC.Locate(AKeyFields, AKeyValues: String): Boolean;
begin
  Result := FQry.Locate(AKeyFields, AKeyValues, []);
end;

class function TQryFireDAC.Make(AConnection: TFDConnection): IQry;
begin
  Result := Self.Create(AConnection);
end;

function TQryFireDAC.Open(ASQL: String): IQry;
begin
  Result := Self;

  if FQry.Active then
    FQry.Close;

  FQry.Open(ASQL);
end;

end.
