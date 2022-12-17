unit uProduct.UpdateAndShow.UseCase;

interface

uses
  uProduct.DTO,
  uProduct.Show.DTO,
  uProduct.Repository.Interfaces;

type
  IProductUpdateAndShowUseCase = Interface
    ['{2537BB66-AF57-4B53-BA41-9A5CF02EFC29}']
    function Execute(AInput: TProductDTO; APK: Int64): TProductShowDTO;
  end;

  TProductUpdateAndShowUseCase = class(TInterfacedObject, IProductUpdateAndShowUseCase)
  private
    FRepository: IProductRepository;
    constructor Create(ARepository: IProductRepository);
  public
    class function Make(ARepository: IProductRepository): IProductUpdateAndShowUseCase;
    function Execute(AInput: TProductDTO; APK: Int64): TProductShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uProduct,
  XSuperObject,
  System.SysUtils;

{ TProductUpdateAndShowUseCase }

constructor TProductUpdateAndShowUseCase.Create(ARepository: IProductRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TProductUpdateAndShowUseCase.Execute(AInput: TProductDTO; APK: Int64): TProductShowDTO;
var
  lProductToUpdate: Shared<TProduct>;
  lProductUpdated: Shared<TProduct>;
begin
  // Carregar dados em Entity
  lProductToUpdate := TProduct.FromJSON(AInput.AsJSON);
  With lProductToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lProductToUpdate, APK);
  lProductUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TProductShowDTO.FromEntity(lProductUpdated.Value);
end;

class function TProductUpdateAndShowUseCase.Make(ARepository: IProductRepository): IProductUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
