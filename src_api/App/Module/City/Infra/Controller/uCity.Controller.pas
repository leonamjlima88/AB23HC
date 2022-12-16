unit uCity.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uCity.Repository.Interfaces,
  uApplication.Types,
  uCity.Show.DTO,
  uCity.DTO,
  uResponse.DTO;

Type
  [SwagPath('cities', 'Cidade')]
  TCityController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: ICityRepository;
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
    [SwagResponse(HTTP_OK, TCityIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TCityShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TCityDTO)]
    [SwagResponse(HTTP_CREATED, TCityShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TCityDTO)]
    [SwagResponse(HTTP_OK, TCityShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uCity.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uCity.Index.UseCase,
  uSmartPointer,
  uCity.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uCity.StoreAndShow.UseCase,
  uCity.UpdateAndShow.UseCase;

{ TCityController }

constructor TCityController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.City;
end;

procedure TCityController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TCityDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TCityController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TCityIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TCityController.Show;
var
  lCityShowDTO: Shared<TCityShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lCityShowDTO := TCityShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lCityShowDTO.Value);
end;

procedure TCityController.Store;
var
  lCityToStoreDTO: Shared<TCityDTO>;
  lCityShowDTO: Shared<TCityShowDTO>;
begin
  // Validar DTO
  lCityToStoreDTO := TCityDTO.FromJSON(FReq.Body);
  lCityToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lCityToStoreDTO);

  // Inserir e retornar registro inserido
  lCityShowDTO := TCityStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lCityToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lCityShowDTO.Value, HTTP_CREATED);
end;

procedure TCityController.Update;
var
  lCityToUpdateDTO: Shared<TCityDTO>;
  lCityShowDTO: Shared<TCityShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lCityToUpdateDTO := TCityDTO.FromJSON(FReq.Body);
  lCityToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lCityToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lCityShowDTO := TCityUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lCityToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lCityShowDTO.Value);
end;

end.
