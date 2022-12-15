unit uUnit.Delete.UseCase;

interface

uses
  uUnit.Repository.Interfaces;

type
  IUnitDeleteUseCase = Interface
    ['{0C975B53-23AB-4037-81DE-D835CFF11B43}']
    function Execute(APK: Int64): Boolean;
  end;

  TUnitDeleteUseCase = class(TInterfacedObject, IUnitDeleteUseCase)
  private
    FRepository: IUnitRepository;
    constructor Create(ARepository: IUnitRepository);
  public
    class function Make(ARepository: IUnitRepository): IUnitDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TUnitDeleteUseCase }

constructor TUnitDeleteUseCase.Create(ARepository: IUnitRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TUnitDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TUnitDeleteUseCase.Make(ARepository: IUnitRepository): IUnitDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
