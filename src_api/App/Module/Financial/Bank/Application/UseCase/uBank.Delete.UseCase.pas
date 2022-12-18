unit uBank.Delete.UseCase;

interface

uses
  uBank.Repository.Interfaces;

type
  IBankDeleteUseCase = Interface
['{FE25AEBD-46DA-4340-B004-6A877A23628A}']
    function Execute(APK: Int64): Boolean;
  end;

  TBankDeleteUseCase = class(TInterfacedObject, IBankDeleteUseCase)
  private
    FRepository: IBankRepository;
    constructor Create(ARepository: IBankRepository);
  public
    class function Make(ARepository: IBankRepository): IBankDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TBankDeleteUseCase }

constructor TBankDeleteUseCase.Create(ARepository: IBankRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBankDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TBankDeleteUseCase.Make(ARepository: IBankRepository): IBankDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
