unit uSize.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uSize.Repository.Interfaces,
  uApplication.Types,
  uSize.Show.DTO,
  uSize.DTO,
  uResponse.DTO;

Type
  [SwagPath('sizes', 'Tamanho')]
  TSizeController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: ISizeRepository;
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
    [SwagResponse(HTTP_OK, TSizeIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TSizeShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TSizeDTO)]
    [SwagResponse(HTTP_CREATED, TSizeShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TSizeDTO)]
    [SwagResponse(HTTP_OK, TSizeShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uSize.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uSize.Index.UseCase,
  uSmartPointer,
  uSize.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uSize.StoreAndShow.UseCase,
  uSize.UpdateAndShow.UseCase;

{ TSizeController }

constructor TSizeController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.Size;
end;

procedure TSizeController.Delete;
var
  lPK, lTenantId: Int64;
begin
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  TSizeDeleteUseCase.Make(FRepository).Execute(lPK, lTenantId);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TSizeController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter := TPageFilter.Make.FromJsonString(FReq.Body);
  lPageFilter.AddWhere('size.tenant_id', coEqual, FReq.Session<TMyClaims>.TenantId);
  lIndexResult := TSizeIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TSizeController.Show;
var
  lResult: Shared<TSizeShowDTO>;
  lPK, lTenantId: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  lResult   := TSizeShowUseCase
    .Make    (FRepository)
    .Execute (lPk, lTenantId);

  // Retorno
  TRes.Success(FRes, lResult.Value);
end;

procedure TSizeController.Store;
var
  lInput: Shared<TSizeDTO>;
  lResult: Shared<TSizeShowDTO>;
begin
  // Validar DTO
  lInput := TSizeDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
    tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  end;
  SwaggerValidator.Validate(lInput);

  // Inserir e retornar registro inserido
  lResult := TSizeStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value);

  // Retorno
  TRes.Success(FRes, lResult.Value, HTTP_CREATED);
end;

procedure TSizeController.Update;
var
  lInput: Shared<TSizeDTO>;
  lResult: Shared<TSizeShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lInput := TSizeDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
    tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  end;
  SwaggerValidator.Validate(lInput);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lResult := TSizeUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value, lPk);

  // Retorno
  TRes.Success(FRes, lResult.Value);
end;

end.

