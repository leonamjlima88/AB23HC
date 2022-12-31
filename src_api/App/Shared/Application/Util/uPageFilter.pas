unit uPageFilter;

interface

uses
  System.Generics.Collections,
  XSuperObject;

type
  TcondOperator = (
    coNone, coEqual, coGreater, coLess, coGreaterOrEqual, coLessOrEqual, coDifferent,
    coLikeInitial, coLikeFinal, coLikeAnywhere, coLikeEqual, coIsNull
  );
  TcondOperatorHelper = record Helper for TcondOperator
    function GetTypeByName(AName: String): TcondOperator;
  end;

  TFilterWhere = class;
  IPageFilter = interface
    ['{A224A36B-FEEC-4665-9BEF-C05A57267751}']

    function CurrentPage: integer; overload;
    function CurrentPage(AValue: integer): IPageFilter overload;

    function LimitPerPage: integer; overload;
    function LimitPerPage(AValue: integer): IPageFilter overload;

    function Columns: string; overload;
    function Columns(AValue: string): IPageFilter overload;

    function OrderBy: string; overload;
    function OrderBy(AValue: string): IPageFilter; overload;

    function Where: TObjectList<TFilterWhere>;
    function AddWhere(AValue: TFilterWhere): IPageFilter; overload;
    function AddWhere(AFieldName: String; ACondOperator: TcondOperator; AFieldValue: String; AIfDiffEmpty: Boolean = false): IPageFilter; overload;

    function OrWhere: TObjectList<TFilterWhere>;
    function AddOrWhere(AValue: TFilterWhere): IPageFilter; overload;
    function AddOrWhere(AFieldName: String; ACondOperator: TcondOperator; AFieldValue: String; AIfDiffEmpty: Boolean = false): IPageFilter; overload;

    function ClearConditions: IPageFilter;
    function FromSuperObject(ASObj: ISuperObject): IPageFilter;
    function FromJsonString(AJsonString: String): IPageFilter;
  end;

  TFilterWhere = class
  private
    FCondOperator: TCondOperator;
    FFieldName: string;
    FFieldValue: string;
    FIfDiffEmpty: Boolean;
  public
    class function Make: TFilterWhere;

    function FieldName: string; overload;
    function FieldName(AValue: string): TFilterWhere; overload;

    function CondOperator: TCondOperator; overload;
    function CondOperator(AValue: TCondOperator): TFilterWhere; overload;

    function FieldValue: string; overload;
    function FieldValue(AValue: string): TFilterWhere; overload;

    function IfDiffEmpty: boolean; overload;
    function IfDiffEmpty(Avalue: boolean): TFilterWhere; overload;
  end;

  TPageFilter = class(TInterfacedObject, IPageFilter)
  private
    FCurrentPage: integer;
    FLimitPerPage: integer;
    FColumns: string;
    FOrderBy: string;
    FWhere: TObjectList<TFilterWhere>;
    FOrWhere: TObjectList<TFilterWhere>;
  public
    constructor Create;
    destructor Destroy; override;
    class function Make: IPageFilter;

    function CurrentPage: integer; overload;
    function CurrentPage(AValue: integer): IPageFilter overload;

    function LimitPerPage: integer; overload;
    function LimitPerPage(AValue: integer): IPageFilter overload;

    function Columns: string; overload;
    function Columns(AValue: string): IPageFilter overload;

    function OrderBy: string; overload;
    function OrderBy(AValue: string): IPageFilter; overload;

    function Where: TObjectList<TFilterWhere>;
    function AddWhere(AValue: TFilterWhere): IPageFilter; overload;
    function AddWhere(AFieldName: String; ACondOperator: TcondOperator; AFieldValue: String; AIfDiffEmpty: Boolean = false): IPageFilter; overload;

    function OrWhere: TObjectList<TFilterWhere>;
    function AddOrWhere(AValue: TFilterWhere): IPageFilter; overload;
    function AddOrWhere(AFieldName: String; ACondOperator: TcondOperator; AFieldValue: String; AIfDiffEmpty: Boolean = false): IPageFilter; overload;

    function ClearConditions: IPageFilter;
    function FromSuperObject(ASObj: ISuperObject): IPageFilter;
    function FromJsonString(AJsonString: String): IPageFilter;
  end;

implementation

uses
  uHlp,
  System.TypInfo,
  System.SysUtils,
  uMyClaims;

{ TPageFilter }

function TPageFilter.Columns: string;
begin
  Result := FColumns;
end;

function TPageFilter.AddOrWhere(AValue: TFilterWhere): IPageFilter;
begin
  Result := Self;
  FOrWhere.Add(Avalue);
end;

function TPageFilter.AddWhere(AValue: TFilterWhere): IPageFilter;
begin
  Result := self;
  FWhere.Add(Avalue);
end;

function TPageFilter.AddOrWhere(AFieldName: String; ACondOperator: TcondOperator; AFieldValue: String; AIfDiffEmpty: Boolean): IPageFilter;
begin
  Result := Self;
  AddOrWhere(
    TFilterWhere.Make
      .fieldName(AFieldName)
      .condOperator(ACondOperator)
      .FieldValue(AFieldValue)
      .IfDiffEmpty(AIfDiffEmpty)
  );
end;

function TPageFilter.AddWhere(AFieldName: String; ACondOperator: TcondOperator; AFieldValue: String; AIfDiffEmpty: Boolean): IPageFilter;
begin
  Result := Self;
  AddWhere(
    TFilterWhere.Make
      .fieldName(AFieldName)
      .condOperator(ACondOperator)
      .FieldValue(AFieldValue)
      .IfDiffEmpty(AIfDiffEmpty)
  );
