unit uProduct.ShowBySkuOrEanCode.UseCase;

interface

uses
  uProduct.Repository.Interfaces,
  uProduct.Show.DTO;

type
  IProductShowBySkuOrEanCodeUseCase = Interface
    ['{348C4F4D-AFF3-4572-AAA5-E7DD946DD896}']
    function Execute(ASkuOrEanCode: String; ATenantId: Int64): TProductShowDTO;
  end;

  TProductShowBySkuOrEanCodeUseCase = class(TInterfacedObject, IProductShowBySkuOrEanCodeUseCase)
  private
    FRepository: IProductRepository;
    constructor Create(ARepository: IProductRepository);
  public
    class function Make(ARepository: IProductRepository): IProductShowBySkuOrEanCodeUseCase;
    function Execute(ASkuOrEanCode: String; ATenantId: Int64): TProductShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uProduct,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types,
  uProduct.Mapper;

{ TProductShowBySkuOrEanCodeUseCase }

constructor TProductShowBySkuOrEanCodeUseCase.Create(ARepository: IProductRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TProductShowBySkuOrEanCodeUseCase.Execute(ASkuOrEanCode: String; ATenantId: Int64): TProductShowDTO;
var
  lProductFound: Shared<TProduct>;
begin
  Result := Nil;

  // Localizar Registro
  lProductFound := FRepository.ShowBySkuOrEanCode(ASkuOrEanCode, ATenantId);
  if not Assigned(lProductFound.Value) then
    Exit;

  // Retornar DTO
  Result := TProductMapper.EntityToProductShowDto(lProductFound);
end;

class function TProductShowBySkuOrEanCodeUseCase.Make(ARepository: IProductRepository): IProductShowBySkuOrEanCodeUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
