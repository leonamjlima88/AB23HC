unit uAclUser.Controller;

interface

uses
  Horse;

type
  TAclUserController = class
  public
    class procedure Registry;
    class procedure Index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Show(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Query(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure ChangePassword(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Logout(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Me(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  end;

implementation

uses
  uAclUser.Service,
  uHlp,
  uRes,
  uApplication.Types,
  uPageFilter,
  System.SysUtils,
  XSuperObject,
  uSmartPointer,
  uAclUser,
  uAclUser.Resource,
  uAclUser.Store.Request,
  uAclUser.Update.Request,
  DataSet.Serialize,
  uAclUser.ChangePassword.Request,
  uAclUser.ChangePassword.DTO,
  uMyClaims,
  uRepository.Factory;

{ TAclUserController }

class procedure TAclUserController.Registry;
begin
  THorse.Get    ('/acl_user',              Index          );
  THorse.Get    ('/acl_user/:id',          Show           );
  THorse.Post   ('/acl_user',              Store          );
  THorse.Put    ('/acl_user/:id',          Update         );
  THorse.Delete ('/acl_user/:id',          Delete         );
  THorse.Post   ('/acl_user/query',        Query          );
  THorse.Put    ('/auth/change_password',  ChangePassword );
  THorse.Post   ('/auth/login',            Login          );
  THorse.Post   ('/auth/logout',           Logout         );
  THorse.Post   ('/auth/me',               Me             );
end;

class procedure TAclUserController.ChangePassword(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lDTO: Shared<TAclUserChangePasswordDTO>;
begin
  // Validar Requisição
  lDTO := TAclUserChangePasswordRequest.Make(Req, Res).ValidateAndMapToEntity;
  if not Assigned(lDTO.Value) then Exit;

  // Alterar Senha
  TAclUserService.Make(TRepositoryFactory.Make.AclUser).ChangePassword(lDTO);
  TRes.Success(Res, Nil, HTTP_NO_CONTENT);
end;

class procedure TAclUserController.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lPk: Int64;
  lAclUserService: IAclUserService;
begin
  lPk             := THlp.StrInt(Req.Params['id']);
  lAclUserService := TAclUserService.Make(TRepositoryFactory.Make.AclUser);

  // Deletar Registro
  lAclUserService.Delete(lPk);
  TRes.Success(Res, Nil, HTTP_NO_CONTENT);
end;

class procedure TAclUserController.Index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  With TAclUserService.Make(TRepositoryFactory.Make.AclUser).Index(nil) do
  begin
    Data.DataSet.FieldByName('login_password').Visible  := False;
    Data.DataSet.FieldByName('last_token').Visible      := False;
    Data.DataSet.FieldByName('last_expiration').Visible := False;
    TRes.Success(Res, ToSuperObject);
  end;
end;

class procedure TAclUserController.Login(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lSObj: ISuperObject;
  lTokenJWTStr: String;
begin
  lSObj := SO(Req.Body);

  // Gerar Token JWT
  lTokenJWTStr := TAclUserService.Make(TRepositoryFactory.Make.AclUser)
    .Login(
      lSObj['login'].AsString,
      lSObj['login_password'].AsString
    );

  // Retornar Token JWT
  lSObj := SO;
  lSObj.S['token'] := lTokenJWTStr;
  TRes.Success(Res, lSObj);
end;

class procedure TAclUserController.Logout(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lSObj: ISuperObject;
  lClaims: TMyClaims;
begin
  lSObj := SO(Req.Body);

  // Efetuar Logout
  TAclUserService.Make(TRepositoryFactory.Make.AclUser)
    .Logout(
      lSObj['login'].AsString,
      lSObj['login_password'].AsString
    );

  lClaims := Req.Session<TMyClaims>;
  lClaims.Expiration := now;

  // Retornar mensagem com sucesso.
  TRes.Success(Res, Nil, HTTP_NO_CONTENT);
end;

class procedure TAclUserController.Me(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lClaims: TMyClaims;
begin
  lClaims := Req.Session<TMyClaims>;
  TRes.Success(Res, Format('I’m %s and this is my login %s',[LClaims.Name, LClaims.Login]));
end;

class procedure TAclUserController.Query(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lPageFilter: IPageFilter;
  lBodyIsEmpty: Boolean;
begin
  // Filtro de Pesquisa
  lBodyIsEmpty := (Req.Body = '{}') or (Req.Body.Trim.IsEmpty);
  if not lBodyIsEmpty then
    lPageFilter := TPageFilter.Make.FromSuperObject(SO(Req.Body));

  // Pesquisar
  With TAclUserService.Make(TRepositoryFactory.Make.AclUser).Index(lPageFilter) do
  begin
    Data.DataSet.FieldByName('login_password').Visible  := False;
    Data.DataSet.FieldByName('last_token').Visible      := False;
    Data.DataSet.FieldByName('last_expiration').Visible := False;
    TRes.Success(Res, ToSuperObject);
  end;
end;

class procedure TAclUserController.Show(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lPk: Int64;
  lAclUserService: IAclUserService;
  lAclUserFound: Shared<TAclUser>;
begin
  lPk             := THlp.StrInt(Req.Params['id']);
  lAclUserService := TAclUserService.Make(TRepositoryFactory.Make.AclUser);

  // Localizar registro
  lAclUserFound := lAclUserService.Show(lPk);
  case Assigned(lAclUserFound.Value) of
    True:  TRes.Success(Res, TAclUserResource.Make(lAclUserFound).Execute);
    False: TRes.Error(Res, Format(RECORD_NOT_FOUND_WITH_ID, [lPk]));
  end;
end;

class procedure TAclUserController.Store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lAclUserToStore: TAclUser;
  lAclUserService: IAclUserService;
  lPk: Int64;
  lAclUserFound: Shared<TAclUser>;
begin
  // Validar Requisição
  lAclUserToStore := TAclUserStoreRequest.Make(Req, Res).ValidateAndMapToEntity;
  if not Assigned(lAclUserToStore) then Exit;

  // Incluir registro
  lAclUserService := TAclUserService.Make(TRepositoryFactory.Make.AclUser);
  lPk             := lAclUserService.Store(lAclUserToStore);

  // Retornar registro incluso
  lAclUserFound := lAclUserService.Show(lPk);
  TRes.Success(Res, TAclUserResource.Make(lAclUserFound).Execute, HTTP_CREATED);
end;

class procedure TAclUserController.Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lAclUserToUpdate: TAclUser;
  lPk: Int64;
  lAclUserService: IAclUserService;
  lAclUserFound: Shared<TAclUser>;
begin
  // Validar Requisição
  lAclUserToUpdate := TAclUserUpdateRequest.Make(Req, Res).ValidateAndMapToEntity;
  if not Assigned(lAclUserToUpdate) then Exit;

  // Atualizar registro
  lPk             := THlp.StrInt(Req.Params['id']);
  lAclUserService := TAclUserService.Make(TRepositoryFactory.Make.AclUser);
  lAclUserService.Update(lAclUserToUpdate, lPk);

  // Retornar registro atualizado
  lAclUserFound := lAclUserService.Show(lPk);
  case Assigned(lAclUserFound.Value) of
    True:  TRes.Success(Res, TAclUserResource.Make(lAclUserFound).Execute);
    False: TRes.Error(Res, Format(RECORD_NOT_FOUND_WITH_ID, [lPk]));
  end;
end;

end.
