unit uAclUser.Service;

interface

uses
  uPageFilter,
  uIndexResult,
  uAclUser,
  uAclUser.Repository.Interfaces,
  uAclUser.ChangePassword.DTO;

type
  IAclUserService = interface
    ['{E2081C48-3DBB-40DD-BADD-A4E0C905C694}']

    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): TAclUser;
    function Store(AAclUser: TAclUser; ADestroyEntity: Boolean = true): Int64;
    function Update(AAclUser: TAclUser; AId: Int64; ADestroyEntity: Boolean = true): Boolean;
    function ChangePassword(ADTO: TAclUserChangePasswordDTO): IAclUserService;
    function ShowByLoginAndPassword(ALogin, ALoginPassword: String): TAclUser;
    function Logout(ALogin, ALoginPassword: String): IAclUserService;

    /// <summary>
    ///   Login e gerar token JWT
    ///   <param name="ALogin"> Login [String] </param>
    ///   <param name="ALoginPassword"> Senha [String] </param>
    /// </summary>
    /// <returns> Retornar Token JWT [String] </returns>
    function Login(ALogin, ALoginPassword: String): String;
  end;

  TAclUserService = class(TInterfacedObject, IAclUserService)
  private
    FRepository: IAclUserRepository;
    constructor Create(ARepository: IAclUserRepository);
  public
    class function Make(ARepository: IAclUserRepository): IAclUserService;
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): TAclUser;
    function Store(AAclUser: TAclUser; ADestroyEntity: Boolean = true): Int64;
    function Update(AAclUser: TAclUser; AId: Int64; ADestroyEntity: Boolean = true): Boolean;
    function ChangePassword(ADTO: TAclUserChangePasswordDTO): IAclUserService;
    function ShowByLoginAndPassword(ALogin, ALoginPassword: String): TAclUser;
    function Login(ALogin, ALoginPassword: String): String;
    function Logout(ALogin, ALoginPassword: String): IAclUserService;
  end;

implementation

uses
  System.SysUtils,
  uHlp,
  uApplication.Types,
  uSmartPointer,
  JOSE.Core.Builder,
  JOSE.Core.JWT,
  System.DateUtils,
  uMyClaims,
  System.Classes;

{ TAclUserService }

function TAclUserService.ChangePassword(ADTO: TAclUserChangePasswordDTO): IAclUserService;
var
  lIndexResult: IIndexResult;
  lAclUser: Shared<TAclUser>;
begin
  Result := Self;

  // Localizar o usuário
  lIndexResult := Index(TPageFilter.Make
    .AddWhere('acl_user.login',          coEqual, ADTO.login)
    .AddWhere('acl_user.login_password', coEqual, THlp.Encrypt(ENCRYPTATION_KEY, ADTO.current_password))
  );
  if lIndexResult.Data.DataSet.IsEmpty then
    raise Exception.Create('Usuário não encontrado. Verifique suas credenciais e tente novamente.');

  // Alterar Senha do Usuário
  lAclUser := FRepository.Show(lIndexResult.Data.DataSet.FieldByName('id').AsLargeInt);
  With lAclUser.Value do
  begin
    login_password := THlp.Encrypt(ENCRYPTATION_KEY, ADTO.new_password);
    FRepository.Update(lAclUser, id);
  end;
end;

constructor TAclUserService.Create(ARepository: IAclUserRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAclUserService.Delete(AId: Int64): Boolean;
begin
  Result := FRepository.Delete(AId);
end;

function TAclUserService.Index(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

function TAclUserService.Login(ALogin, ALoginPassword: String): String;
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
  lAclUser := ShowByLoginAndPassword(ALogin, ALoginPassword);
  if not Assigned(lAclUser) then
    raise Exception.Create('Usuário não encontrado. Verifique suas credenciais e tente novamente.');

  // Se token do usuário ainda estiver ativo, deve retornar o mesmo token
  if not lAclUser.last_token.Trim.IsEmpty then
  Begin
    lTokenIsExpired := (IncMinute(lAclUser.last_expiration, l10_MIN_MARGIN_OF_ERROR) < Now);
    if not lTokenIsExpired then
    begin
      Result := lAclUser.last_token;
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
  lClaims.Expiration  := IncHour(Now, 2);
  lToken              := TJOSE.SHA256CompactToken(JWT_KEY, lJWT);

  // Atualizar usuário com os dados do token
  lAclUser.last_token      := lToken;
  lAclUser.last_expiration := lClaims.Expiration;
  Update(lAclUser, lAclUser.id);

  // Retornar Token
  Result := lToken;
end;

function TAclUserService.Logout(ALogin, ALoginPassword: String): IAclUserService;
var
  lIndexResult: IIndexResult;
  lAclUser: TAclUser;
begin
  Result := Self;

  // Procurar por usuário
  lAclUser := ShowByLoginAndPassword(ALogin, ALoginPassword);
  if not Assigned(lAclUser) then
    raise Exception.Create('Usuário não encontrado. Verifique suas credenciais e tente novamente.');

  // Resetar Token
  lAclUser.last_token      := EmptyStr;
  lAclUser.last_expiration := 0;
  Update(lAclUser, lAclUser.id);
end;

class function TAclUserService.Make(ARepository: IAclUserRepository): IAclUserService;
begin
  Result := Self.Create(ARepository);
end;

function TAclUserService.Show(AId: Int64): TAclUser;
begin
  Result := FRepository.Show(AId);
end;

function TAclUserService.ShowByLoginAndPassword(ALogin, ALoginPassword: String): TAclUser;
var
  lEncryptPassword: String;
  lIndexResult: IIndexResult;
begin
  // Procurar por usuário
  lEncryptPassword := THlp.Encrypt(ENCRYPTATION_KEY, ALoginPassword);
  lIndexResult := FRepository.Index(
    TPageFilter.Make
      .AddWhere('acl_user.login',          coEqual, ALogin)
      .AddWhere('acl_user.login_password', coEqual, lEncryptPassword)
  );
  if not lIndexResult.Data.DataSet.IsEmpty then
    Result := FRepository.Show(lIndexResult.Data.DataSet.FieldByName('id').AsLargeInt);
end;

function TAclUserService.Store(AAclUser: TAclUser; ADestroyEntity: Boolean): Int64;
begin
  AAclUser.login_password := THlp.Encrypt(ENCRYPTATION_KEY, AAclUser.login_password);
  Result := FRepository.Store(AAclUser);

  // Destruir entidade
  if ADestroyEntity then
    FreeAndNil(AAclUser);
end;

function TAclUserService.Update(AAclUser: TAclUser; AId: Int64; ADestroyEntity: Boolean): Boolean;
var
  lAclUserFound: Shared<TAclUser>;
begin
  // Sempre manter senha já cadastrada na atualização
  lAclUserFound := Show(AId);
  case Assigned(lAclUserFound.Value) of
    True:  AAclUser.login_password := lAclUserFound.Value.login_password;
    False: raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [AId]));
  end;

  // Atualizar
  Result := FRepository.Update(AAclUser, AId);

  // Destruir entidade
  if ADestroyEntity then
    FreeAndNil(AAclUser);
end;

end.


