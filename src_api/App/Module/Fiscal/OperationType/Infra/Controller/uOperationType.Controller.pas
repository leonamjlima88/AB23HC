unit uOperationType.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uOperationType.Repository.Interfaces,
  uApplication.Types,
  uOperationType.Show.DTO,
  uOperationType.DTO,
  uResponse.DTO;

Type
  [SwagPath('operation_types', 'Tipo de Operação')]
  TOperationTypeController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IOperationTypeRepository;
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
    [SwagResponse(HTTP_OK, TOperationTypeIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TOperationTypeShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TOperationTypeDTO)]
    [SwagResponse(HTTP_CREATED, TOperationTypeShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TOperationTypeDTO)]
    [SwagResponse(HTTP_OK, TOperationTypeShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uOperationType.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uOperationType.Index.UseCase,
  uSmartPointer,
  uOperationType.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uOperationType.StoreAndShow.UseCase,
  uOperationType.UpdateAndShow.UseCase;

{ TOperationTypeController }

constructor TOperationTypeController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.OperationType;
end;

procedure TOperationTypeController.Delete;
var
  lPK, lTenantId: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  TOperationTypeDeleteUseCase.Make(FRepository).Execute(lPK, lTenantId);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TOperationTypeController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lPageFilter.AddWhere('operation_type.tenant_id', coEqual, FReq.Session<TMyClaims>.TenantId);
  lIndexResult := TOperationTypeIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TOperationTypeController.Show;
var
  lOperationTypeShowDTO: Shared<TOperationTypeShowDTO>;
  lPK, lTenantId: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  lOperationTypeShowDTO := TOperationTypeShowUseCase
    .Make    (FRepository)
    .Execute (lPk, lTenantId);

  // Retorno
  TRes.Success(FRes, lOperationTypeShowDTO.Value);
end;

procedure TOperationTypeController.Store;
var
  lOperationTypeToStoreDTO: Shared<TOperationTypeDTO>;
  lOperationTypeShowDTO: Shared<TOperationTypeShowDTO>;
begin
  // Validar DTO
  lOperationTypeToStoreDTO := TOperationTypeDTO.FromJSON(FReq.Body);
  lOperationTypeToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  lOperationTypeToStoreDTO.Value.tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  SwaggerValidator.Validate(lOperationTypeToStoreDTO);

  // Inserir e retornar registro inserido
  lOperationTypeShowDTO := TOperationTypeStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lOperationTypeToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lOperationTypeShowDTO.Value, HTTP_CREATED);
end;

procedure TOperationTypeController.Update;
var
  lOperationTypeToUpdateDTO: Shared<TOperationTypeDTO>;
  lOperationTypeShowDTO: Shared<TOperationTypeShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lOperationTypeToUpdateDTO := TOperationTypeDTO.FromJSON(FReq.Body);
  lOperationTypeToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  lOperationTypeToUpdateDTO.Value.tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  SwaggerValidator.Validate(lOperationTypeToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lOperationTypeShowDTO := TOperationTypeUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lOperationTypeToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lOperationTypeShowDTO.Value);
end;

end.

