unit uAppParam.Delete.UseCase;

interface

uses
  uAppParam.Repository.Interfaces;

type
  IAppParamDeleteUseCase = Interface
    ['{91983A9E-AF10-45AC-9F47-A5286EA3F185}']
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

  TAppParamDeleteUseCase = class(TInterfacedObject, IAppParamDeleteUseCase)
  private
    FRepository: IAppParamRepository;
    constructor Create(ARepository: IAppParamRepository);
  public
    class function Make(ARepository: IAppParamRepository): IAppParamDeleteUseCase;
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

implementation

{ TAppParamDeleteUseCase }

constructor TAppParamDeleteUseCase.Create(ARepository: IAppParamRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TAppParamDeleteUseCase.Execute(APK, ATenantId: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK, ATenantId);
end;

class function TAppParamDeleteUseCase.Make(ARepository: IAppParamRepository): IAppParamDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
