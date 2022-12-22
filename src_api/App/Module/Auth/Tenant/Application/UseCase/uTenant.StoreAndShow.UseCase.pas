unit uTenant.StoreAndShow.UseCase;

interface

uses
  uTenant.DTO,
  uTenant.Show.DTO,
  uTenant.Repository.Interfaces;

type
  ITenantStoreAndShowUseCase = Interface
['{E548F8F6-6243-420E-8B20-0A466B42F54E}']
    function Execute(AInput: TTenantDTO): TTenantShowDTO;
  end;

  TTenantStoreAndShowUseCase = class(TInterfacedObject, ITenantStoreAndShowUseCase)
  private
    FRepository: ITenantRepository;
    constructor Create(ARepository: ITenantRepository);
  public
    class function Make(ARepository: ITenantRepository): ITenantStoreAndShowUseCase;
    function Execute(AInput: TTenantDTO): TTenantShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uTenant,
  uTenant.Mapper;

{ TTenantStoreAndShowUseCase }

constructor TTenantStoreAndShowUseCase.Create(ARepository: ITenantRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TTenantStoreAndShowUseCase.Execute(AInput: TTenantDTO): TTenantShowDTO;
var
  lTenantToStore: Shared<TTenant>;
  lTenantStored: Shared<TTenant>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lTenantToStore := TTenantMapper.TenantDtoToEntity(AInput);
  lTenantToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lTenantToStore, true);
  lTenantStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TTenantMapper.EntityToTenantShowDto(lTenantStored);
end;

class function TTenantStoreAndShowUseCase.Make(ARepository: ITenantRepository): ITenantStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
