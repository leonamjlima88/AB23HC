unit uAclRole.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uAclRole.Repository.Interfaces,
  uApplication.Types,
  uAclRole.Show.DTO,
  uAclRole.DTO,
  uResponse.DTO;

Type
  [SwagPath('acl_roles', 'Perfil de usu�rio')]
  TAclRoleController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IAclRoleRepository;
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
    [SwagResponse(HTTP_OK, TAclRoleIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TAclRoleShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TAclRoleDTO)]
    [SwagResponse(HTTP_CREATED, TAclRoleShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TAclRoleDTO)]
    [SwagResponse(HTTP_OK, TAclRoleShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uAclRole.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uAclRole.Index.UseCase,
  uSmartPointer,
  uAclRole.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uAclRole.StoreAndShow.UseCase,
  uAclRole.UpdateAndShow.UseCase;

{ TAclRoleController }

constructor TAclRoleController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.AclRole;
end;

procedure TAclRoleController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TAclRoleDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TAclRoleController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TAclRoleIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TAclRoleController.Show;
var
  lAclRoleShowDTO: Shared<TAclRoleShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lAclRoleShowDTO := TAclRoleShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lAclRoleShowDTO.Value);
end;

procedure TAclRoleController.Store;
var
  lAclRoleToStoreDTO: Shared<TAclRoleDTO>;
  lAclRoleShowDTO: Shared<TAclRoleShowDTO>;
begin
  // Validar DTO
  lAclRoleToStoreDTO := TAclRoleDTO.FromJSON(FReq.Body);
  SwaggerValidator.Validate(lAclRoleToStoreDTO);

  // Inserir e retornar registro inserido
  lAclRoleShowDTO := TAclRoleStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lAclRoleToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lAclRoleShowDTO.Value, HTTP_CREATED);
end;

procedure TAclRoleController.Update;
var
  lAclRoleToUpdateDTO: Shared<TAclRoleDTO>;
  lAclRoleShowDTO: Shared<TAclRoleShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lAclRoleToUpdateDTO := TAclRoleDTO.FromJSON(FReq.Body);
  SwaggerValidator.Validate(lAclRoleToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lAclRoleShowDTO := TAclRoleUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lAclRoleToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lAclRoleShowDTO.Value);
end;

end.

