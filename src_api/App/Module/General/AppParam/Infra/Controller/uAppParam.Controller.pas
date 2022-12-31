unit uAppParam.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uAppParam.Repository.Interfaces,
  uApplication.Types,
  uAppParam.Show.DTO,
  uAppParam.DTO,
  uResponse.DTO,
  uAppParamMany.DTO;

Type
  [SwagPath('app_params', 'Parâmetros')]
  TAppParamController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IAppParamRepository;
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
    [SwagResponse(HTTP_OK, TAppParamIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TAppParamShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TAppParamDTO)]
    [SwagResponse(HTTP_CREATED, TAppParamShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TAppParamDTO)]
    [SwagResponse(HTTP_OK, TAppParamShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;

    [SwagPOST('/save_many_by_group', 'Salvar parâmetros por grupo')]
    [SwagParamBody('body', TAppParamManyDTO)]
    [SwagResponse(HTTP_OK, TAppParamIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure SaveManyByGroupName;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uAppParam.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uAppParam.Index.UseCase,
  uSmartPointer,
  uAppParam.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uAppParam.StoreAndShow.UseCase,
  uAppParam.UpdateAndShow.UseCase,
  uAppParam.SaveManyByGroupAndIndex.UseCase;

{ TAppParamController }

constructor TAppParamController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.AppParam;
end;

procedure TAppParamController.Delete;
var
  lPK, lTenantId: Int64;
begin
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  TAppParamDeleteUseCase.Make(FRepository).Execute(lPK, lTenantId);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TAppParamController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  // Filtro
  lPageFilter := TPageFilter.Make.FromJsonString(FReq.Body);
  lPageFilter.AddWhere('app_param.tenant_id', coEqual, FReq.Session<TMyClaims>.TenantId);

  // Pesquisar e retornar
  lIndexResult := TAppParamIndexUseCase.Make(FRepository).Execute(lPageFilter);
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TAppParamController.Show;
var
  lResult: Shared<TAppParamShowDTO>;
  lPK, lTenantId: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  lResult   := TAppParamShowUseCase
    .Make    (FRepository)
    .Execute (lPk, lTenantId);

  // Retorno
  case Assigned(lResult.Value) of
    True:  TRes.Success(FRes, lResult.Value);
    False: TRes.Success(FRes, Nil, HTTP_NOT_FOUND);
  end;
end;

procedure TAppParamController.Store;
var
  lInput: Shared<TAppParamDTO>;
  lResult: Shared<TAppParamShowDTO>;
begin
  // Validar DTO
  lInput := TAppParamDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    tenant_id := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  end;
  SwaggerValidator.Validate(lInput);

  // Inserir e retornar registro inserido
  lResult := TAppParamStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value);

  // Retorno
  TRes.Success(FRes, lResult.Value, HTTP_CREATED);
end;

procedure TAppParamController.SaveManyByGroupName;
var
  lInput: Shared<TAppParamManyDTO>;
  lIndexResult: IIndexResult;
begin
  // Validar DTO
  lInput                 := TAppParamManyDTO.FromJSON(FReq.Body);
  lInput.Value.tenant_id := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  SwaggerValidator.Validate(lInput);

  // Inserir e retornar registros inseridos
  lIndexResult := TAppParamSaveManyByGroupAndIndexUseCase
    .Make    (FRepository)
    .Execute (lInput.Value);

  TRes.Success(FRes, lIndexResult.ToSuperObject, HTTP_CREATED);
end;

procedure TAppParamController.Update;
var
  lInput: Shared<TAppParamDTO>;
  lResult: Shared<TAppParamShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lInput := TAppParamDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    tenant_id := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  end;
  SwaggerValidator.Validate(lInput);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lResult := TAppParamUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value, lPk);

  // Retorno
  TRes.Success(FRes, lResult.Value);
end;

end.

