unit uIndexResult;

interface

uses
  uMemTable.Interfaces,
  XSuperObject;

type
  IIndexResult = interface
    ['{8A8BEA81-BBC2-4812-8941-F71A983C117D}']

    function Data: IMemTable;

    function CurrentPage: Integer; overload;
    function CurrentPage(AValue: Integer): IIndexResult; overload;

    function CurrentPageRecordCount: Integer; overload;
    function CurrentPageRecordCount(AValue: Integer): IIndexResult; overload;

    function LastPageNumber: Integer; overload;
    function LastPageNumber(AValue: Integer): IIndexResult; overload;

    function AllPagesRecordCount: Integer; overload;
    function AllPagesRecordCount(AValue: Integer): IIndexResult; overload;

    function LimitPerPage: Integer; overload;
    function LimitPerPage(AValue: Integer): IIndexResult; overload;

    function NavPrior: Boolean; overload;
    function NavPrior(AValue: Boolean): IIndexResult; overload;

    function NavNext: Boolean; overload;
    function NavNext(AValue: Boolean): IIndexResult; overload;

    function NavFirst: Boolean; overload;
    function NavFirst(AValue: Boolean): IIndexResult; overload;

    function NavLast: Boolean; overload;
    function NavLast(AValue: Boolean): IIndexResult; overload;

    function ToSuperObject: ISuperObject;
  end;

  TIndexResult = class(TInterfacedObject, IIndexResult)
  private
    FData: IMemTable;

    FCurrentPage: Integer;
    FCurrentPageRecordCount: Integer;
    FLastPageNumber: Integer;
    FAllPagesRecordCount: Integer;
    FLimitPerPage: Integer;

    FNavPrior: Boolean;
    FNavNext: Boolean;
    FNavFirst: Boolean;
    FNavLast: Boolean;
  public
    class function Make: IIndexResult;
    constructor Create;
    destructor Destroy; override;

    function Data: IMemTable;

    function CurrentPage: Integer; overload;
    function CurrentPage(AValue: Integer): IIndexResult; overload;

    function CurrentPageRecordCount: Integer; overload;
    function CurrentPageRecordCount(AValue: Integer): IIndexResult; overload;

    function LastPageNumber: Integer; overload;
    function LastPageNumber(AValue: Integer): IIndexResult; overload;

    function AllPagesRecordCount: Integer; overload;
    function AllPagesRecordCount(AValue: Integer): IIndexResult; overload;

    function LimitPerPage: Integer; overload;
    function LimitPerPage(AValue: Integer): IIndexResult; overload;

    function NavPrior: Boolean; overload;
    function NavPrior(AValue: Boolean): IIndexResult; overload;

    function NavNext: Boolean; overload;
    function NavNext(AValue: Boolean): IIndexResult; overload;

    function NavFirst: Boolean; overload;
    function NavFirst(AValue: Boolean): IIndexResult; overload;

    function NavLast: Boolean; overload;
    function NavLast(AValue: Boolean): IIndexResult; overload;

    function ToSuperObject: ISuperObject;
  end;

implementation

uses
  System.SysUtils,
  uMemTable.Factory,
  DataSet.Serialize;

{ TIndexResult }

function TIndexResult.AllPagesRecordCount(AValue: Integer): IIndexResult;
begin
  Result := Self;
  FAllPagesRecordCount := AValue;
end;

function TIndexResult.AllPagesRecordCount: Integer;
begin
  Result := FAllPagesRecordCount;
end;

constructor TIndexResult.Create;
begin
  FData := TMemTableFactory.Make;
end;

function TIndexResult.CurrentPage: Integer;
begin
  Result := FCurrentPage;
end;

function TIndexResult.CurrentPage(AValue: Integer): IIndexResult;
begin
  Result := Self;
  FCurrentPage := AValue;
end;

function TIndexResult.CurrentPageRecordCount: Integer;
begin
  Result := FCurrentPageRecordCount;
end;

function TIndexResult.CurrentPageRecordCount(AValue: Integer): IIndexResult;
begin
  Result := Self;
  FCurrentPageRecordCount := AValue;
end;

destructor TIndexResult.Destroy;
begin
  inherited;
end;

function TIndexResult.Data: IMemTable;
begin
  Result := FData;
end;

function TIndexResult.LastPageNumber(AValue: Integer): IIndexResult;
begin
  Result := Self;
  FLastPageNumber := AValue;
end;

function TIndexResult.LimitPerPage(AValue: Integer): IIndexResult;
begin
  Result := Self;
  FLimitPerPage := AValue;
end;

function TIndexResult.LimitPerPage: Integer;
begin
  Result := FLimitPerPage;
end;

function TIndexResult.LastPageNumber: Integer;
begin
  Result := FLastPageNumber;
end;

class function TIndexResult.Make: IIndexResult;
begin
  Result := Self.Create;
end;

function TIndexResult.NavFirst(AValue: Boolean): IIndexResult;
begin
  Result := Self;
  FNavFirst := AValue;
end;

function TIndexResult.NavFirst: Boolean;
begin
  Result := FNavFirst;
end;

function TIndexResult.NavLast(AValue: Boolean): IIndexResult;
begin
  Result := Self;
  FNavLast := AValue;
end;

function TIndexResult.NavLast: Boolean;
begin
  Result := FNavLast;
end;

function TIndexResult.NavNext(AValue: Boolean): IIndexResult;
begin
  Result := Self;
  FNavNext := AValue;
end;

function TIndexResult.NavNext: Boolean;
begin
  Result := FNavNext;
end;

function TIndexResult.NavPrior(AValue: Boolean): IIndexResult;
begin
  Result := Self;
  FNavPrior := AValue;
end;

function TIndexResult.ToSuperObject: ISuperObject;
begin
  Result := SO;
  Result.A['result'] := SA(FData.DataSet.ToJSONArrayString);
  With Result.O['meta'] do
  begin
    I['current_page']              := FCurrentPage;
    I['current_page_record_count'] := FCurrentPageRecordCount;
    I['last_page_number']          := FLastPageNumber;
    I['all_pages_record_count']    := FAllPagesRecordCount;
    I['limit_per_page']            := FLimitPerPage;
    B['nav_prior']                 := FNavPrior;
    B['nav_next']                  := FNavNext;
    B['nav_first']                 := FNavFirst;
    B['nav_last']                  := FNavLast;
  end;
end;

function TIndexResult.NavPrior: Boolean;
begin
  Result := FNavPrior;
end;

end.

