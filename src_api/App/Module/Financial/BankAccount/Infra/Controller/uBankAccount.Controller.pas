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
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TBankAccountDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TBankAccountController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TBankAccountIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TBankAccountController.Show;
var
  lBankAccountShowDTO: Shared<TBankAccountShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lBankAccountShowDTO := TBankAccountShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lBankAccountShowDTO.Value);
end;

procedure TBankAccountController.Store;
var
  lBankAccountToStoreDTO: Shared<TBankAccountDTO>;
  lBankAccountShowDTO: Shared<TBankAccountShowDTO>;
begin
  // Validar DTO
  lBankAccountToStoreDTO := TBankAccountDTO.FromJSON(FReq.Body);
  lBankAccountToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lBankAccountToStoreDTO);

  // Inserir e retornar registro inserido
  lBankAccountShowDTO := TBankAccountStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lBankAccountToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lBankAccountShowDTO.Value, HTTP_CREATED);
end;

procedure TBankAccountController.Update;
var
  lBankAccountToUpdateDTO: Shared<TBankAccountDTO>;
  lBankAccountShowDTO: Shared<TBankAccountShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lBankAccountToUpdateDTO := TBankAccountDTO.FromJSON(FReq.Body);
  lBankAccountToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lBankAccountToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lBankAccountShowDTO := TBankAccountUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lBankAccountToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lBankAccountShowDTO.Value);
end;

end.

