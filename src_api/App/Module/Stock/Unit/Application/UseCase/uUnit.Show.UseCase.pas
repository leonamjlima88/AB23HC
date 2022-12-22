unit uUnit.Show.UseCase;

interface

uses
  uUnit.Repository.Interfaces,
  uUnit.Show.DTO;

type
  IUnitShowUseCase = Interface
['{366F984E-04CB-4C31-AA87-5F1F8FD75CAD}']
    function Execute(APK: Int64): TUnitShowDTO;
  end;

  TUnitShowUseCase = class(TInterfacedObject, IUnitShowUseCase)
  private
    FRepository: IUnitRepository;
    constructor Create(ARepository: IUnitRepository);
  public
    class function Make(ARepository: IUnitRepository): IUnitShowUseCase;
    function Execute(APK: Int64): TUnitShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uUnit,
  uHlp,
  System.SysUtils,
  uApplication.Types,
  uUnit.Mapper;

{ TUnitShowUseCase }

constructor TUnitShowUseCase.Create(ARepository: IUnitRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TUnitShowUseCase.Execute(APK: Int64): TUnitShowDTO;
var
  lUnitFound: Shared<TUnit>;
begin
  // Localizar Registro
  lUnitFound := FRepository.Show(APK);
  if not Assigned(lUnitFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TUnitMapper.EntityToUnitShowDto(lUnitFound);
end;

class function TUnitShowUseCase.Make(ARepository: IUnitRepository): IUnitShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
