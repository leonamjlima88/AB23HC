unit uCity.Show.UseCase;

interface

uses
  uCity.Repository.Interfaces,
  uCity.Show.DTO;

type
  ICityShowUseCase = Interface
    ['{4D34B8E1-3AAF-4C43-827D-A78094EB5F8F}']
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
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

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
  // Localizar Registro
  lCityFound := FRepository.Show(APK);
  if not Assigned(lCityFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TCityShowDTO.FromEntity(lCityFound.Value);
end;

class function TCityShowUseCase.Make(ARepository: ICityRepository): ICityShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
