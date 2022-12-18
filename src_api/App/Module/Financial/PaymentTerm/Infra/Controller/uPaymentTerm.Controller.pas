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
  [SwagPath('payment_terms', 'Condição de Pagamento')]
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
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TPaymentTermDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TPaymentTermController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TPaymentTermIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TPaymentTermController.Show;
var
  lPaymentTermShowDTO: Shared<TPaymentTermShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lPaymentTermShowDTO := TPaymentTermShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lPaymentTermShowDTO.Value);
end;

procedure TPaymentTermController.Store;
var
  lPaymentTermToStoreDTO: Shared<TPaymentTermDTO>;
  lPaymentTermShowDTO: Shared<TPaymentTermShowDTO>;
begin
  // Validar DTO
  lPaymentTermToStoreDTO := TPaymentTermDTO.FromJSON(FReq.Body);
  lPaymentTermToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lPaymentTermToStoreDTO);

  // Inserir e retornar registro inserido
  lPaymentTermShowDTO := TPaymentTermStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lPaymentTermToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lPaymentTermShowDTO.Value, HTTP_CREATED);
end;

procedure TPaymentTermController.Update;
var
  lPaymentTermToUpdateDTO: Shared<TPaymentTermDTO>;
  lPaymentTermShowDTO: Shared<TPaymentTermShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lPaymentTermToUpdateDTO := TPaymentTermDTO.FromJSON(FReq.Body);
  lPaymentTermToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lPaymentTermToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lPaymentTermShowDTO := TPaymentTermUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lPaymentTermToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lPaymentTermShowDTO.Value);
end;

end.

