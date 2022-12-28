unit uPerson.Service;

interface

uses
  uPerson,
  uZLMemTable.Interfaces,
  uReq,
  uEither,
  uPageFilter,
  uIndexResult;

type
  IPersonService = Interface
    ['{87DB5C73-D62B-4C23-B730-1CCDEB79D11E}']
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): TPerson;
    function Store(APerson: TPerson): Either<String, TPerson>;
    function Update(APerson: TPerson; AId: Int64): Either<String, TPerson>;
  end;

  TPersonService = class(TInterfacedObject, IPersonService)
  private
    FRes: IRes;
  public
    class function Make: IPersonService;
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): TPerson;
    function Store(APerson: TPerson): Either<String, TPerson>;
    function Update(APerson: TPerson; AId: Int64): Either<String, TPerson>;
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
    .AddField('id',                       ftLargeint)
    .AddField('name',                     ftString, 100)
    .AddField('alias_name',               ftString, 100)
    .AddField('created_at',               ftDateTime)
    .AddField('updated_at',               ftDateTime)
    .AddField('created_by_acl_user_id',   ftLargeint)
    .AddField('updated_by_acl_user_id',   ftLargeint)
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

function TPersonService.Show(AId: Int64): TPerson;
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
  Result := TPerson.FromJSON(lSObj.O['data']);

  // Tratar campos diferenciados
  Result.created_by_acl_user.id   := lSObj.O['data'].I['created_by_acl_user_id'];
  Result.created_by_acl_user.name := lSObj.O['data'].S['created_by_acl_user_name'];
  Result.updated_by_acl_user.id   := lSObj.O['data'].I['updated_by_acl_user_id'];
  Result.updated_by_acl_user.name := lSObj.O['data'].S['updated_by_acl_user_name'];
end;

function TPersonService.Store(APerson: TPerson): Either<String, TPerson>;
var
  lErrors: String;
begin
  // Validar antes de Incluir
  lErrors := APerson.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisição
  FRes := TReq.Make(RESOURCE, APerson.AsJSON).Execute(rtPost);

  // Falha na requisição
  if not (FRes.StatusCode = HTTP_CREATED) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro incluso
  Result := TPerson.FromJSON(SO(FRes.Content).O['data']);
end;

function TPersonService.Update(APerson: TPerson; AId: Int64): Either<String, TPerson>;
var
  lErrors: String;
begin
  // Validar antes de Atualizar
  APerson.id := AId;
  lErrors   := APerson.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisição
  FRes := TReq.Make(RESOURCE+AId.ToString, APerson.AsJSON).Execute(rtPut);

  // Falha na requisição
  if not (FRes.StatusCode = HTTP_OK) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro atualizado
  Result := TPerson.FromJSON(SO(FRes.Content).O['data']);
end;

end.
