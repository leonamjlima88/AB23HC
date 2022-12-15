unit uCostCenter.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uCostCenter.Repository.Interfaces,
  uApplication.Types,
  uCostCenter.Show.DTO,
  uCostCenter.DTO,
  uResponse.DTO;

Type
  [SwagPath('cost_centers', 'Centro de Custo')]
  TCostCenterController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: ICostCenterRepository;
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
    [SwagResponse(HTTP_OK, TCostCenterIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TCostCenterShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TCostCenterDTO)]
    [SwagResponse(HTTP_CREATED, TCostCenterShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TCostCenterDTO)]
    [SwagResponse(HTTP_OK, TCostCenterShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uCostCenter.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uCostCenter.Index.UseCase,
  uSmartPointer,
  uCostCenter.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uCostCenter.StoreAndShow.UseCase,
  uCostCenter.UpdateAndShow.UseCase;

{ TCostCenterController }

constructor TCostCenterController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.CostCenter;
end;

procedure TCostCenterController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TCostCenterDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TCostCenterController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TCostCenterIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TCostCenterController.Show;
var
  lCostCenterShowDTO: Shared<TCostCenterShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lCostCenterShowDTO := TCostCenterShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lCostCenterShowDTO.Value);
end;

procedure TCostCenterController.Store;
var
  lCostCenterToStoreDTO: Shared<TCostCenterDTO>;
  lCostCenterShowDTO: Shared<TCostCenterShowDTO>;
begin
  // Validar DTO
  lCostCenterToStoreDTO := TCostCenterDTO.FromJSON(FReq.Body);
  lCostCenterToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lCostCenterToStoreDTO);

  // Inserir e retornar registro inserido
  lCostCenterShowDTO := TCostCenterStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lCostCenterToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lCostCenterShowDTO.Value, HTTP_CREATED);
end;

procedure TCostCenterController.Update;
var
  lCostCenterToUpdateDTO: Shared<TCostCenterDTO>;
  lCostCenterShowDTO: Shared<TCostCenterShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lCostCenterToUpdateDTO := TCostCenterDTO.FromJSON(FReq.Body);
  lCostCenterToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lCostCenterToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lCostCenterShowDTO := TCostCenterUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lCostCenterToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lCostCenterShowDTO.Value);
end;

end.

