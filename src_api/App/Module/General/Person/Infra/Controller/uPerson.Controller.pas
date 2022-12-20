unit uPerson.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uPerson.Repository.Interfaces,
  uApplication.Types,
  uPerson.Show.DTO,
  uPerson.DTO,
  uResponse.DTO;

Type
  [SwagPath('persons', 'Pessoa')]
  TPersonController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IPersonRepository;
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
    [SwagResponse(HTTP_OK, TPersonIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TPersonShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TPersonDTO)]
    [SwagResponse(HTTP_CREATED, TPersonShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TPersonDTO)]
    [SwagResponse(HTTP_OK, TPersonShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uPerson.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uPerson.Index.UseCase,
  uSmartPointer,
  uPerson.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uPerson.StoreAndShow.UseCase,
  uPerson.UpdateAndShow.UseCase;

{ TPersonController }

constructor TPersonController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.Person;
end;

procedure TPersonController.Delete;
var
  lPK, lTenantId: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  TPersonDeleteUseCase.Make(FRepository).Execute(lPK, lTenantId);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TPersonController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lPageFilter.AddWhere('person.tenant_id', coEqual, FReq.Session<TMyClaims>.TenantId);
  lIndexResult := TPersonIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TPersonController.Show;
var
  lPersonShowDTO: Shared<TPersonShowDTO>;
  lPK, lTenantId: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  lPersonShowDTO := TPersonShowUseCase
    .Make    (FRepository)
    .Execute (lPk, lTenantId);

  // Retorno
  TRes.Success(FRes, lPersonShowDTO.Value);
end;

procedure TPersonController.Store;
var
  lPersonToStoreDTO: Shared<TPersonDTO>;
  lPersonShowDTO: Shared<TPersonShowDTO>;
begin
  // Validar DTO
  lPersonToStoreDTO := TPersonDTO.FromJSON(FReq.Body);
  lPersonToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  lPersonToStoreDTO.Value.tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  SwaggerValidator.Validate(lPersonToStoreDTO);

  // Inserir e retornar registro inserido
  lPersonShowDTO := TPersonStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lPersonToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lPersonShowDTO.Value, HTTP_CREATED);
end;

procedure TPersonController.Update;
var
  lPersonToUpdateDTO: Shared<TPersonDTO>;
  lPersonShowDTO: Shared<TPersonShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lPersonToUpdateDTO := TPersonDTO.FromJSON(FReq.Body);
  lPersonToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  lPersonToUpdateDTO.Value.tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  SwaggerValidator.Validate(lPersonToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lPersonShowDTO := TPersonUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lPersonToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lPersonShowDTO.Value);
end;

end.

