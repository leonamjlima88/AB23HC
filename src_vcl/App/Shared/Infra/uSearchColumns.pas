unit uSearchColumns;

interface

uses
  System.Generics.Collections,
  System.Classes,
  System.SysUtils;

type
  TSearchColumn = class
  private
    FFieldName: string;
    FDisplayName: string;
    FCustomSearch: boolean;
  public
    class function Make: TSearchColumn;

    function FieldName: string; overload;
    function FieldName(AValue: string): TSearchColumn; overload;

    function DisplayName: string; overload;
    function DisplayName(AValue: string): TSearchColumn; overload;

    function CustomSearch: boolean; overload;
    function CustomSearch(AValue: boolean): TSearchColumn; overload;
  end;

  ISearchColumns = interface
    ['{3B555C50-9218-4F91-A15B-A01A27BEBF8B}']

    function Columns: TObjectList<TSearchColumn>;
    function AddColumn(AFieldName: String; ADisplayName: String; ACustomSearch: Boolean): ISearchColumns;
    function LoadStringsWithDisplayName(AStrings: TStrings; AShowCustomSearch: Boolean = False): ISearchColumns;

    function LabelForCustomSearch: String; overload;
    function LabelForCustomSearch(AValue: String): ISearchColumns overload;
  end;

  TSearchColumns = class(TInterfacedObject, ISearchColumns)
  private
    FColumns: TObjectList<TSearchColumn>;
    FLabelForCustomSearch: String;
  public
    constructor Create;
    destructor Destroy; override;
    class function Make: ISearchColumns;

    function Columns: TObjectList<TSearchColumn>;
    function AddColumn(AFieldName: String; ADisplayName: String; ACustomSearch: Boolean): ISearchColumns;
    function LoadStringsWithDisplayName(AStrings: TStrings; AShowCustomSearch: Boolean = False): ISearchColumns;

    function LabelForCustomSearch: String; overload;
    function LabelForCustomSearch(AValue: String): ISearchColumns overload;
  end;

implementation

{ TSearchColumn }

function TSearchColumns.AddColumn(AFieldName: String; ADisplayName: String; ACustomSearch: Boolean): ISearchColumns;
begin
  Result := Self;

  FColumns.Add(
    TSearchColumn.Make
      .FieldName(AFieldName)
      .DisplayName(ADisplayName)
      .CustomSearch(ACustomSearch)
  );
end;

function TSearchColumns.Columns: TObjectList<TSearchColumn>;
begin
  Result := FColumns;
end;

constructor TSearchColumns.Create;
begin
  FColumns := TObjectList<TSearchColumn>.Create;
end;

destructor TSearchColumns.Destroy;
begin
  FColumns.Free;
  inherited;
end;

function TSearchColumns.LabelForCustomSearch(AValue: String): ISearchColumns;
begin
  Result := Self;
  FLabelForCustomSearch := AValue;
end;

function TSearchColumns.LabelForCustomSearch: String;
begin
  Result := FLabelForCustomSearch;
end;

function TSearchColumns.LoadStringsWithDisplayName(AStrings: TStrings; AShowCustomSearch: Boolean): ISearchColumns;
var
  lI: Integer;
begin
  Result := Self;

  AStrings.Clear;
  if AShowCustomSearch then
    AStrings.Add(FLabelForCustomSearch);

  for lI := 0 to Pred(FColumns.Count) do
    AStrings.Add(FColumns.Items[lI].DisplayName);
end;

class function TSearchColumns.Make: ISearchColumns;
begin
  Result := Self.Create;
end;

{ TSearchColumn }

function TSearchColumn.CustomSearch(AValue: boolean): TSearchColumn;
begin
  Result := Self;
  FCustomSearch := AValue;
end;

function TSearchColumn.CustomSearch: boolean;
begin
  Result := FCustomSearch;
end;

function TSearchColumn.DisplayName: string;
begin
  Result := FDisplayName;
end;

function TSearchColumn.DisplayName(AValue: string): TSearchColumn;
begin
  Result := Self;
  FDisplayName := AValue;
end;

function TSearchColumn.FieldName(AValue: string): TSearchColumn;
begin
  Result := Self;
  FFieldName := AValue;
end;

function TSearchColumn.FieldName: string;
begin
  Result := FFieldName;
end;

class function TSearchColumn.Make: TSearchColumn;
begin
  Result := Self.Create;
end;

end.

