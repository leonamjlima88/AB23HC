unit uProduct.StoreAndShow.UseCase;

interface

uses
  uProduct.DTO,
  uProduct.Show.DTO,
  uProduct.Repository.Interfaces;

type
  IProductStoreAndShowUseCase = Interface
    ['{E5DA7F69-83B7-4C20-AF63-4D43EA9B01A0}']
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
  XSuperObject;

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
  lProductToStore := TProduct.FromJSON(AInput.AsJSON);
  lProductToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lProductToStore);

  // Localizar Registro
  lProductStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TProductShowDTO.FromEntity(lProductStored.Value);
end;

class function TProductStoreAndShowUseCase.Make(ARepository: IProductRepository): IProductStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
