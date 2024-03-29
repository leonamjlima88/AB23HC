unit uBase.Repository;

interface

uses
  uBase.Repository.Interfaces,
  uZLConnection.Interfaces,
  uPageFilter,
  uIndexResult,
  uBase.Entity,
  uBase.SQLBuilder.Interfaces,
  Data.DB,
  uSelectWithFilter;

type
  TBaseRepository = class abstract (TInterfacedObject, IBaseRepository)
  protected
    FConn: IZLConnection;
    FSQLBuilder: IBaseSQLBuilder;
    function DataSetToEntity(ADtsBrand: TDataSet): TBaseEntity; virtual; abstract;
    procedure Validate(AEntity: TBaseEntity); virtual; abstract;
  public
    function Conn: IZLConnection;
    function Delete(AId: Int64; ATenantId: Int64 = 0): Boolean; virtual;
    function ShowById(AId: Int64; ATenantId: Int64 = 0): TBaseEntity; virtual;
    function Store(AEntity: TBaseEntity): Int64; virtual;
    function Update(AEntity: TBaseEntity; AId: Int64): Boolean; virtual;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; virtual; abstract;
    function Index(APageFilter: IPageFilter): IIndexResult; virtual;
  end;

implementation

uses
  uZLQry.Interfaces,
  System.SysUtils,
  System.Math;

{ TBaseRepository }

function TBaseRepository.Conn: IZLConnection;
begin
  Result := FConn;
end;

function TBaseRepository.Delete(AId, ATenantId: Int64): Boolean;
begin
  FConn.MakeQry.ExecSQL(FSQLBuilder.DeleteById(AId, ATenantId));
  Result := True;
end;

function TBaseRepository.Index(APageFilter: IPageFilter): IIndexResult;
var
  lOutPut: TOutPutSelectAllFilter;
  lSQLPaginate, lSQLWithoutPaginate: String;
  lAllPagesRecordCount, lCurrentPageRecordCount, lLastPageNumber: Integer;
  lQry: IZLQry;
begin
  Result := TIndexResult.Make;
  lQry   := FConn.MakeQry;

  // SQL com pagina��o e sem pagina��o
  lOutPut             := SelectAllWithFilter(APageFilter);
  lSQLPaginate        := lOutPut.SQL;
  lSQLWithoutPaginate := lOutPut.SQLWithoutPaginate;

  // Executar sql com pagina��o
  lQry.Open(lSQLPaginate);
  Result.Data.FromDataSet(lQry.DataSet);
  lCurrentPageRecordCount := Result.Data.DataSet.RecordCount;

  if Assigned(APageFilter) then
  begin
    lSQLWithoutPaginate := 'select count(*) ' + copy(lSQLWithoutPaginate, Pos('from', lSQLWithoutPaginate));
    lSQLWithoutPaginate := StringReplace(lSQLWithoutPaginate, copy(lSQLWithoutPaginate, Pos('order by', lSQLWithoutPaginate)), '', [rfReplaceAll]);
    lQry.Open(lSQLWithoutPaginate);
    lAllPagesRecordCount := lQry.DataSet.Fields[0].AsLargeInt;
    lLastPageNumber := 1;
    if (APageFilter.LimitPerPage > 0) then
      lLastPageNumber := ceil(lAllPagesRecordCount/APageFilter.LimitPerPage);

    // Metadados
    Result.CurrentPage        (APageFilter.CurrentPage)
      .CurrentPageRecordCount (lCurrentPageRecordCount)
      .LastPageNumber         (lLastPageNumber)
      .AllPagesRecordCount    (lAllPagesRecordCount)
      .LimitPerPage           (APageFilter.LimitPerPage)
      .NavFirst               (APageFilter.CurrentPage > 1)
      .NavPrior               (APageFilter.CurrentPage > 1)
      .NavNext                (not (APageFilter.CurrentPage = lLastPageNumber))
      .NavLast                (not (APageFilter.CurrentPage = lLastPageNumber));
  end;
end;

function TBaseRepository.ShowById(AId, ATenantId: Int64): TBaseEntity;
begin
  Result := nil;
  With FConn.MakeQry.Open(FSQLBuilder.SelectById(AId, ATenantId)) do
  begin
    if DataSet.IsEmpty then Exit;
    Result := DataSetToEntity(DataSet);
  end;
end;

function TBaseRepository.Store(AEntity: TBaseEntity): Int64;
begin
  Validate(AEntity);
  Result := FConn.MakeQry
    .ExecSQL (FSQLBuilder.InsertInto(AEntity))
    .Open    (FSQLBuilder.LastInsertId)
    .DataSet.Fields[0].AsLargeInt;
end;

function TBaseRepository.Update(AEntity: TBaseEntity; AId: Int64): Boolean;
begin
  Validate(AEntity);
  FConn.MakeQry.ExecSQL(FSQLBuilder.Update(AEntity, AId));
  Result := True;
end;

end.
