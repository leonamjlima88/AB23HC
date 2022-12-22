unit uUnit.UpdateAndShow.UseCase;

interface

uses
  uUnit.DTO,
  uUnit.Show.DTO,
  uUnit.Repository.Interfaces;

type
  IUnitUpdateAndShowUseCase = Interface
['{92454164-17CF-4E33-A687-231CC7ABF9D3}']
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
  System.SysUtils,
  uUnit.Mapper;

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
  lUnitToUpdate := TUnitMapper.UnitDtoToEntity(AInput);
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
  Result := TUnitMapper.EntityToUnitShowDto(lUnitUpdated);
end;

class function TUnitUpdateAndShowUseCase.Make(ARepository: IUnitRepository): IUnitUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
