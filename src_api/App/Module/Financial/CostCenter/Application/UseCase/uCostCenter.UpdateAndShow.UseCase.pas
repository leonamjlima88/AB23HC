unit uCostCenter.UpdateAndShow.UseCase;

interface

uses
  uCostCenter.DTO,
  uCostCenter.Show.DTO,
  uCostCenter.Repository.Interfaces;

type
  ICostCenterUpdateAndShowUseCase = Interface
['{4A3C158A-7926-4DCF-97B4-AC1C9BDF83C4}']
    function Execute(AInput: TCostCenterDTO; APK: Int64): TCostCenterShowDTO;
  end;

  TCostCenterUpdateAndShowUseCase = class(TInterfacedObject, ICostCenterUpdateAndShowUseCase)
  private
    FRepository: ICostCenterRepository;
    constructor Create(ARepository: ICostCenterRepository);
  public
    class function Make(ARepository: ICostCenterRepository): ICostCenterUpdateAndShowUseCase;
    function Execute(AInput: TCostCenterDTO; APK: Int64): TCostCenterShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCostCenter,
  XSuperObject,
  System.SysUtils;

{ TCostCenterUpdateAndShowUseCase }

constructor TCostCenterUpdateAndShowUseCase.Create(ARepository: ICostCenterRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCostCenterUpdateAndShowUseCase.Execute(AInput: TCostCenterDTO; APK: Int64): TCostCenterShowDTO;
var
  lCostCenterToUpdate: Shared<TCostCenter>;
  lCostCenterUpdated: Shared<TCostCenter>;
begin
  // Carregar dados em Entity
  lCostCenterToUpdate := TCostCenter.FromJSON(AInput.AsJSON);
  With lCostCenterToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lCostCenterToUpdate, APK);
  lCostCenterUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TCostCenterShowDTO.FromEntity(lCostCenterUpdated.Value);
end;

class function TCostCenterUpdateAndShowUseCase.Make(ARepository: ICostCenterRepository): ICostCenterUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
