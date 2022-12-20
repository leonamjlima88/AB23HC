unit uCategory.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uCategory.Repository.Interfaces,
  uApplication.Types,
  uCategory.Show.DTO,
  uCategory.DTO,
  uResponse.DTO;

Type
  [SwagPath('categorys', 'Categoria')]
  TCategoryController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: ICategoryRepository;
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
    [SwagResponse(HTTP_OK, TCategoryIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TCategoryShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TCategoryDTO)]
    [SwagResponse(HTTP_CREATED, TCategoryShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TCategoryDTO)]
    [SwagResponse(HTTP_OK, TCategoryShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uCategory.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uCategory.Index.UseCase,
  uSmartPointer,
  uCategory.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uCategory.StoreAndShow.UseCase,
  uCategory.UpdateAndShow.UseCase;

{ TCategoryController }

constructor TCategoryController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.Category;
end;

procedure TCategoryController.Delete;
var
  lPK, lTenantId: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  TCategoryDeleteUseCase.Make(FRepository).Execute(lPK, lTenantId);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TCategoryController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lPageFilter.AddWhere('category.tenant_id', coEqual, FReq.Session<TMyClaims>.TenantId);
  lIndexResult := TCategoryIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TCategoryController.Show;
var
  lCategoryShowDTO: Shared<TCategoryShowDTO>;
  lPK, lTenantId: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  lCategoryShowDTO := TCategoryShowUseCase
    .Make    (FRepository)
    .Execute (lPk, lTenantId);

  // Retorno
  TRes.Success(FRes, lCategoryShowDTO.Value);
end;

procedure TCategoryController.Store;
var
  lCategoryToStoreDTO: Shared<TCategoryDTO>;
  lCategoryShowDTO: Shared<TCategoryShowDTO>;
begin
  // Validar DTO
  lCategoryToStoreDTO := TCategoryDTO.FromJSON(FReq.Body);
  lCategoryToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  lCategoryToStoreDTO.Value.tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  SwaggerValidator.Validate(lCategoryToStoreDTO);

  // Inserir e retornar registro inserido
  lCategoryShowDTO := TCategoryStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lCategoryToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lCategoryShowDTO.Value, HTTP_CREATED);
end;

procedure TCategoryController.Update;
var
  lCategoryToUpdateDTO: Shared<TCategoryDTO>;
  lCategoryShowDTO: Shared<TCategoryShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lCategoryToUpdateDTO := TCategoryDTO.FromJSON(FReq.Body);
  lCategoryToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  lCategoryToUpdateDTO.Value.tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  SwaggerValidator.Validate(lCategoryToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lCategoryShowDTO := TCategoryUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lCategoryToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lCategoryShowDTO.Value);
end;

end.

