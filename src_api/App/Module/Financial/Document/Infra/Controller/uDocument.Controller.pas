unit uDocument.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uDocument.Repository.Interfaces,
  uApplication.Types,
  uDocument.Show.DTO,
  uDocument.DTO,
  uResponse.DTO;

Type
  [SwagPath('documents', 'Documento')]
  TDocumentController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IDocumentRepository;
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
    [SwagResponse(HTTP_OK, TDocumentIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TDocumentShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TDocumentDTO)]
    [SwagResponse(HTTP_CREATED, TDocumentShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TDocumentDTO)]
    [SwagResponse(HTTP_OK, TDocumentShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uDocument.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uDocument.Index.UseCase,
  uSmartPointer,
  uDocument.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uDocument.StoreAndShow.UseCase,
  uDocument.UpdateAndShow.UseCase;

{ TDocumentController }

constructor TDocumentController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.Document;
end;

procedure TDocumentController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TDocumentDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TDocumentController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TDocumentIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TDocumentController.Show;
var
  lDocumentShowDTO: Shared<TDocumentShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lDocumentShowDTO := TDocumentShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lDocumentShowDTO.Value);
end;

procedure TDocumentController.Store;
var
  lDocumentToStoreDTO: Shared<TDocumentDTO>;
  lDocumentShowDTO: Shared<TDocumentShowDTO>;
begin
  // Validar DTO
  lDocumentToStoreDTO := TDocumentDTO.FromJSON(FReq.Body);
  lDocumentToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lDocumentToStoreDTO);

  // Inserir e retornar registro inserido
  lDocumentShowDTO := TDocumentStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lDocumentToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lDocumentShowDTO.Value, HTTP_CREATED);
end;

procedure TDocumentController.Update;
var
  lDocumentToUpdateDTO: Shared<TDocumentDTO>;
  lDocumentShowDTO: Shared<TDocumentShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lDocumentToUpdateDTO := TDocumentDTO.FromJSON(FReq.Body);
  lDocumentToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lDocumentToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lDocumentShowDTO := TDocumentUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lDocumentToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lDocumentShowDTO.Value);
end;

end.

