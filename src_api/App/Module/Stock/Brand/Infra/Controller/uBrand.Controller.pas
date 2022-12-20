unit uBrand.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uBrand.Repository.Interfaces,
  uApplication.Types,
  uBrand.Show.DTO,
  uBrand.DTO,
  uResponse.DTO;

Type
  [SwagPath('brands', 'Marca')]
  TBrandController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IBrandRepository;
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
    [SwagResponse(HTTP_OK, TBrandIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TBrandShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TBrandDTO)]
    [SwagResponse(HTTP_CREATED, TBrandShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TBrandDTO)]
    [SwagResponse(HTTP_OK, TBrandShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uBrand.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uBrand.Index.UseCase,
  uSmartPointer,
  uBrand.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uBrand.StoreAndShow.UseCase,
  uBrand.UpdateAndShow.UseCase;

{ TBrandController }

constructor TBrandController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.Brand;
end;

procedure TBrandController.Delete;
var
  lPK, lTenantId: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  TBrandDeleteUseCase.Make(FRepository).Execute(lPK, lTenantId);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TBrandController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lPageFilter.AddWhere('brand.tenant_id', coEqual, FReq.Session<TMyClaims>.TenantId);
  lIndexResult := TBrandIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TBrandController.Show;
var
  lBrandShowDTO: Shared<TBrandShowDTO>;
  lPK, lTenantId: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  lBrandShowDTO := TBrandShowUseCase
    .Make    (FRepository)
    .Execute (lPk, lTenantId);

  // Retorno
  TRes.Success(FRes, lBrandShowDTO.Value);
end;

procedure TBrandController.Store;
var
  lBrandToStoreDTO: Shared<TBrandDTO>;
  lBrandShowDTO: Shared<TBrandShowDTO>;
begin
  // Validar DTO
  lBrandToStoreDTO := TBrandDTO.FromJSON(FReq.Body);
  lBrandToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  lBrandToStoreDTO.Value.tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  SwaggerValidator.Validate(lBrandToStoreDTO);

  // Inserir e retornar registro inserido
  lBrandShowDTO := TBrandStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lBrandToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lBrandShowDTO.Value, HTTP_CREATED);
end;

procedure TBrandController.Update;
var
  lBrandToUpdateDTO: Shared<TBrandDTO>;
  lBrandShowDTO: Shared<TBrandShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lBrandToUpdateDTO := TBrandDTO.FromJSON(FReq.Body);
  lBrandToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  lBrandToUpdateDTO.Value.tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  SwaggerValidator.Validate(lBrandToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lBrandShowDTO := TBrandUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lBrandToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lBrandShowDTO.Value);
end;

end.

