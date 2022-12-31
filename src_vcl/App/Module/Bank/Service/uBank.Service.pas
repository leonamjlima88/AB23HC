unit uBank.Service;

interface

uses
  uZLMemTable.Interfaces,
  uReq,
  uEither,
  uPageFilter,
  uIndexResult,
  uBank.MTB;

type
  IBankService = Interface
    ['{C3D3D153-5992-49DE-8F01-D0E128F686C2}']
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): IBankMTB;
    function Store(ABank: IBankMTB): Either<String, IBankMTB>;
    function Update(ABank: IBankMTB; AId: Int64): Either<String, IBankMTB>;
  end;

  TBankService = class(TInterfacedObject, IBankService)
  private
    FRes: IRes;
  public
    class function Make: IBankService;
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): IBankMTB;
    function Store(ABank: IBankMTB): Either<String, IBankMTB>;
    function Update(ABank: IBankMTB; AId: Int64): Either<String, IBankMTB>;
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
  RESOURCE = '/banks/';

{ TBankService }

function TBankService.Delete(AId: Int64): Boolean;
begin
  // Efetuar requisição
  TReq.Make(RESOURCE+AId.ToString).Execute(rtDelete);
  Result := True;
end;

function TBankService.Index(APageFilter: IPageFilter): IIndexResult;
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
    .Data                   (TBankMTB.Make.CreateBankIndexMemTable.FromJsonString(lSObj.O['data'].A['result'].AsJSON))
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

class function TBankService.Make: IBankService;
begin
  Result := Self.Create;
end;

function TBankService.Show(AId: Int64): IBankMTB;
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
  Result := TBankMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TBankService.Store(ABank: IBankMTB): Either<String, IBankMTB>;
var
  lErrors: String;
  lSObj: ISuperObject;
  lAux: String;
begin
  // Validar antes de Incluir
  lErrors := ABank.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisição
  FRes := TReq.Make(RESOURCE, ABank.ToJsonString).Execute(rtPost);

  // Falha na requisição
  if not (FRes.StatusCode = HTTP_CREATED) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro incluso
  lSObj  := SO(FRes.Content);
  Result := TBankMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TBankService.Update(ABank: IBankMTB; AId: Int64): Either<String, IBankMTB>;
var
  lErrors: String;
  lSObj: ISuperObject;
begin
  // Validar antes de Atualizar
  lErrors := ABank.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisição
  FRes := TReq.Make(RESOURCE+AId.ToString, ABank.ToJsonString).Execute(rtPut);

  // Falha na requisição
  if not (FRes.StatusCode = HTTP_OK) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro atualizado
  lSObj  := SO(FRes.Content);
  Result := TBankMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

end.
