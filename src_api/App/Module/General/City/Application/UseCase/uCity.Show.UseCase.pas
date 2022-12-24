unit uCity.Show.UseCase;

interface

uses
  uCity.Repository.Interfaces,
  uCity.Show.DTO;

type
  ICityShowUseCase = Interface
['{EF20F782-AC0E-430B-8627-A65AD3F91208}']
    function Execute(APK: Int64): TCityShowDTO;
  end;

  TCityShowUseCase = class(TInterfacedObject, ICityShowUseCase)
  private
    FRepository: ICityRepository;
    constructor Create(ARepository: ICityRepository);
  public
    class function Make(ARepository: ICityRepository): ICityShowUseCase;
    function Execute(APK: Int64): TCityShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCity,
  uHlp,
  System.SysUtils,
  uApplication.Types,
  uCity.Mapper;

{ TCityShowUseCase }

constructor TCityShowUseCase.Create(ARepository: ICityRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCityShowUseCase.Execute(APK: Int64): TCityShowDTO;
var
  lCityFound: Shared<TCity>;
begin
  Result := Nil;

  // Localizar Registro
  lCityFound := FRepository.Show(APK);
  if not Assigned(lCityFound.Value) then
    Exit;

  // Retornar DTO
  Result := TCityMapper.EntityToCityShowDto(lCityFound);
end;

class function TCityShowUseCase.Make(ARepository: ICityRepository): ICityShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
