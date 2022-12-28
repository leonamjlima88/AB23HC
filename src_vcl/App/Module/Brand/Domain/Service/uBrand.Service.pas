unit uBrand.Service;

interface

uses
  uZLMemTable.Interfaces,
  uReq,
  uEither,
  uPageFilter,
  uIndexResult,
  uBrand.DataSet;

type
  IBrandService = Interface
    ['{87DB5C73-D62B-4C23-B730-1CCDEB79D11E}']
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): IBrandDataSet;
    function Store(ABrand: IBrandDataSet): Either<String, IBrandDataSet>;
    function Update(ABrand: IBrandDataSet; AId: Int64): Either<String, IBrandDataSet>;
  end;

  TBrandService = class(TInterfacedObject, IBrandService)
  private
    FRes: IRes;
  public
    class function Make: IBrandService;
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): IBrandDataSet;
    function Store(ABrand: IBrandDataSet): Either<String, IBrandDataSet>;
    function Update(ABrand: IBrandDataSet; AId: Int64): Either<String, IBrandDataSet>;
    function CreateMemTableStructureForIndex: IZLMemTable;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  Data.DB,
  uMemTable.Factory,
  Vcl.Dialogs,
  uHlp,
  uApplication.Types;

const
  RESOURCE = '/brands/';

{ TBrandService }

function TBrandService.CreateMemTableStructureForIndex: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                     ftLargeint)
    .AddField('name',                   ftString, 100)
    .AddField('created_at',             ftDateTime)
    .AddField('updated_at',             ftDateTime)
    .AddField('created_by_acl_user_id', ftLargeint)
    .AddField('updated_by_acl_user_id', ftLargeint)
    .AddField('created_by_acl_user_name', ftString, 100)
    .AddField('updated_by_acl_user_name', ftString, 100)
    .CreateDataSet
    .Active(True);
end;

function TBrandService.Delete(AId: Int64): Boolean;
begin
  // Efetuar requisi��o
  TReq.Make(RESOURCE+AId.ToString).Execute(rtDelete);
  Result := True;
end;

function TBrandService.Index(APageFilter: IPageFilter): IIndexResult;
var
  lIndexResult: IIndexResult;
  lSObj: ISuperObject;
begin
  // Efetuar requisi��o
  FRes := TReq
    .Make      (RESOURCE+'index', APageFilter.ToJsonString)
    .AddHeader (IF_NONE_MATCH,    APageFilter.LastIndexResult.ETag)
    .Execute   (rtPost);

  // N�o ocorreu altera��o desde a ultima requisi��o
  if (FRes.StatusCode = HTTP_NOT_MODIFIED) then
  begin
    Result := APageFilter.LastIndexResult.ETagChanged(False);
    Exit;
  end;

  // Falha na requisi��o
  if not (FRes.StatusCode = HTTP_OK) then
    raise Exception.Create(SO(FRes.Content).S['message']);

  // Parse
  lSObj  := SO(FRes.Content);
  Result := TIndexResult.Make
    .Data                   (CreateMemTableStructureForIndex.FromJsonString(lSObj.O['data'].A['result'].AsJSON))
    .CurrentPage            (lSObj.O['data'].O['meta'].I['current_page'])
    .CurrentPageRecordCount (lSObj.O['data'].O['meta'].I['current_page_record_count'])
    .LastPageNumber         (lSObj.O['data'].O['meta'].I['last_page_number'])
    .AllPagesRecordCount    (lSObj.O['data'].O['meta'].I['all_pages_record_count'])
    .LimitPerPage           (lSObj.O['data'].O['meta'].I['limit_per_page'])
    .NavPrior               (lSObj.O['data'].O['meta'].B['nav_prior'])
    .NavNext                (lSObj.O['data'].O['meta'].B['nav_next'])
    .NavFirst               (lSObj.O['data'].O['meta'].B['nav_first'])
    .NavLast                (lSObj.O['data'].O['meta'].B['nav_last'])
    .ETag                   (THlp.ExtractFromHeader('etag', FRes.Headers))
end;

class function TBrandService.Make: IBrandService;
begin
  Result := Self.Create;
end;

function TBrandService.Show(AId: Int64): IBrandDataSet;
var
  lSObj: ISuperObject;
begin
  Result := nil;

  // Efetuar requisi��o
  FRes := TReq.Make(RESOURCE+AId.ToString).Execute(rtGet);

  // Falha na requisi��o
  if (FRes.StatusCode = HTTP_NOT_FOUND) then
    Exit;

  if not (FRes.StatusCode = HTTP_OK) then
    raise Exception.Create(SO(FRes.Content).S['message']);

  // Retornar registro localizado
  lSObj  := SO(FRes.Content);
  Result := TBrandDataSet.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TBrandService.Store(ABrand: IBrandDataSet): Either<String, IBrandDataSet>;
var
  lErrors: String;
  lSObj: ISuperObject;
begin
  // Validar antes de Incluir
  lErrors := ABrand.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisi��o
  FRes := TReq.Make(RESOURCE, ABrand.ToJsonString).Execute(rtPost);

  // Falha na requisi��o
  if not (FRes.StatusCode = HTTP_CREATED) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro incluso
  lSObj  := SO(FRes.Content);
  Result := TBrandDataSet.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TBrandService.Update(ABrand: IBrandDataSet; AId: Int64): Either<String, IBrandDataSet>;
var
  lErrors: String;
  lSObj: ISuperObject;
begin
  // Validar antes de Atualizar
  lErrors := ABrand.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisi��o
  FRes := TReq.Make(RESOURCE+AId.ToString, ABrand.ToJsonString).Execute(rtPut);

  // Falha na requisi��o
  if not (FRes.StatusCode = HTTP_OK) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro atualizado
  lSObj  := SO(FRes.Content);
  Result := TBrandDataSet.Make.FromJsonString(lSObj.O['data'].AsJSON);

end;

end.
