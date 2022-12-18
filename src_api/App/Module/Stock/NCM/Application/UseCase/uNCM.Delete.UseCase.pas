unit uNCM.Delete.UseCase;

interface

uses
  uNCM.Repository.Interfaces;

type
  INCMDeleteUseCase = Interface
['{E53DB85B-96C2-42BA-9B7C-138D139D75D7}']
    function Execute(APK: Int64): Boolean;
  end;

  TNCMDeleteUseCase = class(TInterfacedObject, INCMDeleteUseCase)
  private
    FRepository: INCMRepository;
    constructor Create(ARepository: INCMRepository);
  public
    class function Make(ARepository: INCMRepository): INCMDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TNCMDeleteUseCase }

constructor TNCMDeleteUseCase.Create(ARepository: INCMRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TNCMDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TNCMDeleteUseCase.Make(ARepository: INCMRepository): INCMDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
