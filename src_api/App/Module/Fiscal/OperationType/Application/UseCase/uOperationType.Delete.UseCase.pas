unit uOperationType.Delete.UseCase;

interface

uses
  uOperationType.Repository.Interfaces;

type
  IOperationTypeDeleteUseCase = Interface
['{16A446B2-4A58-415D-BE48-5396CC142DD0}']
    function Execute(APK: Int64): Boolean;
  end;

  TOperationTypeDeleteUseCase = class(TInterfacedObject, IOperationTypeDeleteUseCase)
  private
    FRepository: IOperationTypeRepository;
    constructor Create(ARepository: IOperationTypeRepository);
  public
    class function Make(ARepository: IOperationTypeRepository): IOperationTypeDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TOperationTypeDeleteUseCase }

constructor TOperationTypeDeleteUseCase.Create(ARepository: IOperationTypeRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TOperationTypeDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TOperationTypeDeleteUseCase.Make(ARepository: IOperationTypeRepository): IOperationTypeDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
