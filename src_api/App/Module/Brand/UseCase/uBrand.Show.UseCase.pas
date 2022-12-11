unit uBrand.Show.UseCase;

interface

uses
  uBrand.Repository.Interfaces,
  uBrand.Show.DTO;

type
  IBrandShowUseCase = Interface
    ['{4D34B8E1-3AAF-4C43-827D-A78094EB5F8F}']
    function Execute(APK: Int64): TBrandShowDTO;
  end;

  TBrandShowUseCase = class(TInterfacedObject, IBrandShowUseCase)
  private
    FRepository: IBrandRepository;
    constructor Create(ARepository: IBrandRepository);
  public
    class function Make(ARepository: IBrandRepository): IBrandShowUseCase;
    function Execute(APK: Int64): TBrandShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uBrand,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TBrandShowUseCase }

constructor TBrandShowUseCase.Create(ARepository: IBrandRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBrandShowUseCase.Execute(APK: Int64): TBrandShowDTO;
var
  lBrandFound: Shared<TBrand>;
begin
  // Localizar Registro
  lBrandFound := FRepository.Show(APK);
  if not Assigned(lBrandFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TBrandShowDTO.FromEntity(lBrandFound.Value);
end;

class function TBrandShowUseCase.Make(ARepository: IBrandRepository): IBrandShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.