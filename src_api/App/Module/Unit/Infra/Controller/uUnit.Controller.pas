unit uUnit.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uUnit.Repository.Interfaces,
  uApplication.Types,
  uUnit.Show.DTO,
  uUnit.DTO,
  uResponse.DTO;

Type
  [SwagPath('units', 'Unidade de Medida')]
  TUnitController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IUnitRepository;
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
    [SwagResponse(HTTP_OK, TUnitIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TUnitShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TUnitDTO)]
    [SwagResponse(HTTP_CREATED, TUnitShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TUnitDTO)]
    [SwagResponse(HTTP_OK, TUnitShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uUnit.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uUnit.Index.UseCase,
  uSmartPointer,
  uUnit.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uUnit.StoreAndShow.UseCase,
  uUnit.UpdateAndShow.UseCase;

{ TUnitController }

constructor TUnitController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.&Unit;
end;

procedure TUnitController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TUnitDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TUnitController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TUnitIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TUnitController.Show;
var
  lUnitShowDTO: Shared<TUnitShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lUnitShowDTO := TUnitShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lUnitShowDTO.Value);
end;

procedure TUnitController.Store;
var
  lUnitToStoreDTO: Shared<TUnitDTO>;
  lUnitShowDTO: Shared<TUnitShowDTO>;
begin
  // Validar DTO
  lUnitToStoreDTO := TUnitDTO.FromJSON(FReq.Body);
  lUnitToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lUnitToStoreDTO);

  // Inserir e retornar registro inserido
  lUnitShowDTO := TUnitStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lUnitToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lUnitShowDTO.Value, HTTP_CREATED);
end;

procedure TUnitController.Update;
var
  lUnitToUpdateDTO: Shared<TUnitDTO>;
  lUnitShowDTO: Shared<TUnitShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lUnitToUpdateDTO := TUnitDTO.FromJSON(FReq.Body);
  lUnitToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lUnitToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lUnitShowDTO := TUnitUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lUnitToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lUnitShowDTO.Value);
end;

end.

