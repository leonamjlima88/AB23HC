unit uSale.StoreAndShow.UseCase;

interface

uses
  uSale.DTO,
  uSale.Show.DTO,
  uSale.Repository.Interfaces;

type
  ISaleStoreAndShowUseCase = Interface
    ['{F4AAF50C-158C-419A-BDB3-00594431A0A1}']
    function Execute(AInput: TSaleDTO): TSaleShowDTO;
  end;

  TSaleStoreAndShowUseCase = class(TInterfacedObject, ISaleStoreAndShowUseCase)
  private
    FRepository: ISaleRepository;
    constructor Create(ARepository: ISaleRepository);
  public
    class function Make(ARepository: ISaleRepository): ISaleStoreAndShowUseCase;
    function Execute(AInput: TSaleDTO): TSaleShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uSale,
  XSuperObject,
  uLegalEntityNumber.VO,
  uSale.Mapper,
  uApplication.Types;

{ TSaleStoreAndShowUseCase }

constructor TSaleStoreAndShowUseCase.Create(ARepository: ISaleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TSaleStoreAndShowUseCase.Execute(AInput: TSaleDTO): TSaleShowDTO;
var
  lSaleToStore: Shared<TSale>;
  lSaleStored: Shared<TSale>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lSaleToStore := TSaleMapper.SaleDtoToEntity(AInput);
  lSaleToStore.Value.BeforeSaveAndValidate(esStore);

  // Incluir e Localizar registro incluso
  lPK         := FRepository.Store(lSaleToStore, true);
  lSaleStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TSaleMapper.EntityToSaleShowDto(lSaleStored.Value);
end;

class function TSaleStoreAndShowUseCase.Make(ARepository: ISaleRepository): ISaleStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
