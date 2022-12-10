unit uBrand.Request.Old;

interface

uses
  uBase.Request,
  uBrand,
  Horse.Response,
  Horse.Request;

type
  IBrandRequest = interface
    ['{21A541AD-C358-4952-83BE-58A4E4B2A89C}']
    function ValidateAndMapToEntity: TBrand;
  end;

  TBrandRequest = class(TBaseRequest, IBrandRequest)
  private
    procedure HandleAttributes; override;
    procedure HandleBrand;
    Constructor Create(const AReq: THorseRequest; const ARes: THorseResponse);
  public
    class function Make(const AReq: THorseRequest; const ARes: THorseResponse): IBrandRequest;
    function ValidateAndMapToEntity: TBrand;
  end;

implementation

uses
  System.SysUtils,
  XSuperObject,
  uRes,
  uApplication.Types,
  uHlp,
  uMyClaims;

{ TBrandRequest }

procedure TBrandRequest.HandleBrand;
begin
  Self
    .AddRule('name', 'required|string|max:100')
    .ExecuteRules;
end;

function TBrandRequest.ValidateAndMapToEntity: TBrand;
var
  lAclUserPk: Int64;
  lBrand: TBrand;
begin
  Result := Nil;

  // Validar requisição
  if not Validate.IsEmpty then
  begin
    TRes.Error(Res, VALIDATION_ERROR, Errors);
    Exit;
  end;

  // Mapear Body para Entity
  lBrand := TBrand.FromJSON(Body);

  // Incluir usuário logado na entidade
  lAclUserPk := THlp.StrInt(Req.Session<TMyClaims>.Id);
  case (THlp.StrInt(Req.Params['id']) = 0) of
    True:  lBrand.created_by_acl_user_id := lAclUserPk;
    False: lBrand.updated_by_acl_user_id := lAclUserPk;
  end;

  Result := lBrand;
end;

constructor TBrandRequest.Create(const AReq: THorseRequest; const ARes: THorseResponse);
begin
  inherited Create(AReq, ARes);
end;

procedure TBrandRequest.HandleAttributes;
begin
  HandleBrand;
end;

class function TBrandRequest.Make(const AReq: THorseRequest; const ARes: THorseResponse): IBrandRequest;
begin
  Result := Self.Create(AReq, ARes);
end;

end.
