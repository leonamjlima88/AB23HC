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
    FBrandRepository: IBrandRepository;
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
  FReq             := Req;
  FRes             := Res;
  FBrandRepository := TRepositoryFactory.Make.Brand;
end;

procedure TBrandController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TBrandDeleteUseCase.Make(FBrandRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TBrandController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TBrandIndexUseCase.Make(FBrandRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TBrandController.Show;
var
  lBrandShowDTO: Shared<TBrandShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lBrandShowDTO := TBrandShowUseCase
    .Make    (FBrandRepository)
    .Execute (lPk);

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
  SwaggerValidator.Validate(lBrandToStoreDTO);

  // Inserir e retornar registro inserido
  lBrandShowDTO := TBrandStoreAndShowUseCase
    .Make    (FBrandRepository)
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
  SwaggerValidator.Validate(lBrandToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lBrandShowDTO := TBrandUpdateAndShowUseCase
    .Make    (FBrandRepository)
    .Execute (lBrandToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lBrandShowDTO.Value);
end;

end.

