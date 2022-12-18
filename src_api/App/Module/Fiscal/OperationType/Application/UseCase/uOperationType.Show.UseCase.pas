unit uOperationType.Show.UseCase;

interface

uses
  uOperationType.Repository.Interfaces,
  uOperationType.Show.DTO;

type
  IOperationTypeShowUseCase = Interface
    ['{768BA1BB-108D-420C-9781-4C63A243846A}']
    function Execute(APK: Int64): TOperationTypeShowDTO;
  end;

  TOperationTypeShowUseCase = class(TInterfacedObject, IOperationTypeShowUseCase)
  private
    FRepository: IOperationTypeRepository;
    constructor Create(ARepository: IOperationTypeRepository);
  public
    class function Make(ARepository: IOperationTypeRepository): IOperationTypeShowUseCase;
    function Execute(APK: Int64): TOperationTypeShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uOperationType,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TOperationTypeShowUseCase }

constructor TOperationTypeShowUseCase.Create(ARepository: IOperationTypeRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TOperationTypeShowUseCase.Execute(APK: Int64): TOperationTypeShowDTO;
var
  lOperationTypeFound: Shared<TOperationType>;
begin
  // Localizar Registro
  lOperationTypeFound := FRepository.Show(APK);
  if not Assigned(lOperationTypeFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TOperationTypeShowDTO.FromEntity(lOperationTypeFound.Value);
end;

class function TOperationTypeShowUseCase.Make(ARepository: IOperationTypeRepository): IOperationTypeShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
