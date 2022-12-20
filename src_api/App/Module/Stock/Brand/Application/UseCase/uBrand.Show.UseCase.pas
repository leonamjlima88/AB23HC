unit uBrand.Show.UseCase;

interface

uses
  uBrand.Repository.Interfaces,
  uBrand.Show.DTO;

type
  IBrandShowUseCase = Interface
    ['{768BA1BB-108D-420C-9781-4C63A243846A}']
    function Execute(APK, ATenantId: Int64): TBrandShowDTO;
  end;

  TBrandShowUseCase = class(TInterfacedObject, IBrandShowUseCase)
  private
    FRepository: IBrandRepository;
    constructor Create(ARepository: IBrandRepository);
  public
    class function Make(ARepository: IBrandRepository): IBrandShowUseCase;
    function Execute(APK, ATenantId: Int64): TBrandShowDTO;
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

function TBrandShowUseCase.Execute(APK, ATenantId: Int64): TBrandShowDTO;
var
  lBrandFound: Shared<TBrand>;
begin
  // Localizar Registro
  lBrandFound := FRepository.Show(APK, ATenantId);
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
