unit uBrand.Controller;

interface

uses
  Horse;

Type
  TBrandController = class
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
  uBrand.Service,
  uHlp,
  uRes,
  uApplication.Types,
  uPageFilter,
  System.SysUtils,
  XSuperObject,
  uBrand,
  uSmartPointer,
  uBrand.Resource,
  uBrand.Request,
  uRepository.Factory;

{ TBrandController }

class procedure TBrandController.Registry;
begin
  THorse.Get    ('/brand',       Index  );
  THorse.Get    ('/brand/:id',   Show   );
  THorse.Post   ('/brand',       Store  );
  THorse.Put    ('/brand/:id',   Update );
  THorse.Delete ('/brand/:id',   Delete );
  THorse.Post   ('/brand/query', Query  );
end;

class procedure TBrandController.Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lPk: Int64;
  lBrandService: IBrandService;
begin
  lPk           := THlp.StrInt(Req.Params['id']);
  lBrandService := TBrandService.Make(TRepositoryFactory.Make.Brand);

  // Deletar Registro
  lBrandService.Delete(lPk);
  TRes.Success(Res, Nil, HTTP_NO_CONTENT);
end;

class procedure TBrandController.Index(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  TRes.Success(Res, TBrandService.Make(TRepositoryFactory.Make.Brand).Index(nil).ToSuperObject);
end;

class procedure TBrandController.Query(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lPageFilter: IPageFilter;
  lBodyIsEmpty: Boolean;
begin
  // Filtro de Pesquisa
  lBodyIsEmpty := (Req.Body = '{}') or (Req.Body.Trim.IsEmpty);
  if not lBodyIsEmpty then
    lPageFilter := TPageFilter.Make.FromSuperObject(SO(Req.Body));

  // Pesquisar
  TRes.Success(Res, TBrandService.Make(TRepositoryFactory.Make.Brand).Index(lPageFilter).ToSuperObject);
end;

class procedure TBrandController.Show(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lPk: Int64;
  lBrandService: IBrandService;
  lBrandFound: Shared<TBrand>;
begin
  lPk           := THlp.StrInt(Req.Params['id']);
  lBrandService := TBrandService.Make(TRepositoryFactory.Make.Brand);

  // Localizar registro
  lBrandFound := lBrandService.Show(lPk);
  case Assigned(lBrandFound.Value) of
    True:  TRes.Success (Res, TBrandResource.Make(lBrandFound).Execute);
    False: TRes.Error   (Res, Format(RECORD_NOT_FOUND_WITH_ID, [lPk]));
  end;
end;

class procedure TBrandController.Store(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBrandToStore: TBrand;
  lBrandService: IBrandService;
  lPk: Int64;
  lBrandFound: Shared<TBrand>;
begin
  // Validar Requisição
  lBrandToStore := TBrandRequest.Make(Req, Res).ValidateAndMapToEntity;
  if not Assigned(lBrandToStore) then Exit;

  // Incluir registro
  lBrandService := TBrandService.Make(TRepositoryFactory.Make.Brand);
  lPk           := lBrandService.Store(lBrandToStore);

  // Retornar registro incluso
  lBrandFound   := lBrandService.Show(lPk);
  TRes.Success(Res, TBrandResource.Make(lBrandFound).Execute, HTTP_CREATED);
end;

class procedure TBrandController.Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lBrandToUpdate: TBrand;
  lPk: Int64;
  lBrandService: IBrandService;
  lBrandFound: Shared<TBrand>;
begin
  // Validar Requisição
  lBrandToUpdate := TBrandRequest.Make(Req, Res).ValidateAndMapToEntity;
  if not Assigned(lBrandToUpdate) then Exit;

  // Atualizar registro
  lPk           := THlp.StrInt(Req.Params['id']);
  lBrandService := TBrandService.Make(TRepositoryFactory.Make.Brand);
  lBrandService.Update(lBrandToUpdate, lPk);

  // Retornar registro atualizado
  lBrandFound := lBrandService.Show(lPk);
  case Assigned(lBrandFound.Value) of
    True:  TRes.Success (Res, TBrandResource.Make(lBrandFound).Execute);
    False: TRes.Error   (Res, Format(RECORD_NOT_FOUND_WITH_ID, [lPk]));
  end;
end;

end.

