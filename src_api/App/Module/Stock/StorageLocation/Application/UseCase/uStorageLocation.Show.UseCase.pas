unit uStorageLocation.Show.UseCase;

interface

uses
  uStorageLocation.Repository.Interfaces,
  uStorageLocation.Show.DTO;

type
  IStorageLocationShowUseCase = Interface
    ['{48D60E26-2951-4E56-953B-2A06A154EF55}']
    function Execute(APK, ATenantId: Int64): TStorageLocationShowDTO;
  end;

  TStorageLocationShowUseCase = class(TInterfacedObject, IStorageLocationShowUseCase)
  private
    FRepository: IStorageLocationRepository;
    constructor Create(ARepository: IStorageLocationRepository);
  public
    class function Make(ARepository: IStorageLocationRepository): IStorageLocationShowUseCase;
    function Execute(APK, ATenantId: Int64): TStorageLocationShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uStorageLocation,
  uHlp,
  System.SysUtils,
  uApplication.Types,
  uStorageLocation.Mapper;

{ TStorageLocationShowUseCase }

constructor TStorageLocationShowUseCase.Create(ARepository: IStorageLocationRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TStorageLocationShowUseCase.Execute(APK, ATenantId: Int64): TStorageLocationShowDTO;
var
  lStorageLocationFound: Shared<TStorageLocation>;
begin
  Result := Nil;

  // Localizar Registro
  lStorageLocationFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lStorageLocationFound.Value) then
    Exit;

  // Retornar DTO
  Result := TStorageLocationMapper.EntityToStorageLocationShowDto(lStorageLocationFound);
end;

class function TStorageLocationShowUseCase.Make(ARepository: IStorageLocationRepository): IStorageLocationShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
