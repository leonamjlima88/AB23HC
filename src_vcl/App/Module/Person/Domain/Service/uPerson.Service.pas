unit uPerson.Service;

interface

uses
  uZLMemTable.Interfaces,
  uReq,
  uEither,
  uPageFilter,
  uIndexResult,
  uPerson.MemTable;

type
  IPersonService = Interface
    ['{0172D343-3AA2-4885-A989-FA1656BA5B36}']
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): IPersonMemTable;
    function Store(APerson: IPersonMemTable): Either<String, IPersonMemTable>;
    function Update(APerson: IPersonMemTable; AId: Int64): Either<String, IPersonMemTable>;
  end;

  TPersonService = class(TInterfacedObject, IPersonService)
  private
    FRes: IRes;
  public
    class function Make: IPersonService;
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): IPersonMemTable;
    function Store(APerson: IPersonMemTable): Either<String, IPersonMemTable>;
    function Update(APerson: IPersonMemTable; AId: Int64): Either<String, IPersonMemTable>;
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
  RESOURCE = '/persons/';

{ TPersonService }

function TPersonService.CreateMemTableStructureForIndex: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                     ftLargeint)
    .AddField('name',                   ftString, 100)
    .AddField('alias_name',             ftString, 100)
    .AddField('is_customer',            ftSmallint)
    .AddField('created_at',             ftDateTime)
    .AddField('updated_at',             ftDateTime)
    .AddField('created_by_acl_user_id', ftLargeint)
    .AddField('updated_by_acl_user_id', ftLargeint)
    .AddField('created_by_acl_user_name', ftString, 100)
    .AddField('updated_by_acl_user_name', ftString, 100)
    .CreateDataSet
    .Active(True);
end;

function TPersonService.Delete(AId: Int64): Boolean;
begin
  // Efetuar requisição
  TReq.Make(RESOURCE+AId.ToString).Execute(rtDelete);
  Result := True;
end;

function TPersonService.Index(APageFilter: IPageFilter): IIndexResult;
var
  lIndexResult: IIndexResult;
  lSObj: ISuperObject;
begin
  // Efetuar requisição
  FRes := TReq
    .Make      (RESOURCE+'index', APageFilter.ToJsonString)
    .AddHeader (IF_NONE_MATCH,    APageFilter.LastIndexResult.ETag)
    .Execute   (rtPost);

  // Não ocorreu alteração desde a ultima requisição
  if (FRes.StatusCode = HTTP_NOT_MODIFIED) then
  begin
    Result := APageFilter.LastIndexResult.ETagChanged(False);
    Exit;
  end;

  // Falha na requisição
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

class function TPersonService.Make: IPersonService;
begin
  Result := Self.Create;
end;

function TPersonService.Show(AId: Int64): IPersonMemTable;
var
  lSObj: ISuperObject;
begin
  Result := nil;

  // Efetuar requisição
  FRes := TReq.Make(RESOURCE+AId.ToString).Execute(rtGet);

  // Falha na requisição
  if (FRes.StatusCode = HTTP_NOT_FOUND) then
    Exit;

  if not (FRes.StatusCode = HTTP_OK) then
    raise Exception.Create(SO(FRes.Content).S['message']);

  // Retornar registro localizado
  lSObj  := SO(FRes.Content);
  Result := TPersonMemTable.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TPersonService.Store(APerson: IPersonMemTable): Either<String, IPersonMemTable>;
var
  lErrors: String;
  lSObj: ISuperObject;
begin
  // Validar antes de Incluir
  lErrors := APerson.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisição
  FRes := TReq.Make(RESOURCE, APerson.ToJsonString).Execute(rtPost);

  // Falha na requisição
  if not (FRes.StatusCode = HTTP_CREATED) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro incluso
  lSObj  := SO(FRes.Content);
  Result := TPersonMemTable.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TPersonService.Update(APerson: IPersonMemTable; AId: Int64): Either<String, IPersonMemTable>;
var
  lErrors: String;
  lSObj: ISuperObject;
begin
  // Validar antes de Atualizar
  lErrors := APerson.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisição
  FRes := TReq.Make(RESOURCE+AId.ToString, APerson.ToJsonString).Execute(rtPut);

  // Falha na requisição
  if not (FRes.StatusCode = HTTP_OK) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro atualizado
  lSObj  := SO(FRes.Content);
  Result := TPersonMemTable.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

end.
