unit uBrand.Request;

interface

uses
  Horse.Request,
  Horse.Response,
  uBrand;

type
  IBrandRequest = Interface
    ['{25E65E03-0F7B-4FD5-94B5-2B7A4F2EAB59}']
    function Validate: String;
    function ValidateAndMapToEntity: TBrand;
  end;

  TBrandRequest = class(TInterfacedObject, IBrandRequest)
  private
    FReq: THorseRequest;
    FRes: THorseResponse;
    FErrors: String;
    FExitOnError: Boolean;
    function HandleAttributes: IBrandRequest;
    function Handlebrand: IBrandRequest;
    constructor Create(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean);
  public
    class function Make(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean = True): IBrandRequest;
    function Validate: String;
    function ValidateAndMapToEntity: TBrand;
  end;

implementation

uses
  uFormRequest,
  System.SysUtils,
  uRes,
  uApplication.Types,
  XSuperObject,
  uHlp,
  uMyClaims;

{ TBrandRequest }

class function TBrandRequest.Make(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean): IBrandRequest;
begin
  Result := Self.Create(AReq, ARes, AExitOnError);
end;

constructor TBrandRequest.Create(AReq: THorseRequest; ARes: THorseResponse; AExitOnError: Boolean);
begin
  inherited Create;
  FReq         := AReq;
  FRes         := ARes;
  FExitOnError := AExitOnError;
end;

function TBrandRequest.HandleAttributes: IBrandRequest;
begin
  Result := Self;
  Handlebrand;
end;

function TBrandRequest.Handlebrand: IBrandRequest;
begin
  Result := Self;

  // Validar Requisição
  FErrors := FErrors + TFormRequest.Make(FReq.Body)
    .AddRule('name', 'required|string|max:100')
    .Validate;
end;

function TBrandRequest.Validate: String;
begin
  FErrors := EmptyStr;
  HandleAttributes;

  // Exibir erros de validação se existir
  if FExitOnError and (FErrors.Trim > EmptyStr) then
  begin
    TRes.Error(FRes, VALIDATION_ERROR, FErrors);
    Exit;
  end;
end;

function TBrandRequest.ValidateAndMapToEntity: TBrand;
var
  lAclUserPk: Int64;
  lBrand: TBrand;
begin
  Result := Nil;
  Validate;
  if FExitOnError and (FErrors.Trim > EmptyStr) then
    Exit;

  // Mapear Body para Entity
  lBrand := TBrand.FromJSON(FReq.Body);

  // Incluir usuário logado na entidade
  lAclUserPk := THlp.StrInt(FReq.Session<TMyClaims>.Id);
  case (THlp.StrInt(FReq.Params['id']) = 0) of
    True:  lBrand.created_by_acl_user_id := lAclUserPk;
    False: lBrand.updated_by_acl_user_id := lAclUserPk;
  end;

  Result := lBrand;
end;

end.
