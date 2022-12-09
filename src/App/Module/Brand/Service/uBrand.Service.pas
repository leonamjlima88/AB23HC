unit uBrand.Service;

interface

uses
  uPageFilter,
  uIndexResult,
  uBrand,
  uBrand.Repository.Interfaces;

type
  IBrandService = interface
    ['{E2081C48-3DBB-40DD-BADD-A4E0C905C694}']

    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): TBrand;
    function Store(ABrand: TBrand; ADestroyEntity: Boolean = true): Int64;
    function Update(ABrand: TBrand; AId: Int64; ADestroyEntity: Boolean = true): Boolean;
  end;

  TBrandService = class(TInterfacedObject, IBrandService)
  private
    FRepository: IBrandRepository;
    constructor Create(ARepository: IBrandRepository);
  public
    class function Make(ARepository: IBrandRepository): IBrandService;
    function Delete(AId: Int64): Boolean;
    function Index(APageFilter: IPageFilter): IIndexResult;
    function Show(AId: Int64): TBrand;
    function Store(ABrand: TBrand; ADestroyEntity: Boolean = true): Int64;
    function Update(ABrand: TBrand; AId: Int64; ADestroyEntity: Boolean = true): Boolean;
  end;

implementation

uses
  System.SysUtils;

{ TBrandService }

constructor TBrandService.Create(ARepository: IBrandRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBrandService.Delete(AId: Int64): Boolean;
begin
  Result := FRepository.Delete(AId);
end;

function TBrandService.Index(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TBrandService.Make(ARepository: IBrandRepository): IBrandService;
begin
  Result := Self.Create(ARepository);
end;

function TBrandService.Show(AId: Int64): TBrand;
begin
  Result := FRepository.Show(AId);
end;

function TBrandService.Store(ABrand: TBrand; ADestroyEntity: Boolean): Int64;
begin
  ABrand.created_at := now;
  Result := FRepository.Store(ABrand);

  // Destruir entidade
  if ADestroyEntity then
    FreeAndNil(ABrand);
end;

function TBrandService.Update(ABrand: TBrand; AId: Int64; ADestroyEntity: Boolean): Boolean;
begin
  ABrand.updated_at := now;
  Result := FRepository.Update(ABrand, AId);

  // Destruir entidade
  if ADestroyEntity then
    FreeAndNil(ABrand);
end;

end.


