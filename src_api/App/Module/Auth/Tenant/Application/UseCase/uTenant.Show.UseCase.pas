unit uTenant.Show.UseCase;

interface

uses
  uTenant.Repository.Interfaces,
  uTenant.Show.DTO;

type
  ITenantShowUseCase = Interface
    ['{98591DAC-EFA1-48B3-B656-A60B2BDB55BA}']
    function Execute(APK: Int64): TTenantShowDTO;
  end;

  TTenantShowUseCase = class(TInterfacedObject, ITenantShowUseCase)
  private
    FRepository: ITenantRepository;
    constructor Create(ARepository: ITenantRepository);
  public
    class function Make(ARepository: ITenantRepository): ITenantShowUseCase;
    function Execute(APK: Int64): TTenantShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uTenant,
  uTenant.Mapper,
  uHlp,
  System.SysUtils,
  uApplication.Types;

{ TTenantShowUseCase }

constructor TTenantShowUseCase.Create(ARepository: ITenantRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TTenantShowUseCase.Execute(APK: Int64): TTenantShowDTO;
var
  lTenantFound: Shared<TTenant>;
begin
  // Localizar Registro
  lTenantFound := FRepository.Show(APK);
  if not Assigned(lTenantFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TTenantMapper.EntityToTenantShowDto(lTenantFound);
end;

class function TTenantShowUseCase.Make(ARepository: ITenantRepository): ITenantShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
