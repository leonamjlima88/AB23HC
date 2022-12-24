unit uNCM.Show.UseCase;

interface

uses
  uNCM.Repository.Interfaces,
  uNCM.Show.DTO;

type
  INCMShowUseCase = Interface
    ['{768BA1BB-108D-420C-9781-4C63A243846A}']
    function Execute(APK: Int64): TNCMShowDTO;
  end;

  TNCMShowUseCase = class(TInterfacedObject, INCMShowUseCase)
  private
    FRepository: INCMRepository;
    constructor Create(ARepository: INCMRepository);
  public
    class function Make(ARepository: INCMRepository): INCMShowUseCase;
    function Execute(APK: Int64): TNCMShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uNCM,
  uHlp,
  System.SysUtils,
  uApplication.Types,
  uNCM.Mapper;

{ TNCMShowUseCase }

constructor TNCMShowUseCase.Create(ARepository: INCMRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TNCMShowUseCase.Execute(APK: Int64): TNCMShowDTO;
var
  lNCMFound: Shared<TNCM>;
begin
  Result := Nil;

  // Localizar Registro
  lNCMFound := FRepository.Show(APK);
  if not Assigned(lNCMFound.Value) then
    Exit;

  // Retornar DTO
  Result := TNCMMapper.EntityToNCMShowDto(lNCMFound);
end;

class function TNCMShowUseCase.Make(ARepository: INCMRepository): INCMShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
