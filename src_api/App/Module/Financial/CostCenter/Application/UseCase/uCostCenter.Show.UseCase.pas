unit uCostCenter.Show.UseCase;

interface

uses
  uCostCenter.Repository.Interfaces,
  uCostCenter.Show.DTO;

type
  ICostCenterShowUseCase = Interface
['{FB716BA4-0451-4CEF-940A-0133E7DDCCD8}']
    function Execute(APK: Int64): TCostCenterShowDTO;
  end;

  TCostCenterShowUseCase = class(TInterfacedObject, ICostCenterShowUseCase)
  private
    FRepository: ICostCenterRepository;
    constructor Create(ARepository: ICostCenterRepository);
  public
    class function Make(ARepository: ICostCenterRepository): ICostCenterShowUseCase;
    function Execute(APK: Int64): TCostCenterShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCostCenter,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TCostCenterShowUseCase }

constructor TCostCenterShowUseCase.Create(ARepository: ICostCenterRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCostCenterShowUseCase.Execute(APK: Int64): TCostCenterShowDTO;
var
  lCostCenterFound: Shared<TCostCenter>;
begin
  // Localizar Registro
  lCostCenterFound := FRepository.Show(APK);
  if not Assigned(lCostCenterFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TCostCenterShowDTO.FromEntity(lCostCenterFound.Value);
end;

class function TCostCenterShowUseCase.Make(ARepository: ICostCenterRepository): ICostCenterShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
