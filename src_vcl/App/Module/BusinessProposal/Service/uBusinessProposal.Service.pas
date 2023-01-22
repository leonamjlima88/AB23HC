unit uBusinessProposal.Service;

interface

uses
  uZLMemTable.Interfaces,
  uReq,
  uEither,
  uPageFilter,
  uIndexResult,
  uBusinessProposal.MTB;

type
  IBusinessProposalService = Interface
    ['{1C943F61-8E11-4F46-BFC8-9A1B1BF21282}']
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): IBusinessProposalMTB;
    function Store(ABusinessProposal: IBusinessProposalMTB): Either<String, IBusinessProposalMTB>;
    function Update(ABusinessProposal: IBusinessProposalMTB; AId: Int64): Either<String, IBusinessProposalMTB>;
    function ReportById(AId: Int64): IBusinessProposalService;
  end;

  TBusinessProposalService = class(TInterfacedObject, IBusinessProposalService)
  private
    FRes: IRes;
  public
    class function Make: IBusinessProposalService;
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): IBusinessProposalMTB;
    function Store(ABusinessProposal: IBusinessProposalMTB): Either<String, IBusinessProposalMTB>;
    function Update(ABusinessProposal: IBusinessProposalMTB; AId: Int64): Either<String, IBusinessProposalMTB>;
    function ReportById(AId: Int64): IBusinessProposalService;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  Data.DB,
  uMemTable.Factory,
  Vcl.Dialogs,
  uHlp,
  uApplication.Types,
  System.Classes,
  Vcl.Forms,
  ShellApi,
  Winapi.Windows,
  uSmartPointer;

const
  RESOURCE = '/business_proposals/';

{ TBusinessProposalService }

function TBusinessProposalService.Delete(AId: Int64): Boolean;
begin
  // Efetuar requisição
  TReq.Make(RESOURCE+AId.ToString).Execute(rtDelete);
  Result := True;
end;

function TBusinessProposalService.Index(APageFilter: IPageFilter): IIndexResult;
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
    .Data                   (TBusinessProposalMTB.Make.CreateBusinessProposalIndexMemTable.FromJsonString(lSObj.O['data'].A['result'].AsJSON))
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

class function TBusinessProposalService.Make: IBusinessProposalService;
begin
  Result := Self.Create;
end;

function TBusinessProposalService.ReportById(AId: Int64): IBusinessProposalService;
var
  lSObj: ISuperObject;
  lFileStream: Shared<TFileStream>;
  lTempFile: String;
begin
  Result := Self;

  // Efetuar requisição
  FRes := TReq
    .Make(RESOURCE+'report_by_id/'+AId.ToString)
    .AddHeader (CONTENT_TYPE, APPLICATION_PDF)
    .AddHeader (ACCEPT, APPLICATION_PDF)
    .Execute(rtGet);

  // Falha na requisição
  if (FRes.StatusCode = HTTP_NOT_FOUND) then
    Exit;

  if not (FRes.StatusCode = HTTP_OK) then
    raise Exception.Create(SO(FRes.Content).S['message']);

  // Salva a stream em um arquivo temporário
  lTempFile   := ExtractFilePath(Application.ExeName) + TEMP_FOLDER + THlp.createGuid + '.pdf';
  lFileStream := TFileStream.Create(lTempFile, fmCreate);
  lFileStream.Value.CopyFrom(FRes.ContentStream, FRes.ContentStream.Size);

  // Executar arquivo temporário
  ShellExecute(0, 'open', PChar(lFileStream.Value.FileName), nil, nil, SW_SHOWNORMAL);
end;

function TBusinessProposalService.Show(AId: Int64): IBusinessProposalMTB;
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
  Result := TBusinessProposalMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TBusinessProposalService.Store(ABusinessProposal: IBusinessProposalMTB): Either<String, IBusinessProposalMTB>;
var
  lErrors: String;
  lSObj: ISuperObject;
begin
  // Validar antes de Incluir
  lErrors := ABusinessProposal.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisição
  FRes := TReq.Make(RESOURCE, ABusinessProposal.ToJsonString).Execute(rtPost);

  // Falha na requisição
  if not (FRes.StatusCode = HTTP_CREATED) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro incluso
  lSObj  := SO(FRes.Content);
  Result := TBusinessProposalMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

function TBusinessProposalService.Update(ABusinessProposal: IBusinessProposalMTB; AId: Int64): Either<String, IBusinessProposalMTB>;
var
  lErrors: String;
  lSObj: ISuperObject;
begin
  // Validar antes de Atualizar
  lErrors := ABusinessProposal.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisição
  FRes := TReq.Make(RESOURCE+AId.ToString, ABusinessProposal.ToJsonString).Execute(rtPut);

  // Falha na requisição
  if not (FRes.StatusCode = HTTP_OK) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro atualizado
  lSObj  := SO(FRes.Content);
  Result := TBusinessProposalMTB.Make.FromJsonString(lSObj.O['data'].AsJSON);
end;

end.
