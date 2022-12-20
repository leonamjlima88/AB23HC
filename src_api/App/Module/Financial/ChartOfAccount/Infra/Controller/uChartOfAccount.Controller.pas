unit uChartOfAccount.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uChartOfAccount.Repository.Interfaces,
  uApplication.Types,
  uChartOfAccount.Show.DTO,
  uChartOfAccount.DTO,
  uResponse.DTO;

Type
  [SwagPath('chart_of_accounts', 'Plano de Conta')]
  TChartOfAccountController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IChartOfAccountRepository;
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
    [SwagResponse(HTTP_OK, TChartOfAccountIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TChartOfAccountShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TChartOfAccountDTO)]
    [SwagResponse(HTTP_CREATED, TChartOfAccountShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TChartOfAccountDTO)]
    [SwagResponse(HTTP_OK, TChartOfAccountShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uChartOfAccount.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uChartOfAccount.Index.UseCase,
  uSmartPointer,
  uChartOfAccount.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uChartOfAccount.StoreAndShow.UseCase,
  uChartOfAccount.UpdateAndShow.UseCase;

{ TChartOfAccountController }

constructor TChartOfAccountController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.ChartOfAccount;
end;

procedure TChartOfAccountController.Delete;
var
  lPK, lTenantId: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  TChartOfAccountDeleteUseCase.Make(FRepository).Execute(lPK, lTenantId);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TChartOfAccountController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lPageFilter.AddWhere('chart_of_account.tenant_id', coEqual, FReq.Session<TMyClaims>.TenantId);
  lIndexResult := TChartOfAccountIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TChartOfAccountController.Show;
var
  lChartOfAccountShowDTO: Shared<TChartOfAccountShowDTO>;
  lPK, lTenantId: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  lChartOfAccountShowDTO := TChartOfAccountShowUseCase
    .Make    (FRepository)
    .Execute (lPk, lTenantId);

  // Retorno
  TRes.Success(FRes, lChartOfAccountShowDTO.Value);
end;

procedure TChartOfAccountController.Store;
var
  lChartOfAccountToStoreDTO: Shared<TChartOfAccountDTO>;
  lChartOfAccountShowDTO: Shared<TChartOfAccountShowDTO>;
begin
  // Validar DTO
  lChartOfAccountToStoreDTO := TChartOfAccountDTO.FromJSON(FReq.Body);
  lChartOfAccountToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  lChartOfAccountToStoreDTO.Value.tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  SwaggerValidator.Validate(lChartOfAccountToStoreDTO);

  // Inserir e retornar registro inserido
  lChartOfAccountShowDTO := TChartOfAccountStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lChartOfAccountToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lChartOfAccountShowDTO.Value, HTTP_CREATED);
end;

procedure TChartOfAccountController.Update;
var
  lChartOfAccountToUpdateDTO: Shared<TChartOfAccountDTO>;
  lChartOfAccountShowDTO: Shared<TChartOfAccountShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lChartOfAccountToUpdateDTO := TChartOfAccountDTO.FromJSON(FReq.Body);
  lChartOfAccountToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  lChartOfAccountToUpdateDTO.Value.tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  SwaggerValidator.Validate(lChartOfAccountToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lChartOfAccountShowDTO := TChartOfAccountUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lChartOfAccountToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lChartOfAccountShowDTO.Value);
end;

end.

