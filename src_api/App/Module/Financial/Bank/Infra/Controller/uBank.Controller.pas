unit uBank.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uBank.Repository.Interfaces,
  uApplication.Types,
  uBank.Show.DTO,
  uBank.DTO,
  uResponse.DTO;

Type
  [SwagPath('banks', 'Banco')]
  TBankController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: IBankRepository;
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
    [SwagResponse(HTTP_OK, TBankIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TBankShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TBankDTO)]
    [SwagResponse(HTTP_CREATED, TBankShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TBankDTO)]
    [SwagResponse(HTTP_OK, TBankShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uBank.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uBank.Index.UseCase,
  uSmartPointer,
  uBank.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uBank.StoreAndShow.UseCase,
  uBank.UpdateAndShow.UseCase;

{ TBankController }

constructor TBankController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.Bank;
end;

procedure TBankController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TBankDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TBankController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TBankIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TBankController.Show;
var
  lBankShowDTO: Shared<TBankShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lBankShowDTO := TBankShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lBankShowDTO.Value);
end;

procedure TBankController.Store;
var
  lBankToStoreDTO: Shared<TBankDTO>;
  lBankShowDTO: Shared<TBankShowDTO>;
begin
  // Validar DTO
  lBankToStoreDTO := TBankDTO.FromJSON(FReq.Body);
  lBankToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lBankToStoreDTO);

  // Inserir e retornar registro inserido
  lBankShowDTO := TBankStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lBankToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lBankShowDTO.Value, HTTP_CREATED);
end;

procedure TBankController.Update;
var
  lBankToUpdateDTO: Shared<TBankDTO>;
  lBankShowDTO: Shared<TBankShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lBankToUpdateDTO := TBankDTO.FromJSON(FReq.Body);
  lBankToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lBankToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lBankShowDTO := TBankUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lBankToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lBankShowDTO.Value);
end;

end.

