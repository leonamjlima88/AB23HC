unit uStorageLocation.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uStorageLocation.Repository.Interfaces,
  uApplication.Types,
  uStorageLocation.Show.DTO,
  uStorageLocation.DTO,
  uResponse.DTO;

Type
  [SwagPath('storage_locations', 'Local de Armazenamento')]
  TStorageLocationController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IStorageLocationRepository;
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
    [SwagResponse(HTTP_OK, TStorageLocationIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TStorageLocationShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TStorageLocationDTO)]
    [SwagResponse(HTTP_CREATED, TStorageLocationShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TStorageLocationDTO)]
    [SwagResponse(HTTP_OK, TStorageLocationShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uStorageLocation.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uStorageLocation.Index.UseCase,
  uSmartPointer,
  uStorageLocation.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uStorageLocation.StoreAndShow.UseCase,
  uStorageLocation.UpdateAndShow.UseCase;

{ TStorageLocationController }

constructor TStorageLocationController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.StorageLocation;
end;

procedure TStorageLocationController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TStorageLocationDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TStorageLocationController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TStorageLocationIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TStorageLocationController.Show;
var
  lStorageLocationShowDTO: Shared<TStorageLocationShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lStorageLocationShowDTO := TStorageLocationShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lStorageLocationShowDTO.Value);
end;

procedure TStorageLocationController.Store;
var
  lStorageLocationToStoreDTO: Shared<TStorageLocationDTO>;
  lStorageLocationShowDTO: Shared<TStorageLocationShowDTO>;
begin
  // Validar DTO
  lStorageLocationToStoreDTO := TStorageLocationDTO.FromJSON(FReq.Body);
  lStorageLocationToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lStorageLocationToStoreDTO);

  // Inserir e retornar registro inserido
  lStorageLocationShowDTO := TStorageLocationStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lStorageLocationToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lStorageLocationShowDTO.Value, HTTP_CREATED);
end;

procedure TStorageLocationController.Update;
var
  lStorageLocationToUpdateDTO: Shared<TStorageLocationDTO>;
  lStorageLocationShowDTO: Shared<TStorageLocationShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lStorageLocationToUpdateDTO := TStorageLocationDTO.FromJSON(FReq.Body);
  lStorageLocationToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lStorageLocationToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lStorageLocationShowDTO := TStorageLocationUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lStorageLocationToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lStorageLocationShowDTO.Value);
end;

end.

