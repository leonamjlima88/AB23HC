unit uNCM.Service;

interface

uses
  uZLMemTable.Interfaces,
  uReq,
  uEither,
  uPageFilter,
  uIndexResult,
  uNCM.MTB;

type
  INCMService = Interface
    ['{B2810914-C93B-45FE-917C-681FBE44F4B4}']
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): INCMMTB;
    function Store(ANCM: INCMMTB): Either<String, INCMMTB>;
    function Update(ANCM: INCMMTB; AId: Int64): Either<String, INCMMTB>;
  end;

  TNCMService = class(TInterfacedObject, INCMService)
  private
    FRes: IRes;
  public
    class function Make: INCMService;
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): INCMMTB;
    function Store(ANCM: INCMMTB): Either<String, INCMMTB>;
    function Update(ANCM: INCMMTB; AId: Int64): Either<String, INCMMTB>;
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
  RESOURCE = '/ncms/';

{ TNCMService }

function TNCMService.Delete(AId: Int64): Boolean;
begin
  // Efetuar requisi��o
  TReq.Make(RESOURCE+AId.ToString).Execute(rtDelete);
  Result := True;
end;

function TNCMService.Index(APageFilter: IPageFilter): IIndexResult;
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
    .Data                   (TNCMMTB.Make.CreateNCMIndexMemTable.FromJsonString(lSObj.O['data'].A['result'].AsJSON))
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

class function TNCMService.Make: INCMService;
begin
  Result := Self.Create;
end;

function TNCMService.Show(AId: Int64): INCMMTB;
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
  Result := TNCMMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TNCMService.Store(ANCM: INCMMTB): Either<String, INCMMTB>;
var
  lErrors: String;
  lSObj: ISuperObject;
  lAux: String;
begin
  // Validar antes de Incluir
  lErrors := ANCM.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisi��o
  FRes := TReq.Make(RESOURCE, ANCM.ToJsonString).Execute(rtPost);

  // Falha na requisi��o
  if not (FRes.StatusCode = HTTP_CREATED) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro incluso
  lSObj  := SO(FRes.Content);
  Result := TNCMMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TNCMService.Update(ANCM: INCMMTB; AId: Int64): Either<String, INCMMTB>;
var
  lErrors: String;
  lSObj: ISuperObject;
begin
  // Validar antes de Atualizar
  lErrors := ANCM.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisi��o
  FRes := TReq.Make(RESOURCE+AId.ToString, ANCM.ToJsonString).Execute(rtPut);

  // Falha na requisi��o
  if not (FRes.StatusCode = HTTP_OK) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro atualizado
  lSObj  := SO(FRes.Content);
  Result := TNCMMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

end.
