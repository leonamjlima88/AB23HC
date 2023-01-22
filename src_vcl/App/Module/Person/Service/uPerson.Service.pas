unit uPerson.Service;

interface

uses
  uZLMemTable.Interfaces,
  uReq,
  uEither,
  uPageFilter,
  uIndexResult,
  uPerson.MTB,
  uPerson.TypeInput;

type
  IPersonService = Interface
    ['{0172D343-3AA2-4885-A989-FA1656BA5B36}']
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): IPersonMTB;
    function ShowByIdAndPersonType(APersonTypeInput: IPersonTypeInput): IPersonMTB;
    function Store(APerson: IPersonMTB): Either<String, IPersonMTB>;
    function Update(APerson: IPersonMTB; AId: Int64): Either<String, IPersonMTB>;
  end;

  TPersonService = class(TInterfacedObject, IPersonService)
  private
    FRes: IRes;
  public
    class function Make: IPersonService;
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): IPersonMTB;
    function ShowByIdAndPersonType(APersonTypeInput: IPersonTypeInput): IPersonMTB;
    function Store(APerson: IPersonMTB): Either<String, IPersonMTB>;
    function Update(APerson: IPersonMTB; AId: Int64): Either<String, IPersonMTB>;
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
    .Data                   (TPersonMTB.Make.CreatePersonIndexMemTable.FromJsonString(lSObj.O['data'].A['result'].AsJSON))
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

function TPersonService.Show(AId: Int64): IPersonMTB;
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
  Result := TPersonMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TPersonService.ShowByIdAndPersonType(APersonTypeInput: IPersonTypeInput): IPersonMTB;
var
  lSObj: ISuperObject;
begin
  Result := nil;

  // Efetuar requisição
  FRes := TReq.Make(RESOURCE+'show_by_id_and_person_type', APersonTypeInput.ToJsonString).Execute(rtPost);

  // Falha na requisição
  if (FRes.StatusCode = HTTP_NOT_FOUND) then
    Exit;

  if not (FRes.StatusCode = HTTP_OK) then
    raise Exception.Create(SO(FRes.Content).S['message']);

  // Retornar registro localizado
  lSObj  := SO(FRes.Content);
  Result := TPersonMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TPersonService.Store(APerson: IPersonMTB): Either<String, IPersonMTB>;
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
  Result := TPersonMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TPersonService.Update(APerson: IPersonMTB; AId: Int64): Either<String, IPersonMTB>;
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
  Result := TPersonMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

end.
