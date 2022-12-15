unit uCategory.Show.UseCase;

interface

uses
  uCategory.Repository.Interfaces,
  uCategory.Show.DTO;

type
  ICategoryShowUseCase = Interface
    ['{365F3D45-C59E-4857-AA98-5B359B8232DE}']
    function Execute(APK: Int64): TCategoryShowDTO;
  end;

  TCategoryShowUseCase = class(TInterfacedObject, ICategoryShowUseCase)
  private
    FRepository: ICategoryRepository;
    constructor Create(ARepository: ICategoryRepository);
  public
    class function Make(ARepository: ICategoryRepository): ICategoryShowUseCase;
    function Execute(APK: Int64): TCategoryShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCategory,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TCategoryShowUseCase }

constructor TCategoryShowUseCase.Create(ARepository: ICategoryRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCategoryShowUseCase.Execute(APK: Int64): TCategoryShowDTO;
var
  lCategoryFound: Shared<TCategory>;
begin
  // Localizar Registro
  lCategoryFound := FRepository.Show(APK);
  if not Assigned(lCategoryFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TCategoryShowDTO.FromEntity(lCategoryFound.Value);
end;

class function TCategoryShowUseCase.Make(ARepository: ICategoryRepository): ICategoryShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
