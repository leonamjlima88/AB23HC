unit uCostCenter.UpdateAndShow.UseCase;

interface

uses
  uCostCenter.DTO,
  uCostCenter.Show.DTO,
  uCostCenter.Repository.Interfaces;

type
  ICostCenterUpdateAndShowUseCase = Interface
    ['{2537BB66-AF57-4B53-BA41-9A5CF02EFC29}']
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
  lCostCenterUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TCostCenterShowDTO.FromEntity(lCostCenterUpdated.Value);
end;

class function TCostCenterUpdateAndShowUseCase.Make(ARepository: ICostCenterRepository): ICostCenterUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
