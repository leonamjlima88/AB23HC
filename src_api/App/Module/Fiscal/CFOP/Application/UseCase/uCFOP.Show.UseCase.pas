unit uCFOP.Show.UseCase;

interface

uses
  uCFOP.Repository.Interfaces,
  uCFOP.Show.DTO;

type
  ICFOPShowUseCase = Interface
    ['{768BA1BB-108D-420C-9781-4C63A243846A}']
    function Execute(APK: Int64): TCFOPShowDTO;
  end;

  TCFOPShowUseCase = class(TInterfacedObject, ICFOPShowUseCase)
  private
    FRepository: ICFOPRepository;
    constructor Create(ARepository: ICFOPRepository);
  public
    class function Make(ARepository: ICFOPRepository): ICFOPShowUseCase;
    function Execute(APK: Int64): TCFOPShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCFOP,
  uHlp,
  System.SysUtils,
  uApplication.Types,
  uCFOP.Mapper;

{ TCFOPShowUseCase }

constructor TCFOPShowUseCase.Create(ARepository: ICFOPRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCFOPShowUseCase.Execute(APK: Int64): TCFOPShowDTO;
var
  lCFOPFound: Shared<TCFOP>;
begin
  Result := Nil;

  // Localizar Registro
  lCFOPFound := FRepository.Show(APK);
  if not Assigned(lCFOPFound.Value) then
    Exit;

  // Retornar DTO
  Result := TCFOPMapper.EntityToCFOPShowDto(lCFOPFound);
end;

class function TCFOPShowUseCase.Make(ARepository: ICFOPRepository): ICFOPShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
