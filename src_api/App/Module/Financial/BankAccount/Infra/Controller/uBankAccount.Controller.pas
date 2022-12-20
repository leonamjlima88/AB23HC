unit uBankAccount.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uBankAccount.Repository.Interfaces,
  uApplication.Types,
  uBankAccount.Show.DTO,
  uBankAccount.DTO,
  uResponse.DTO;

Type
  [SwagPath('bank_accounts', 'Conta Bancária')]
  TBankAccountController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IBankAccountRepository;
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
    [SwagResponse(HTTP_OK, TBankAccountIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TBankAccountShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TBankAccountDTO)]
    [SwagResponse(HTTP_CREATED, TBankAccountShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TBankAccountDTO)]
    [SwagResponse(HTTP_OK, TBankAccountShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uBankAccount.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uBankAccount.Index.UseCase,
  uSmartPointer,
  uBankAccount.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uBankAccount.StoreAndShow.UseCase,
  uBankAccount.UpdateAndShow.UseCase;

{ TBankAccountController }

constructor TBankAccountController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.BankAccount;
end;

procedure TBankAccountController.Delete;
var
  lPK, lTenantId: Int64;
begin
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  TBankAccountDeleteUseCase.Make(FRepository).Execute(lPK, lTenantId);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TBankAccountController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter := TPageFilter.Make.FromJsonString(FReq.Body);
  lPageFilter.AddWhere('bank_account.tenant_id', coEqual, FReq.Session<TMyClaims>.TenantId);
  lIndexResult := TBankAccountIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TBankAccountController.Show;
var
  lResult: Shared<TBankAccountShowDTO>;
  lPK, lTenantId: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lTenantId := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  lResult   := TBankAccountShowUseCase
    .Make    (FRepository)
    .Execute (lPk, lTenantId);

  // Retorno
  TRes.Success(FRes, lResult.Value);
end;

procedure TBankAccountController.Store;
var
  lInput: Shared<TBankAccountDTO>;
  lResult: Shared<TBankAccountShowDTO>;
begin
  // Validar DTO
  lInput := TBankAccountDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
    tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  end;
  SwaggerValidator.Validate(lInput);

  // Inserir e retornar registro inserido
  lResult := TBankAccountStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value);

  // Retorno
  TRes.Success(FRes, lResult.Value, HTTP_CREATED);
end;

procedure TBankAccountController.Update;
var
  lInput: Shared<TBankAccountDTO>;
  lResult: Shared<TBankAccountShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lInput := TBankAccountDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
    tenant_id              := THlp.StrInt(FReq.Session<TMyClaims>.TenantId);
  end;
  SwaggerValidator.Validate(lInput);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lResult := TBankAccountUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value, lPk);

  // Retorno
  TRes.Success(FRes, lResult.Value);
end;

end.

