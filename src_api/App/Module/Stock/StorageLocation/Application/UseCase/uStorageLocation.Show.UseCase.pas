unit uStorageLocation.Show.UseCase;

interface

uses
  uStorageLocation.Repository.Interfaces,
  uStorageLocation.Show.DTO;

type
  IStorageLocationShowUseCase = Interface
    ['{4D34B8E1-3AAF-4C43-827D-A78094EB5F8F}']
    function Execute(APK: Int64): TStorageLocationShowDTO;
  end;

  TStorageLocationShowUseCase = class(TInterfacedObject, IStorageLocationShowUseCase)
  private
    FRepository: IStorageLocationRepository;
    constructor Create(ARepository: IStorageLocationRepository);
  public
    class function Make(ARepository: IStorageLocationRepository): IStorageLocationShowUseCase;
    function Execute(APK: Int64): TStorageLocationShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uStorageLocation,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TStorageLocationShowUseCase }

constructor TStorageLocationShowUseCase.Create(ARepository: IStorageLocationRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TStorageLocationShowUseCase.Execute(APK: Int64): TStorageLocationShowDTO;
var
  lStorageLocationFound: Shared<TStorageLocation>;
begin
  // Localizar Registro
  lStorageLocationFound := FRepository.Show(APK);
  if not Assigned(lStorageLocationFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TStorageLocationShowDTO.FromEntity(lStorageLocationFound.Value);
end;

class function TStorageLocationShowUseCase.Make(ARepository: IStorageLocationRepository): IStorageLocationShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
