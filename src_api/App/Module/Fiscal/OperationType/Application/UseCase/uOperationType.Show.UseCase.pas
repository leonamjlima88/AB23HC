unit uOperationType.Show.UseCase;

interface

uses
  uOperationType.Repository.Interfaces,
  uOperationType.Show.DTO;

type
  IOperationTypeShowUseCase = Interface
    ['{768BA1BB-108D-420C-9781-4C63A243846A}']
    function Execute(APK, ATenantId: Int64): TOperationTypeShowDTO;
  end;

  TOperationTypeShowUseCase = class(TInterfacedObject, IOperationTypeShowUseCase)
  private
    FRepository: IOperationTypeRepository;
    constructor Create(ARepository: IOperationTypeRepository);
  public
    class function Make(ARepository: IOperationTypeRepository): IOperationTypeShowUseCase;
    function Execute(APK, ATenantId: Int64): TOperationTypeShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uOperationType,
  uHlp,
  System.SysUtils,
  uApplication.Types,
  uOperationType.Mapper;

{ TOperationTypeShowUseCase }

constructor TOperationTypeShowUseCase.Create(ARepository: IOperationTypeRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TOperationTypeShowUseCase.Execute(APK, ATenantId: Int64): TOperationTypeShowDTO;
var
  lOperationTypeFound: Shared<TOperationType>;
begin
  Result := Nil;

  // Localizar Registro
  lOperationTypeFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lOperationTypeFound.Value) then
    Exit;

  // Retornar DTO
  Result := TOperationTypeMapper.EntityToOperationTypeShowDto(lOperationTypeFound);
end;

class function TOperationTypeShowUseCase.Make(ARepository: IOperationTypeRepository): IOperationTypeShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
