unit uAclRole.Controller;

interface

uses
  Horse;

Type
  TAclRoleController = class
  public
    class procedure Registry;
    class procedure Index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Show(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
    class procedure Query(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  end;

implementation

uses
  uAclRole.Service,
  uHlp,
  uRes,
  uApplication.Types,
  uPageFilter,
  System.SysUtils,
  XSuperObject,
  uAclRole,
  uSmartPointer,
  uAclRole.Resource,
  uAclRole.Request,
  uRepository.Factory;

{ TAclRoleController }

class procedure TAclRoleController.Registry;
begin
  THorse.Get    ('/acl_role',       Index  );
  THorse.Get    ('/acl_role/:id',   Show   );
  THorse.Post   ('/acl_role',       Store  );
  THorse.Put    ('/acl_role/:id',   Update );
  THorse.Delete ('/acl_role/:id',   Delete );
  THorse.Post   ('/acl_role/query', Query  );
end;

class procedure TAclRoleController.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lPk: Int64;
  lAclRoleService: IAclRoleService;
begin
  lPk             := THlp.StrInt(Req.Params['id']);
  lAclRoleService := TAclRoleService.Make(TRepositoryFactory.Make.AclRole);

  // Deletar Registro
  lAclRoleService.Delete(lPk);
  TRes.Success(Res, Nil, HTTP_NO_CONTENT);
end;

class procedure TAclRoleController.Index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  TRes.Success(Res, TAclRoleService.Make(TRepositoryFactory.Make.AclRole).Index(nil).ToSuperObject);
end;

class procedure TAclRoleController.Query(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lPageFilter: IPageFilter;
  lBodyIsEmpty: Boolean;
begin
  // Filtro de Pesquisa
  lBodyIsEmpty := (Req.Body = '{}') or (Req.Body.Trim.IsEmpty);
  if not lBodyIsEmpty then
    lPageFilter := TPageFilter.Make.FromSuperObject(SO(Req.Body));

  // Pesquisar
  TRes.Success(Res, TAclRoleService.Make(TRepositoryFactory.Make.AclRole).Index(lPageFilter).ToSuperObject);
end;

class procedure TAclRoleController.Show(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lPk: Int64;
  lAclRoleService: IAclRoleService;
  lAclRoleFound: Shared<TAclRole>;
begin
  lPk             := THlp.StrInt(Req.Params['id']);
  lAclRoleService := TAclRoleService.Make(TRepositoryFactory.Make.AclRole);

  // Localizar registro
  lAclRoleFound := lAclRoleService.Show(lPk);
  case Assigned(lAclRoleFound.Value) of
    True:  TRes.Success (Res, TAclRoleResource.Make(lAclRoleFound).Execute);
    False: TRes.Error   (Res, Format(RECORD_NOT_FOUND_WITH_ID, [lPk]));
  end;
end;

class procedure TAclRoleController.Store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lAclRoleToStore: TAclRole;
  lAclRoleService: IAclRoleService;
  lPk: Int64;
  lAclRoleFound: Shared<TAclRole>;
begin
  // Validar Requisição
  lAclRoleToStore := TAclRoleRequest.Make(Req, Res).ValidateAndMapToEntity;
  if not Assigned(lAclRoleToStore) then Exit;

  // Incluir registro
  lAclRoleService := TAclRoleService.Make(TRepositoryFactory.Make.AclRole);
  lPk             := lAclRoleService.Store(lAclRoleToStore);

  // Retornar registro incluso
  lAclRoleFound   := lAclRoleService.Show(lPk);
  TRes.Success(Res, TAclRoleResource.Make(lAclRoleFound).Execute, HTTP_CREATED);
end;

class procedure TAclRoleController.Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lAclRoleToUpdate: TAclRole;
  lPk: Int64;
  lAclRoleService: IAclRoleService;
  lAclRoleFound: Shared<TAclRole>;
begin
  // Validar Requisição
  lAclRoleToUpdate := TAclRoleRequest.Make(Req, Res).ValidateAndMapToEntity;
  if not Assigned(lAclRoleToUpdate) then Exit;

  // Atualizar registro
  lPk           := THlp.StrInt(Req.Params['id']);
  lAclRoleService := TAclRoleService.Make(TRepositoryFactory.Make.AclRole);
  lAclRoleService.Update(lAclRoleToUpdate, lPk);

  // Retornar registro atualizado
  lAclRoleFound := lAclRoleService.Show(lPk);
  case Assigned(lAclRoleFound.Value) of
    True:  TRes.Success (Res, TAclRoleResource.Make(lAclRoleFound).Execute);
    False: TRes.Error   (Res, Format(RECORD_NOT_FOUND_WITH_ID, [lPk]));
  end;
end;

end.

