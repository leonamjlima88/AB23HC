unit uTenant.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uTenant.Repository.Interfaces,
  uApplication.Types,
  uTenant.Show.DTO,
  uTenant.DTO,
  uResponse.DTO;

Type
  [SwagPath('tenants', 'Inquilinos')]
  TTenantController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: ITenantRepository;
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
    [SwagResponse(HTTP_OK, TTenantIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TTenantShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TTenantDTO)]
    [SwagResponse(HTTP_CREATED, TTenantShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TTenantDTO)]
    [SwagResponse(HTTP_OK, TTenantShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uTenant.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uTenant.Index.UseCase,
  uSmartPointer,
  uTenant.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uTenant.StoreAndShow.UseCase,
  uTenant.UpdateAndShow.UseCase,
  System.SysUtils;

{ TTenantController }

constructor TTenantController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.Tenant;
end;

procedure TTenantController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TTenantDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TTenantController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TTenantIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TTenantController.Show;
var
  lTenantShowDTO: Shared<TTenantShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lTenantShowDTO := TTenantShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lTenantShowDTO.Value);
end;

procedure TTenantController.Store;
var
  lTenantToStoreDTO: Shared<TTenantDTO>;
  lTenantShowDTO: Shared<TTenantShowDTO>;
begin
  // Validar DTO
  lTenantToStoreDTO := TTenantDTO.FromJSON(FReq.Body);
  lTenantToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lTenantToStoreDTO);

  // Inserir e retornar registro inserido
  lTenantShowDTO := TTenantStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lTenantToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lTenantShowDTO.Value, HTTP_CREATED);
end;

procedure TTenantController.Update;
var
  lTenantToUpdateDTO: Shared<TTenantDTO>;
  lTenantShowDTO: Shared<TTenantShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lTenantToUpdateDTO := TTenantDTO.FromJSON(FReq.Body);
  lTenantToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lTenantToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lTenantShowDTO := TTenantUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lTenantToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lTenantShowDTO.Value);
end;

end.