end;

function TPageFilter.ClearConditions: IPageFilter;
begin
  Result := self;
  FWhere.Clear;
  FOrWhere.Clear;
end;

function TPageFilter.Columns(AValue: string): IPageFilter;
begin
  Result := Self;
  FColumns := AValue;
end;

constructor TPageFilter.Create;
begin
  FWhere   := TObjectList<TFilterWhere>.Create;
  FOrWhere := TObjectList<TFilterWhere>.Create;

  // Valor Default
  FCurrentPage  := 1;
  FLimitPerPage := 50;
end;

function TPageFilter.CurrentPage: integer;
begin
  Result := FCurrentPage;
end;

function TPageFilter.CurrentPage(AValue: integer): IPageFilter;
begin
  Result := Self;
  FCurrentPage := AValue;
end;

destructor TPageFilter.Destroy;
begin
  FWhere.Free;
  FOrWhere.Free;

  inherited;
end;

function TPageFilter.FromJsonString(AJsonString: String): IPageFilter;
begin
  case THlp.BodyIsEmpty(AJsonString) of
    True:  Result := TPageFilter.Make;
    False: Result := TPageFilter.Make.FromSuperObject(SO(AJsonString));
  end;
end;

function TPageFilter.FromSuperObject(ASObj: ISuperObject): IPageFilter;
var
  lI: Integer;
  lWhereArray, lOrWhereArray: ISuperArray;
begin
  Result := Self;

  FCurrentPage  := ASObj['page.current'].AsInteger;
  FLimitPerPage := ASObj['page.limit'].AsInteger;
  FColumns      := ASObj['page.columns'].AsString;
  FOrderBy      := ASObj['filter.order_by'].AsString;
  lWhereArray   := ASObj['filter.where'].AsArray;
  lOrWhereArray := ASObj['filter.or_where'].AsArray;

  if Assigned(lWhereArray) then
  Begin
    for lI := 0 to Pred(lWhereArray.Length) do
    begin
      AddWhere(
        lWhereArray.O[lI]['field_name'].AsString,
        TcondOperator(0).GetTypeByName(lWhereArray.O[lI]['operator'].AsString),
        lWhereArray.O[lI]['field_value'].AsString
      );
    end;
  end;

  if Assigned(lOrWhereArray) then
  Begin
    for lI := 0 to Pred(lOrWhereArray.Length) do
    begin
      AddOrWhere(
        lOrWhereArray.O[lI]['field_name'].AsString,
        TcondOperator(0).GetTypeByName(lOrWhereArray.O[lI]['operator'].AsString),
        lOrWhereArray.O[lI]['field_value'].AsString
      );
    end;
  end;
end;

function TPageFilter.LimitPerPage(AValue: integer): IPageFilter;
begin
  Result := Self;
  FLimitPerPage := AValue;
end;

class function TPageFilter.Make: IPageFilter;
begin
  Result := Self.Create;
end;

function TPageFilter.OrderBy(AValue: string): IPageFilter;
begin
  Result := Self;
  FOrderBy := AValue;
end;

function TPageFilter.OrWhere: TObjectList<TFilterWhere>;
begin
  Result := FOrWhere;
end;

function TPageFilter.Where: TObjectList<TFilterWhere>;
begin
  Result := FWhere;
end;

function TPageFilter.OrderBy: string;
begin
  Result := FOrderBy;
end;

function TPageFilter.LimitPerPage: integer;
begin
  Result := FLimitPerPage;
end;

{ TFilterWhere }

function TFilterWhere.CondOperator: TCondOperator;
begin
  Result := FCondOperator;
end;

function TFilterWhere.CondOperator(AValue: TCondOperator): TFilterWhere;
begin
  Result := self;
  FCondOperator := Avalue;
end;

function TFilterWhere.FieldName(AValue: string): TFilterWhere;
begin
  Result := self;
  FFieldName := Avalue;
end;

function TFilterWhere.FieldName: string;
begin
  Result := FFieldName;
end;

function TFilterWhere.FieldValue(AValue: string): TFilterWhere;
begin
  Result := self;
  FFieldValue := THlp.RemoveAccentedChars(AValue);

  // Evitar erro com data e hora
  if (FFieldValue = '12/30/1899') or (FFieldValue = '  :  :  ') then
    FFieldValue := '';
end;

function TFilterWhere.IfDiffEmpty(Avalue: boolean): TFilterWhere;
begin
  Result := Self;
  FIfDiffEmpty := Avalue;
end;

function TFilterWhere.IfDiffEmpty: boolean;
begin
  Result := FIfDiffEmpty;
end;

function TFilterWhere.FieldValue: string;
begin
  Result := FFieldValue;
end;

class function TFilterWhere.Make: TFilterWhere;
begin
  Result := Self.Create;
end;

{ TcondOperatorHelper }

function TcondOperatorHelper.GetTypeByName(AName: String): TcondOperator;
var
  lItem: TcondOperator;
  lEnumName: String;
begin
  AName := AName.Trim.ToUpper;
  for lItem := Low(TcondOperator) to High(TcondOperator) do
  begin
    lEnumName := GetEnumName(TypeInfo(TcondOperator), Integer(lItem)).Trim.ToUpper;
    if (lEnumName = AName) or (lEnumName = 'CO'+AName) then
      Result := lItem;
  end;
end;

end.
