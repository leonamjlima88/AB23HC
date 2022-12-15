unit uCostCenter.Delete.UseCase;

interface

uses
  uCostCenter.Repository.Interfaces;

type
  ICostCenterDeleteUseCase = Interface
['{6CF66C19-D90E-4737-9A29-F20FC737DF41}']
    function Execute(APK: Int64): Boolean;
  end;

  TCostCenterDeleteUseCase = class(TInterfacedObject, ICostCenterDeleteUseCase)
  private
    FRepository: ICostCenterRepository;
    constructor Create(ARepository: ICostCenterRepository);
  public
    class function Make(ARepository: ICostCenterRepository): ICostCenterDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TCostCenterDeleteUseCase }

constructor TCostCenterDeleteUseCase.Create(ARepository: ICostCenterRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCostCenterDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TCostCenterDeleteUseCase.Make(ARepository: ICostCenterRepository): ICostCenterDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
