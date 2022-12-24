unit uBrand.Service;

interface

uses
  uBrand,
  uZLMemTable.Interfaces,
  uReq,
  uEither;

type
  IBrandService = Interface
    ['{87DB5C73-D62B-4C23-B730-1CCDEB79D11E}']
    function Delete(const AId: Int64): Boolean;
    function Index: IZLMemTable;
    function Show(const AId: Int64): TBrand;
    function Store(const ABrand: TBrand): Either<String, TBrand>;
    function Update(const ABrand: TBrand; const AId: Int64): Either<String, TBrand>;
  end;

  TBrandService = class(TInterfacedObject, IBrandService)
  private
    FRes: IRes;
  public
    class function Make: IBrandService;
    function Delete(const AId: Int64): Boolean;
    function Index: IZLMemTable;
    function Show(const AId: Int64): TBrand;
    function Store(const ABrand: TBrand): Either<String, TBrand>;
    function Update(const ABrand: TBrand; const AId: Int64): Either<String, TBrand>;
    function CreateMemTableStructureForIndex: IZLMemTable;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  Data.DB,
  uMemTable.Factory;

const
  ENDPOINT = '/brands/';

{ TBrandService }

function TBrandService.CreateMemTableStructureForIndex: IZLMemTable;
begin
  Result := TMemTableFactory.Make
    .AddField('id',                     ftLargeint)
    .AddField('name',                   ftString, 100)
    .AddField('created_at',             ftDateTime)
    .AddField('updated_at',             ftDateTime)
    .AddField('created_by_acl_user_id', ftLargeint)
    .AddField('updated_by_acl_user_id', ftLargeint);
end;

function TBrandService.Delete(const AId: Int64): Boolean;
begin
  // Efetuar requisição
  TReq.Make(ENDPOINT+AId.ToString).Execute(rtDelete);
  Result := True;
end;

function TBrandService.Index: IZLMemTable;
begin
  // Efetuar requisição
  FRes := TReq.Make(ENDPOINT+'/index').Execute(rtPost);

  // Falha na requisição
  if not (FRes.StatusCode = 200) then
    raise Exception.Create(SO(FRes.Content).S['message']);

  // Retornar Lista
  Result := CreateMemTableStructureForIndex;
  Result.FromJsonString(SO(FRes.Content).O['data'].A['result'].AsJSON);
end;

class function TBrandService.Make: IBrandService;
begin
  Result := Self.Create;
end;

function TBrandService.Show(const AId: Int64): TBrand;
begin
  Result := nil;

  // Efetuar requisição
  FRes := TReq.Make(ENDPOINT+AId.ToString).Execute(rtGet);

  // Falha na requisição
  if (FRes.StatusCode = 404) then
    Exit;

  if not (FRes.StatusCode = 200) then
    raise Exception.Create(SO(FRes.Content).S['message']);

  // Retornar registro localizado
  Result := TBrand.FromJSON(SO(FRes.Content).O['data']);
end;

function TBrandService.Store(const ABrand: TBrand): Either<String, TBrand>;
var
  lErrors: String;
begin
  // Validar antes de Incluir
  lErrors := ABrand.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisição
  FRes := TReq.Make(ENDPOINT, ABrand.AsJSON).Execute(rtPost);

  // Falha na requisição
  if not (FRes.StatusCode = 201) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro incluso
  Result := TBrand.FromJSON(SO(FRes.Content).O['data']);
end;

function TBrandService.Update(const ABrand: TBrand; const AId: Int64): Either<String, TBrand>;
var
  lErrors: String;
begin
  // Validar antes de Atualizar
  ABrand.id := AId;
  lErrors   := ABrand.Validate;
  if not lErrors.Trim.IsEmpty then
  begin
    Result := lErrors;
    Exit;
  end;

  // Efetuar requisição
  FRes := TReq.Make(ENDPOINT+AId.ToString, ABrand.AsJSON).Execute(rtPut);

  // Falha na requisição
  if not (FRes.StatusCode = 200) then
  begin
    Result := SO(FRes.Content).S['message'];
    Exit;
  end;

  // Retornar registro atualizado
  Result := TBrand.FromJSON(SO(FRes.Content).O['data']);
end;

end.
