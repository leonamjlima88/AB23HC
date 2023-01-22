unit uTenant.UpdateAndShow.UseCase;

interface

uses
  uTenant.DTO,
  uTenant.Show.DTO,
  uTenant.Repository.Interfaces;

type
  ITenantUpdateAndShowUseCase = Interface
    ['{89480FD9-7684-44D1-9AE6-F691DA1323A1}']
    function Execute(AInput: TTenantDTO; APK: Int64): TTenantShowDTO;
  end;

  TTenantUpdateAndShowUseCase = class(TInterfacedObject, ITenantUpdateAndShowUseCase)
  private
    FRepository: ITenantRepository;
    constructor Create(ARepository: ITenantRepository);
  public
    class function Make(ARepository: ITenantRepository): ITenantUpdateAndShowUseCase;
    function Execute(AInput: TTenantDTO; APK: Int64): TTenantShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uTenant,
  uTenant.Mapper,
  System.SysUtils;

{ TTenantUpdateAndShowUseCase }

constructor TTenantUpdateAndShowUseCase.Create(ARepository: ITenantRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TTenantUpdateAndShowUseCase.Execute(AInput: TTenantDTO; APK: Int64): TTenantShowDTO;
var
  lTenantToUpdate: Shared<TTenant>;
  lTenantUpdated: Shared<TTenant>;
begin
  // Carregar dados em Entity
  lTenantToUpdate := TTenantMapper.TenantDtoToEntity(AInput);
  With lTenantToUpdate.Value do
  begin
    id := APK;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lTenantToUpdate, APK, true);
  lTenantUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TTenantMapper.EntityToTenantShowDto(lTenantUpdated);
end;

class function TTenantUpdateAndShowUseCase.Make(ARepository: ITenantRepository): ITenantUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
