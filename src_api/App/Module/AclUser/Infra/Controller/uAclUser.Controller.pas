unit uAclUser.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uAclUser.Repository.Interfaces,
  uApplication.Types,
  uAclUser.Show.DTO,
  uAclUser.DTO,
  uResponse.DTO;

Type
  [SwagPath('acl_users', 'Usuários')]
  TAclUserController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FAclUserRepository: IAclUserRepository;
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
    [SwagResponse(HTTP_OK, TAclUserIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TAclUserShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TAclUserDTO)]
    [SwagResponse(HTTP_CREATED, TAclUserShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TAclUserDTO)]
    [SwagResponse(HTTP_OK, TAclUserShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uAclUser.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uAclUser.Index.UseCase,
  uSmartPointer,
  uAclUser.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uAclUser.StoreAndShow.UseCase,
  uAclUser.UpdateAndShow.UseCase,
  uAclUser.Auth.UseCase;

{ TAclUserController }

constructor TAclUserController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq               := Req;
  FRes               := Res;
  FAclUserRepository := TRepositoryFactory.Make.AclUser;
end;

procedure TAclUserController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TAclUserDeleteUseCase.Make(FAclUserRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TAclUserController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TAclUserIndexUseCase.Make(FAclUserRepository).Execute(lPageFilter);

  // Não exibir estes campos
  lIndexResult.Data.DataSet.FieldByName('login_password').Visible  := False;
  lIndexResult.Data.DataSet.FieldByName('last_token').Visible      := False;
  lIndexResult.Data.DataSet.FieldByName('last_expiration').Visible := False;

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TAclUserController.Show;
var
  lAclUserShowDTO: Shared<TAclUserShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lAclUserShowDTO := TAclUserShowUseCase
    .Make    (FAclUserRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lAclUserShowDTO.Value);
end;

procedure TAclUserController.Store;
var
  lAclUserToStoreDTO: Shared<TAclUserDTO>;
  lAclUserShowDTO: Shared<TAclUserShowDTO>;
begin
  // Validar DTO
  lAclUserToStoreDTO := TAclUserDTO.FromJSON(FReq.Body);
  SwaggerValidator.Validate(lAclUserToStoreDTO);

  // Inserir e retornar registro inserido
  lAclUserShowDTO := TAclUserStoreAndShowUseCase
    .Make    (FAclUserRepository)
    .Execute (lAclUserToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lAclUserShowDTO.Value, HTTP_CREATED);
end;

procedure TAclUserController.Update;
var
  lAclUserToUpdateDTO: Shared<TAclUserDTO>;
  lAclUserShowDTO: Shared<TAclUserShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lAclUserToUpdateDTO := TAclUserDTO.FromJSON(FReq.Body);
  SwaggerValidator.Validate(lAclUserToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lAclUserShowDTO := TAclUserUpdateAndShowUseCase
    .Make    (FAclUserRepository)
    .Execute (lAclUserToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lAclUserShowDTO.Value);
end;

end.

