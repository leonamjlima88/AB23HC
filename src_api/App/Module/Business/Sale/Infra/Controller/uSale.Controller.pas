unit uSale.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uSale.Repository.Interfaces,
  uApplication.Types,
  uSale.Show.DTO,
  uSale.DTO,
  uResponse.DTO;

Type
  [SwagPath('sales', 'Venda')]
  TSaleController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: ISaleRepository;
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
    [SwagResponse(HTTP_OK, TSaleIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TSaleShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TSaleDTO)]
    [SwagResponse(HTTP_CREATED, TSaleShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TSaleDTO)]
    [SwagResponse(HTTP_OK, TSaleShowResponseDTO)]
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
  uSale.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uSale.Index.UseCase,
  uSmartPointer,
  uSale.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uSale.StoreAndShow.UseCase,
  uSale.UpdateAndShow.UseCase,
  uSale.ReportById.UseCase,
  System.Classes,
  uOutPutFileStream;

{ TSaleController }

constructor TSaleController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.Sale;
end;

procedure TSaleController.Delete;
var
  lPK, lTenantId: Int64;
begin
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  TSaleDeleteUseCase.Make(FRepository).Execute(lPK, lTenantId);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TSaleController.ReportById;
var
  lPK, lTenantId: Int64;
  lResult: IOutPutFileStream;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);

  // Obter Stream do relatório
  lResult := TSaleReportByIdUseCase
    .Make    (FRepository, TRepositoryFactory.Make(FRepository.Conn).Tenant)
    .Execute (lPk, lTenantId);

  // Retornar Stream
  FRes.SendFile(lResult.Stream, lResult.FileName, lResult.ContentType);
end;

procedure TSaleController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  // Filtro
  lPageFilter := TPageFilter.Make.FromJsonString(FReq.Body);
  lPageFilter.AddWhere('sale.tenant_id', coEqual, FReq.Session<TMyClaims>.TenantId);

  // Pesquisar e retornar
  lIndexResult := TSaleIndexUseCase.Make(FRepository).Execute(lPageFilter);
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TSaleController.Show;
var
  lResult: Shared<TSaleShowDTO>;
  lPK, lTenantId: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  lResult   := TSaleShowUseCase
    .Make    (FRepository)
    .Execute (lPk, lTenantId);

  // Retorno
  case Assigned(lResult.Value) of
    True:  TRes.Success(FRes, lResult.Value);
    False: TRes.Success(FRes, Nil, HTTP_NOT_FOUND);
  end;
end;

procedure TSaleController.Store;
var
  lInput: Shared<TSaleDTO>;
  lResult: Shared<TSaleShowDTO>;
begin
  // Validar DTO
  lInput := TSaleDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
    tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  end;
  SwaggerValidator.Validate(lInput);

  // Inserir e retornar registro inserido
  lResult := TSaleStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value);

  // Retorno
  TRes.Success(FRes, lResult.Value, HTTP_CREATED);
end;

procedure TSaleController.Update;
var
  lInput: Shared<TSaleDTO>;
  lResult: Shared<TSaleShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lInput := TSaleDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
    tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  end;
  SwaggerValidator.Validate(lInput);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lResult := TSaleUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value, lPk);

  // Retorno
  TRes.Success(FRes, lResult.Value);
end;

end.

