unit uPaymentTerm.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uPaymentTerm.Repository.Interfaces,
  uApplication.Types,
  uPaymentTerm.Show.DTO,
  uPaymentTerm.DTO,
  uResponse.DTO;

Type
  [SwagPath('payment_terms', 'Condição de pagamento')]
  TPaymentTermController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IPaymentTermRepository;
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
    [SwagResponse(HTTP_OK, TPaymentTermIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TPaymentTermShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TPaymentTermDTO)]
    [SwagResponse(HTTP_CREATED, TPaymentTermShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TPaymentTermDTO)]
    [SwagResponse(HTTP_OK, TPaymentTermShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uPaymentTerm.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uPaymentTerm.Index.UseCase,
  uSmartPointer,
  uPaymentTerm.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uPaymentTerm.StoreAndShow.UseCase,
  uPaymentTerm.UpdateAndShow.UseCase;

{ TPaymentTermController }

constructor TPaymentTermController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.PaymentTerm;
end;

procedure TPaymentTermController.Delete;
var
  lPK, lTenantId: Int64;
begin
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  TPaymentTermDeleteUseCase.Make(FRepository).Execute(lPK, lTenantId);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TPaymentTermController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  // Filtro
  lPageFilter := TPageFilter.Make.FromJsonString(FReq.Body);
  lPageFilter.AddWhere('payment_term.tenant_id', coEqual, FReq.Session<TMyClaims>.TenantId);

  // Pesquisar e retornar
  lIndexResult := TPaymentTermIndexUseCase.Make(FRepository).Execute(lPageFilter);
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TPaymentTermController.Show;
var
  lResult: Shared<TPaymentTermShowDTO>;
  lPK, lTenantId: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  lResult   := TPaymentTermShowUseCase
    .Make    (FRepository)
    .Execute (lPk, lTenantId);

  // Retorno
  case Assigned(lResult.Value) of
    True:  TRes.Success(FRes, lResult.Value);
    False: TRes.Success(FRes, Nil, HTTP_NOT_FOUND);
  end;
end;

procedure TPaymentTermController.Store;
var
  lInput: Shared<TPaymentTermDTO>;
  lResult: Shared<TPaymentTermShowDTO>;
begin
  // Validar DTO
  lInput := TPaymentTermDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
    tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  end;
  SwaggerValidator.Validate(lInput);

  // Inserir e retornar registro inserido
  lResult := TPaymentTermStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value);

  // Retorno
  TRes.Success(FRes, lResult.Value, HTTP_CREATED);
end;

procedure TPaymentTermController.Update;
var
  lInput: Shared<TPaymentTermDTO>;
  lResult: Shared<TPaymentTermShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lInput := TPaymentTermDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
    tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  end;
  SwaggerValidator.Validate(lInput);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lResult := TPaymentTermUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value, lPk);

  // Retorno
  TRes.Success(FRes, lResult.Value);
end;

end.

