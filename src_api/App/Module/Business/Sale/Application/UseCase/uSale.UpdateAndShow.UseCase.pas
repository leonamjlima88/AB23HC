unit uSale.UpdateAndShow.UseCase;

interface

uses
  uSale.DTO,
  uSale.Show.DTO,
  uSale.Repository.Interfaces;

type
  ISaleUpdateAndShowUseCase = Interface
    ['{2722C6F7-9C9E-4BC2-A75C-01693EA25A81}']
    function Execute(AInput: TSaleDTO; APK: Int64): TSaleShowDTO;
  end;

  TSaleUpdateAndShowUseCase = class(TInterfacedObject, ISaleUpdateAndShowUseCase)
  private
    FRepository: ISaleRepository;
    constructor Create(ARepository: ISaleRepository);
  public
    class function Make(ARepository: ISaleRepository): ISaleUpdateAndShowUseCase;
    function Execute(AInput: TSaleDTO; APK: Int64): TSaleShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uSale,
  XSuperObject,
  System.SysUtils,
  uSale.Mapper,
  uApplication.Types;

{ TSaleUpdateAndShowUseCase }

constructor TSaleUpdateAndShowUseCase.Create(ARepository: ISaleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TSaleUpdateAndShowUseCase.Execute(AInput: TSaleDTO; APK: Int64): TSaleShowDTO;
var
  lSaleToUpdate: Shared<TSale>;
  lSaleUpdated: Shared<TSale>;
begin
  // Carregar dados em Entity
  lSaleToUpdate := TSaleMapper.SaleDtoToEntity(AInput);
  With lSaleToUpdate.Value do
  begin
    id := APK;
    BeforeSaveAndValidate(esUpdate);
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lSaleToUpdate, APK, true);
  lSaleUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TSaleMapper.EntityToSaleShowDto(lSaleUpdated.Value);
end;

class function TSaleUpdateAndShowUseCase.Make(ARepository: ISaleRepository): ISaleUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
