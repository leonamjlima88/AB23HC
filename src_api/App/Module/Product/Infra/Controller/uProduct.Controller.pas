unit uProduct.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uProduct.Repository.Interfaces,
  uApplication.Types,
  uProduct.Show.DTO,
  uProduct.DTO,
  uResponse.DTO;

Type
  [SwagPath('products', 'Produto/Serviço')]
  TProductController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IProductRepository;
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
    [SwagResponse(HTTP_OK, TProductIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TProductShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TProductDTO)]
    [SwagResponse(HTTP_CREATED, TProductShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TProductDTO)]
    [SwagResponse(HTTP_OK, TProductShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uProduct.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uProduct.Index.UseCase,
  uSmartPointer,
  uProduct.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uProduct.StoreAndShow.UseCase,
  uProduct.UpdateAndShow.UseCase;

{ TProductController }

constructor TProductController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.Product;
end;

procedure TProductController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TProductDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TProductController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TProductIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TProductController.Show;
var
  lProductShowDTO: Shared<TProductShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lProductShowDTO := TProductShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lProductShowDTO.Value);
end;

procedure TProductController.Store;
var
  lProductToStoreDTO: Shared<TProductDTO>;
  lProductShowDTO: Shared<TProductShowDTO>;
begin
  // Validar DTO
  lProductToStoreDTO := TProductDTO.FromJSON(FReq.Body);
  lProductToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lProductToStoreDTO);

  // Inserir e retornar registro inserido
  lProductShowDTO := TProductStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lProductToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lProductShowDTO.Value, HTTP_CREATED);
end;

procedure TProductController.Update;
var
  lProductToUpdateDTO: Shared<TProductDTO>;
  lProductShowDTO: Shared<TProductShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lProductToUpdateDTO := TProductDTO.FromJSON(FReq.Body);
  lProductToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lProductToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lProductShowDTO := TProductUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lProductToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lProductShowDTO.Value);
end;

end.

