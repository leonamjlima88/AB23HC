unit uSize.Show.UseCase;

interface

uses
  uSize.Repository.Interfaces,
  uSize.Show.DTO;

type
  ISizeShowUseCase = Interface
    ['{CEE4B5DC-DCB9-4DFA-99A4-027BE1247345}']
    function Execute(APK, ATenantId: Int64): TSizeShowDTO;
  end;

  TSizeShowUseCase = class(TInterfacedObject, ISizeShowUseCase)
  private
    FRepository: ISizeRepository;
    constructor Create(ARepository: ISizeRepository);
  public
    class function Make(ARepository: ISizeRepository): ISizeShowUseCase;
    function Execute(APK, ATenantId: Int64): TSizeShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uSize,
  uHlp,
  System.SysUtils,
  uApplication.Types,
  uSize.Mapper;

{ TSizeShowUseCase }

constructor TSizeShowUseCase.Create(ARepository: ISizeRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TSizeShowUseCase.Execute(APK, ATenantId: Int64): TSizeShowDTO;
var
  lSizeFound: Shared<TSize>;
begin
  // Localizar Registro
  lSizeFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lSizeFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TSizeMapper.EntityToSizeShowDto(lSizeFound);
end;

class function TSizeShowUseCase.Make(ARepository: ISizeRepository): ISizeShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
