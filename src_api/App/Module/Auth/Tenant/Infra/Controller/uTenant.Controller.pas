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
  [SwagPath('tenants', 'Inquilino')]
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
  uTenant.UpdateAndShow.UseCase;

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
  lPK       := THlp.StrInt(FReq.Params['id']);
  TTenantDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TTenantController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  // Filtro
  lPageFilter := TPageFilter.Make.FromJsonString(FReq.Body);

  // Pesquisar e retornar
  lIndexResult := TTenantIndexUseCase.Make(FRepository).Execute(lPageFilter);
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TTenantController.Show;
var
  lResult: Shared<TTenantShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lResult   := TTenantShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  case Assigned(lResult.Value) of
    True:  TRes.Success(FRes, lResult.Value);
    False: TRes.Success(FRes, Nil, HTTP_NOT_FOUND);
  end;
end;

procedure TTenantController.Store;
var
  lInput: Shared<TTenantDTO>;
  lResult: Shared<TTenantShowDTO>;
begin
  // Validar DTO
  lInput := TTenantDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  end;
  SwaggerValidator.Validate(lInput);

  // Inserir e retornar registro inserido
  lResult := TTenantStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value);

  // Retorno
  TRes.Success(FRes, lResult.Value, HTTP_CREATED);
end;

procedure TTenantController.Update;
var
  lInput: Shared<TTenantDTO>;
  lResult: Shared<TTenantShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lInput := TTenantDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  end;
  SwaggerValidator.Validate(lInput);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lResult := TTenantUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value, lPk);

  // Retorno
  TRes.Success(FRes, lResult.Value);
end;

end.

