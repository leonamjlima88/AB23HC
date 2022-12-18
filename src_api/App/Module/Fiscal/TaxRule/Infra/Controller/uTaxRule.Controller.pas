unit uTaxRule.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uTaxRule.Repository.Interfaces,
  uApplication.Types,
  uTaxRule.Show.DTO,
  uTaxRule.DTO,
  uResponse.DTO;

Type
  [SwagPath('tax_rules', 'Regra Fiscal')]
  TTaxRuleController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: ITaxRuleRepository;
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
    [SwagResponse(HTTP_OK, TTaxRuleIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TTaxRuleShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TTaxRuleDTO)]
    [SwagResponse(HTTP_CREATED, TTaxRuleShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TTaxRuleDTO)]
    [SwagResponse(HTTP_OK, TTaxRuleShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uTaxRule.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uTaxRule.Index.UseCase,
  uSmartPointer,
  uTaxRule.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uTaxRule.StoreAndShow.UseCase,
  uTaxRule.UpdateAndShow.UseCase,
  System.SysUtils;

{ TTaxRuleController }

constructor TTaxRuleController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.TaxRule;
end;

procedure TTaxRuleController.Delete;
var
  lPK: Int64;
begin
  lPK := THlp.StrInt(FReq.Params['id']);
  TTaxRuleDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TTaxRuleController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  lPageFilter  := TPageFilter.Make.FromJsonString(FReq.Body);
  lIndexResult := TTaxRuleIndexUseCase.Make(FRepository).Execute(lPageFilter);

  // Pesquisar
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TTaxRuleController.Show;
var
  lTaxRuleShowDTO: Shared<TTaxRuleShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK := THlp.StrInt(FReq.Params['id']);
  lTaxRuleShowDTO := TTaxRuleShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  TRes.Success(FRes, lTaxRuleShowDTO.Value);
end;

procedure TTaxRuleController.Store;
var
  lTaxRuleToStoreDTO: Shared<TTaxRuleDTO>;
  lTaxRuleShowDTO: Shared<TTaxRuleShowDTO>;
begin
  // Validar DTO
  lTaxRuleToStoreDTO := TTaxRuleDTO.FromJSON(FReq.Body);
  lTaxRuleToStoreDTO.Value.created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lTaxRuleToStoreDTO);

  // Inserir e retornar registro inserido
  lTaxRuleShowDTO := TTaxRuleStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lTaxRuleToStoreDTO.Value);

  // Retorno
  TRes.Success(FRes, lTaxRuleShowDTO.Value, HTTP_CREATED);
end;

procedure TTaxRuleController.Update;
var
  lTaxRuleToUpdateDTO: Shared<TTaxRuleDTO>;
  lTaxRuleShowDTO: Shared<TTaxRuleShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lTaxRuleToUpdateDTO := TTaxRuleDTO.FromJSON(FReq.Body);
  lTaxRuleToUpdateDTO.Value.updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  SwaggerValidator.Validate(lTaxRuleToUpdateDTO);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lTaxRuleShowDTO := TTaxRuleUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lTaxRuleToUpdateDTO.Value, lPk);

  // Retorno
  TRes.Success(FRes, lTaxRuleShowDTO.Value);
end;

end.

