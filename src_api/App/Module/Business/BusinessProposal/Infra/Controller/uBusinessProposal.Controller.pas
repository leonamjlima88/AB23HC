unit uBusinessProposal.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uBusinessProposal.Repository.Interfaces,
  uApplication.Types,
  uBusinessProposal.Show.DTO,
  uBusinessProposal.DTO,
  uResponse.DTO;

Type
  [SwagPath('business_proposals', 'Proposta Comercial')]
  TBusinessProposalController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IBusinessProposalRepository;
  public
    constructor Create(Req: THorseRequest; Res: THorseResponse);

    [SwagDELETE('/{id}', 'Deletar')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_NO_CONTENT)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Delete;

    [SwagPOST('/index','Listagem de registros')]
    [SwagParamBody('body', TRequestPageFilterDTO, false, '', false)]
    [SwagResponse(HTTP_OK, TBusinessProposalIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TBusinessProposalShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TBusinessProposalDTO)]
    [SwagResponse(HTTP_CREATED, TBusinessProposalShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TBusinessProposalDTO)]
    [SwagResponse(HTTP_OK, TBusinessProposalShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;

    [SwagGET('/report_by_id/{id}', 'Obter PDF por ID')]
    [SwagParamPath('id', 'ID')]
    procedure ReportById;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uBusinessProposal.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uBusinessProposal.Index.UseCase,
  uSmartPointer,
  uBusinessProposal.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uBusinessProposal.StoreAndShow.UseCase,
  uBusinessProposal.UpdateAndShow.UseCase,
  uBusinessProposal.ReportById.UseCase,
  System.Classes,
  uOutPutFileStream;

{ TBusinessProposalController }

constructor TBusinessProposalController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.BusinessProposal;
end;

procedure TBusinessProposalController.Delete;
var
  lPK, lTenantId: Int64;
begin
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  TBusinessProposalDeleteUseCase.Make(FRepository).Execute(lPK, lTenantId);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TBusinessProposalController.ReportById;
var
  lPK, lTenantId: Int64;
  lResult: IOutPutFileStream;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);

  // Obter Stream do relatório
  lResult := TBusinessProposalReportByIdUseCase
    .Make    (FRepository, TRepositoryFactory.Make(FRepository.Conn).Tenant)
    .Execute (lPk, lTenantId);

  // Retornar Stream
  FRes.SendFile(lResult.Stream, lResult.FileName, lResult.ContentType);
end;

procedure TBusinessProposalController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  // Filtro
  lPageFilter := TPageFilter.Make.FromJsonString(FReq.Body);
  lPageFilter.AddWhere('business_proposal.tenant_id', coEqual, FReq.Session<TMyClaims>.TenantId);

  // Pesquisar e retornar
  lIndexResult := TBusinessProposalIndexUseCase.Make(FRepository).Execute(lPageFilter);
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TBusinessProposalController.Show;
var
  lResult: Shared<TBusinessProposalShowDTO>;
  lPK, lTenantId: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  lResult   := TBusinessProposalShowUseCase
    .Make    (FRepository)
    .Execute (lPk, lTenantId);

  // Retorno
  case Assigned(lResult.Value) of
    True:  TRes.Success(FRes, lResult.Value);
    False: TRes.Success(FRes, Nil, HTTP_NOT_FOUND);
  end;
end;

procedure TBusinessProposalController.Store;
var
  lInput: Shared<TBusinessProposalDTO>;
  lResult: Shared<TBusinessProposalShowDTO>;
begin
  // Validar DTO
  lInput := TBusinessProposalDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
    tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  end;
  SwaggerValidator.Validate(lInput);

  // Inserir e retornar registro inserido
  lResult := TBusinessProposalStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value);

  // Retorno
  TRes.Success(FRes, lResult.Value, HTTP_CREATED);
end;

procedure TBusinessProposalController.Update;
var
  lInput: Shared<TBusinessProposalDTO>;
  lResult: Shared<TBusinessProposalShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lInput := TBusinessProposalDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
    tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  end;
  SwaggerValidator.Validate(lInput);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lResult := TBusinessProposalUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value, lPk);

  // Retorno
  TRes.Success(FRes, lResult.Value);
end;

end.

