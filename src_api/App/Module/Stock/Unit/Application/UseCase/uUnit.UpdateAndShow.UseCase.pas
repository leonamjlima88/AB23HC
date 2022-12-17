unit uUnit.UpdateAndShow.UseCase;

interface

uses
  uUnit.DTO,
  uUnit.Show.DTO,
  uUnit.Repository.Interfaces;

type
  IUnitUpdateAndShowUseCase = Interface
    ['{2537BB66-AF57-4B53-BA41-9A5CF02EFC29}']
    function Execute(AInput: TUnitDTO; APK: Int64): TUnitShowDTO;
  end;

  TUnitUpdateAndShowUseCase = class(TInterfacedObject, IUnitUpdateAndShowUseCase)
  private
    FRepository: IUnitRepository;
    constructor Create(ARepository: IUnitRepository);
  public
    class function Make(ARepository: IUnitRepository): IUnitUpdateAndShowUseCase;
    function Execute(AInput: TUnitDTO; APK: Int64): TUnitShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uUnit,
  XSuperObject,
  System.SysUtils;

{ TUnitUpdateAndShowUseCase }

constructor TUnitUpdateAndShowUseCase.Create(ARepository: IUnitRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TUnitUpdateAndShowUseCase.Execute(AInput: TUnitDTO; APK: Int64): TUnitShowDTO;
var
  lUnitToUpdate: Shared<TUnit>;
  lUnitUpdated: Shared<TUnit>;
begin
  // Carregar dados em Entity
  lUnitToUpdate := TUnit.FromJSON(AInput.AsJSON);
  With lUnitToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lUnitToUpdate, APK);
  lUnitUpdated := FRepository.Show(APK);

  // Retornar DTO
  Result := TUnitShowDTO.FromEntity(lUnitUpdated.Value);
end;

class function TUnitUpdateAndShowUseCase.Make(ARepository: IUnitRepository): IUnitUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
