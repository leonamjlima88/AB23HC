unit uBase.Repository;

interface

uses
  uBase.Repository.Interfaces,
  uConnection.Interfaces,
  uPageFilter,
  uIndexResult,
  uBase.Entity,
  uBase.SQLBuilder.Interfaces,
  Data.DB,
  uSelectWithFilter;

type
  TBaseRepository = class abstract (TInterfacedObject, IBaseRepository)
  protected
    FConn: IConnection;
    FSQLBuilder: IBaseSQLBuilder;
    function DataSetToEntity(ADtsBrand: TDataSet): TBaseEntity; virtual; abstract;
  public
    function Conn: IConnection;
    function Delete(AId: Int64): Boolean;
    function ShowById(AId: Int64): TBaseEntity;
    function Store(AEntity: TBaseEntity): Int64;
    function Update(AEntity: TBaseEntity; AId: Int64): Boolean;
    function SelectAllWithFilter(APageFilter: IPageFilter): TOutPutSelectAllFilter; virtual; abstract;
    function Index(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

uses
  uQry.Interfaces,
  System.SysUtils,
  System.Math;

{ TBaseRepository }

function TBaseRepository.Conn: IConnection;
begin
  Result := FConn;
end;

function TBaseRepository.Delete(AId: Int64): Boolean;
begin
  FConn.MakeQry.ExecSQL(FSQLBuilder.DeleteById(AId));
  Result := True;
end;

function TBaseRepository.Index(APageFilter: IPageFilter): IIndexResult;
var
  lOutPut: TOutPutSelectAllFilter;
  lSQLPaginate, lSQLWithoutPaginate: String;
  lAllPagesRecordCount, lCurrentPageRecordCount, lLastPageNumber: Integer;
  lQry: IQry;
begin
  Result := TIndexResult.Make;
  lQry   := FConn.MakeQry;

  // SQL com paginação e sem paginação
  lOutPut             := SelectAllWithFilter(APageFilter);
  lSQLPaginate        := lOutPut.SQL;
  lSQLWithoutPaginate := lOutPut.SQLWithoutPaginate;

  // Executar sql com paginação
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

function TBaseRepository.ShowById(AId: Int64): TBaseEntity;
begin
  Result := nil;
  With FConn.MakeQry.Open(FSQLBuilder.SelectById(AId)) do
  begin
    if DataSet.IsEmpty then Exit;
    Result := DataSetToEntity(DataSet);
  end;
end;

function TBaseRepository.Store(AEntity: TBaseEntity): Int64;
begin
  Result := FConn.MakeQry
    .ExecSQL (FSQLBuilder.InsertInto(AEntity))
    .Open    (FSQLBuilder.LastInsertId)
    .DataSet.Fields[0].AsLargeInt;
end;

function TBaseRepository.Update(AEntity: TBaseEntity; AId: Int64): Boolean;
begin
  FConn.MakeQry.ExecSQL(FSQLBuilder.Update(AEntity, AId));
  Result := True;
end;

end.
