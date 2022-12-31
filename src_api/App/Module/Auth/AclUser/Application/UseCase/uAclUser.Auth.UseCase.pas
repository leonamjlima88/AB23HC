unit uAclUser.Auth.UseCase;

interface

uses
  uAclUser.Auth.Login.DTO,
  uAclUser.Auth.ChangePassword.DTO,
  uAclUser.Auth.Me.DTO,
  uAclUser.Repository.Interfaces,
  uAclUser,
  uAppParam.Repository.Interfaces;

type
  IAclUserAuthUseCase = Interface
    ['{D22B97CE-3ABC-493A-9953-E5A8582EE7D1}']
    function Login(AInput: TAclUserAuthLoginDTO): TAclUserAuthMeDTO;
    function Logout(AInput: TAclUserAuthLoginDTO): Boolean;
    function ChangePassword(AInput: TAclUserAuthChangePasswordDTO): Boolean;
  end;

  TAclUserAuthUseCase = class(TInterfacedObject, IAclUserAuthUseCase)
  private
    FRepository: IAclUserRepository;
    FAppParamRepository: IAppParamRepository;
    constructor Create(ARepository: IAclUserRepository; AAppParamRepository: IAppParamRepository);
    function EntityToAclUserAuthMeDTO(AAclUser: TAclUser): TAclUserAuthMeDTO;
  public
    class function Make(ARepository: IAclUserRepository; AAppParamRepository: IAppParamRepository): IAclUserAuthUseCase;
    function Login(AInput: TAclUserAuthLoginDTO): TAclUserAuthMeDTO;
    function Logout(AInput: TAclUserAuthLoginDTO): Boolean;
    function ChangePassword(AInput: TAclUserAuthChangePasswordDTO): Boolean;
  end;

implementation

uses
  uSmartPointer,
  JOSE.Core.Builder,
  JOSE.Core.JWT,
  uHlp,
  uApplication.Types,
  System.SysUtils,
  uMyClaims,
  System.DateUtils,
  uPageFilter,
  uIndexResult,
  DataSet.Serialize,
  XSuperObject,
  uAppParam.DTO;

{ TAclUserAuthUseCase }

function TAclUserAuthUseCase.ChangePassword(AInput: TAclUserAuthChangePasswordDTO): Boolean;
var
  lAclUser: Shared<TAclUser>;
begin
  // Localizar o usuário
  lAclUser := FRepository.ShowByLoginAndPassword(AInput.login, THlp.Encrypt(ENCRYPTATION_KEY, AInput.current_password));
  if not Assigned(lAclUser.Value) then
    raise Exception.Create('Usuário não encontrado. Verifique suas credenciais e tente novamente.');

  // Alterar Senha do Usuário
  With lAclUser.Value do
  begin
    login_password := THlp.Encrypt(ENCRYPTATION_KEY, AInput.new_password);
    FRepository.Update(lAclUser, id);
  end;

  Result := True;
end;

constructor TAclUserAuthUseCase.Create(ARepository: IAclUserRepository; AAppParamRepository: IAppParamRepository);
begin
  inherited Create;
  FRepository         := ARepository;
  FAppParamRepository := AAppParamRepository;
end;

function TAclUserAuthUseCase.Login(AInput: TAclUserAuthLoginDTO): TAclUserAuthMeDTO;
const
  l10_MIN_MARGIN_OF_ERROR = -10;
var
  lJWT: Shared<TJWT>;
  lClaims: TMyClaims;
  lToken: String;
  lAclUser: TAclUser;
  lTokenIsExpired: Boolean;
begin
  // Procurar por usuário
  lAclUser := FRepository.ShowByLoginAndPassword(AInput.login, THlp.Encrypt(ENCRYPTATION_KEY, AInput.login_password));
  if not Assigned(lAclUser) then
    raise Exception.Create('Usuário não encontrado. Verifique suas credenciais e tente novamente.');

  Try
    // Se token do usuário ainda estiver ativo, deve retornar o mesmo token
    if not lAclUser.last_token.Trim.IsEmpty then
    Begin
      lTokenIsExpired := (IncMinute(lAclUser.last_expiration, l10_MIN_MARGIN_OF_ERROR) < Now);
      if not lTokenIsExpired then
      begin
        Result := EntityToAclUserAuthMeDTO(lAclUser);
        Exit;
      end;
    end;

    // Gerar novo token
    lJWT                := TJWT.Create(TMyClaims);
    lClaims             := TMyClaims(lJWT.Value.Claims);
    lClaims.Id          := lAclUser.id.ToString;
    lClaims.Name        := lAclUser.name;
    lClaims.Login       := lAclUser.login;
    lClaims.AclRoleId   := lAclUser.acl_role_id.ToString;
    lClaims.IsSuperuser := lAclUser.is_superuser.ToString;
    lClaims.TenantId    := lAclUser.acl_role.tenant_id.ToString;
    lClaims.Expiration  := IncHour(Now, 2);
    lToken              := TJOSE.SHA256CompactToken(JWT_KEY, lJWT);

    // Atualizar usuário com os dados do token
    lAclUser.last_token      := lToken;
    lAclUser.last_expiration := lClaims.Expiration;
    FRepository.Update(lAclUser, lAclUser.id);

    // Retornar Token
    Result := EntityToAclUserAuthMeDTO(lAclUser);
  finally
    lAclUser.Free;
  end;
end;

function TAclUserAuthUseCase.EntityToAclUserAuthMeDTO(AAclUser: TAclUser): TAclUserAuthMeDTO;
var
  lIndexResult: IIndexResult;
  lAppParamDTO: TAppParamDTO;
  lAux: String;
begin
  Result                 := TAclUserAuthMeDTO.Create;
  Result.id              := AAclUser.id;
  Result.name            := AAclUser.name;
  Result.login           := AAclUser.login;
  Result.acl_role_id     := AAclUser.acl_role_id;
  Result.is_superuser    := AAclUser.is_superuser;
  Result.last_token      := AAclUser.last_token;
  Result.last_expiration := AAclUser.last_expiration;
  Result.tenant_id       := AAclUser.acl_role.tenant_id;

  // Parâmetros
  lIndexResult := FAppParamRepository.Index(TPageFilter.Make
    .AddOrWhere('app_param.acl_role_id', coIsNull, '')
    .AddOrWhere('app_param.acl_role_id', coEqual, AAclUser.acl_role_id.ToString)
  );
  With lIndexResult.Data do
  begin
    while not DataSet.Eof do
    begin
      lAppParamDTO := TAppParamDTO.FromJSON(DataSet.ToJSONObjectString);
      Result.app_param_list.Add(lAppParamDTO);
      DataSet.Next;
    end;
  end;
end;

function TAclUserAuthUseCase.Logout(AInput: TAclUserAuthLoginDTO): Boolean;
var
  lAclUser: Shared<TAclUser>;
begin
  // Procurar por usuário
  lAclUser := FRepository.ShowByLoginAndPassword(AInput.login, THlp.Encrypt(ENCRYPTATION_KEY, AInput.login_password));
  if not Assigned(lAclUser.Value) then
    raise Exception.Create('Usuário não encontrado. Verifique suas credenciais e tente novamente.');

  // Resetar Token
  lAclUser.Value.last_token      := EmptyStr;
  lAclUser.Value.last_expiration := 0;
  FRepository.Update(lAclUser.Value, lAclUser.Value.id);

  Result := True;
end;

class function TAclUserAuthUseCase.Make(ARepository: IAclUserRepository; AAppParamRepository: IAppParamRepository): IAclUserAuthUseCase;
begin
  Result := Self.Create(ARepository, AAppParamRepository);
end;

end.
