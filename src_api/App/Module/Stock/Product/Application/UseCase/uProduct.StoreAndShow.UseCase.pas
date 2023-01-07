unit uProduct.StoreAndShow.UseCase;

interface

uses
  uProduct.DTO,
  uProduct.Show.DTO,
  uProduct.Repository.Interfaces;

type
  IProductStoreAndShowUseCase = Interface
    ['{54222AA1-DBED-4455-9DDB-57777730400E}']
    function Execute(AInput: TProductDTO): TProductShowDTO;
  end;

  TProductStoreAndShowUseCase = class(TInterfacedObject, IProductStoreAndShowUseCase)
  private
    FRepository: IProductRepository;
    constructor Create(ARepository: IProductRepository);
  public
    class function Make(ARepository: IProductRepository): IProductStoreAndShowUseCase;
    function Execute(AInput: TProductDTO): TProductShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uProduct,
  XSuperObject,
  uProduct.Mapper,
  uApplication.Types;

{ TProductStoreAndShowUseCase }

constructor TProductStoreAndShowUseCase.Create(ARepository: IProductRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TProductStoreAndShowUseCase.Execute(AInput: TProductDTO): TProductShowDTO;
var
  lProductToStore: Shared<TProduct>;
  lProductStored: Shared<TProduct>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lProductToStore := TProductMapper.ProductDtoToEntity(AInput);
  lProductToStore := TProduct.FromJSON(AInput.AsJSON);
  lProductToStore.Value.BeforeSaveAndValidate(esStore);

  // Incluir e Localizar registro incluso
  lPK            := FRepository.Store(lProductToStore);
  lProductStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TProductMapper.EntityToProductShowDto(lProductStored);
end;

class function TProductStoreAndShowUseCase.Make(ARepository: IProductRepository): IProductStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
