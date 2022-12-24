unit uCategory.Show.UseCase;

interface

uses
  uCategory.Repository.Interfaces,
  uCategory.Show.DTO;

type
  ICategoryShowUseCase = Interface
    ['{365F3D45-C59E-4857-AA98-5B359B8232DE}']
    function Execute(APK, ATenantId: Int64): TCategoryShowDTO;
  end;

  TCategoryShowUseCase = class(TInterfacedObject, ICategoryShowUseCase)
  private
    FRepository: ICategoryRepository;
    constructor Create(ARepository: ICategoryRepository);
  public
    class function Make(ARepository: ICategoryRepository): ICategoryShowUseCase;
    function Execute(APK, ATenantId: Int64): TCategoryShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCategory,
  uHlp,
  System.SysUtils,
  uApplication.Types,
  uCategory.Mapper;

{ TCategoryShowUseCase }

constructor TCategoryShowUseCase.Create(ARepository: ICategoryRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCategoryShowUseCase.Execute(APK, ATenantId: Int64): TCategoryShowDTO;
var
  lCategoryFound: Shared<TCategory>;
begin
  Result := Nil;

  // Localizar Registro
  lCategoryFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lCategoryFound.Value) then
    Exit;

  // Retornar DTO
  Result := TCategoryMapper.EntityToCategoryShowDto(lCategoryFound);
end;

class function TCategoryShowUseCase.Make(ARepository: ICategoryRepository): ICategoryShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
