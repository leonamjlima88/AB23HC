unit uCFOP.Controller;

interface

uses
  Horse,
  Horse.GBSwagger,
  GBSwagger.Path.Registry,
  GBSwagger.Path.Attributes,
  GBSwagger.Validator.Interfaces,
  uCFOP.Repository.Interfaces,
  uApplication.Types,
  uCFOP.Show.DTO,
  uCFOP.DTO,
  uResponse.DTO;

Type
  [SwagPath('cfops', 'CFOP')]
  TCFOPController = class
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FRepository: ICFOPRepository;
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
    [SwagResponse(HTTP_OK, TCFOPIndexResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Index;

    [SwagGET('/{id}', 'Localizar por ID')]
    [SwagParamPath('id', 'ID')]
    [SwagResponse(HTTP_OK, TCFOPShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Show;

    [SwagPOST('/', 'Incluir')]
    [SwagParamBody('body', TCFOPDTO)]
    [SwagResponse(HTTP_CREATED, TCFOPShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Store;

    [SwagPUT('/{id}', 'Atualizar')]
    [SwagParamPath('id', 'ID')]
    [SwagParamBody('body', TCFOPDTO)]
    [SwagResponse(HTTP_OK, TCFOPShowResponseDTO)]
    [SwagResponse(HTTP_BAD_REQUEST)]
    [SwagResponse(HTTP_INTERNAL_SERVER_ERROR)]
    procedure Update;
  end;

implementation

uses
  uRepository.Factory,
  uHlp,
  uCFOP.Delete.UseCase,
  uRes,
  uPageFilter,
  uIndexResult,
  uCFOP.Index.UseCase,
  uSmartPointer,
  uCFOP.Show.UseCase,
  XSuperObject,
  uMyClaims,
  uCFOP.StoreAndShow.UseCase,
  uCFOP.UpdateAndShow.UseCase;

{ TCFOPController }

constructor TCFOPController.Create(Req: THorseRequest; Res: THorseResponse);
begin
  FReq        := Req;
  FRes        := Res;
  FRepository := TRepositoryFactory.Make.CFOP;
end;

procedure TCFOPController.Delete;
var
  lPK: Int64;
begin
  lPK       := THlp.StrInt(FReq.Params['id']);
  TCFOPDeleteUseCase.Make(FRepository).Execute(lPK);
  TRes.Success(FRes, Nil, HTTP_NO_CONTENT);
end;

procedure TCFOPController.Index;
var
  lPageFilter: IPageFilter;
  lIndexResult: IIndexResult;
begin
  // Filtro
  lPageFilter := TPageFilter.Make.FromJsonString(FReq.Body);

  // Pesquisar e retornar
  lIndexResult := TCFOPIndexUseCase.Make(FRepository).Execute(lPageFilter);
  TRes.Success(FRes, lIndexResult.ToSuperObject);
end;

procedure TCFOPController.Show;
var
  lResult: Shared<TCFOPShowDTO>;
  lPK: Int64;
begin
  // Localizar registro
  lPK       := THlp.StrInt(FReq.Params['id']);
  lResult   := TCFOPShowUseCase
    .Make    (FRepository)
    .Execute (lPk);

  // Retorno
  case Assigned(lResult.Value) of
    True:  TRes.Success(FRes, lResult.Value);
    False: TRes.Success(FRes, Nil, HTTP_NOT_FOUND);
  end;
end;

procedure TCFOPController.Store;
var
  lInput: Shared<TCFOPDTO>;
  lResult: Shared<TCFOPShowDTO>;
begin
  // Validar DTO
  lInput := TCFOPDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    created_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  end;
  SwaggerValidator.Validate(lInput);

  // Inserir e retornar registro inserido
  lResult := TCFOPStoreAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value);

  // Retorno
  TRes.Success(FRes, lResult.Value, HTTP_CREATED);
end;

procedure TCFOPController.Update;
var
  lInput: Shared<TCFOPDTO>;
  lResult: Shared<TCFOPShowDTO>;
  lPK: Int64;
begin
  // Validar DTO
  lInput := TCFOPDTO.FromJSON(FReq.Body);
  With lInput.Value do
  begin
    updated_by_acl_user_id := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  end;
  SwaggerValidator.Validate(lInput);

  // Atualizar e retornar registro atualizado
  lPK := THlp.StrInt(FReq.Params['id']);
  lResult := TCFOPUpdateAndShowUseCase
    .Make    (FRepository)
    .Execute (lInput.Value, lPk);

  // Retorno
  TRes.Success(FRes, lResult.Value);
end;

end.

