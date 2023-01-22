unit uSale.Delete.UseCase;

interface

uses
  uSale.Repository.Interfaces;

type
  ISaleDeleteUseCase = Interface
    ['{ACBA4254-C372-4751-A0B5-AF837DA39777}']
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

  TSaleDeleteUseCase = class(TInterfacedObject, ISaleDeleteUseCase)
  private
    FRepository: ISaleRepository;
    constructor Create(ARepository: ISaleRepository);
  public
    class function Make(ARepository: ISaleRepository): ISaleDeleteUseCase;
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

implementation

{ TSaleDeleteUseCase }

constructor TSaleDeleteUseCase.Create(ARepository: ISaleRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TSaleDeleteUseCase.Execute(APK, ATenantId: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK, ATenantId);
end;

class function TSaleDeleteUseCase.Make(ARepository: ISaleRepository): ISaleDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
