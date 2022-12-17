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
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TSizeDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TSizeController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TSizeIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TSizeController.Show;
var
  lSizeShowDTO: Shared<TSizeShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lSizeShowDTO := TSizeShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lSizeShowDTO.Value);
end;

procedure TSizeController.Store;
var
  lSizeToStoreDTO: Shared<TSizeDTO>;
  lSizeShowDTO: Shared<TSizeShowDTO>;
begin
  // Validar DTO
  lSizeToStoreDTO := TSizeDTO.FromJSON(FReq.Body);
  lSizeToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lSizeToStoreDTO);

  // Inserir e retornar registro inserido
  lSizeShowDTO := TSizeStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lSizeToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lSizeShowDTO.Value, HTTP_CREATED);
end;

procedure TSizeController.Update;
var
  lSizeToUpdateDTO: Shared<TSizeDTO>;
  lSizeShowDTO: Shared<TSizeShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lSizeToUpdateDTO := TSizeDTO.FromJSON(FReq.Body);
  lSizeToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lSizeToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lSizeShowDTO := TSizeUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lSizeToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lSizeShowDTO.Value);
end;

end.

