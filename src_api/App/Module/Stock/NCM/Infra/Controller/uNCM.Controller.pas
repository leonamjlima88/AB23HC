unit uNCM.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uNCM.Repository.Interfaces,
  uApplication.Types,
  uNCM.Show.DTO,
  uNCM.DTO,
  uResponse.DTO;

Type
  [SwagPath('ncms', 'NCM')]
  TNCMController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: INCMRepository;
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
    [SwagResponse(HTTP_OK, TNCMIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TNCMShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TNCMDTO)]
    [SwagResponse(HTTP_CREATED, TNCMShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TNCMDTO)]
    [SwagResponse(HTTP_OK, TNCMShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uNCM.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uNCM.Index.UseCase,
  uSmartPointer,
  uNCM.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uNCM.StoreAndShow.UseCase,
  uNCM.UpdateAndShow.UseCase;

{ TNCMController }

constructor TNCMController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.NCM;
end;

procedure TNCMController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TNCMDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TNCMController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TNCMIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TNCMController.Show;
var
  lNCMShowDTO: Shared<TNCMShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lNCMShowDTO := TNCMShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lNCMShowDTO.Value);
end;

procedure TNCMController.Store;
var
  lNCMToStoreDTO: Shared<TNCMDTO>;
  lNCMShowDTO: Shared<TNCMShowDTO>;
begin
  // Validar DTO
  lNCMToStoreDTO := TNCMDTO.FromJSON(FReq.Body);
  lNCMToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lNCMToStoreDTO);

  // Inserir e retornar registro inserido
  lNCMShowDTO := TNCMStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lNCMToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lNCMShowDTO.Value, HTTP_CREATED);
end;

procedure TNCMController.Update;
var
  lNCMToUpdateDTO: Shared<TNCMDTO>;
  lNCMShowDTO: Shared<TNCMShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lNCMToUpdateDTO := TNCMDTO.FromJSON(FReq.Body);
  lNCMToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lNCMToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lNCMShowDTO := TNCMUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lNCMToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lNCMShowDTO.Value);
end;

end.

