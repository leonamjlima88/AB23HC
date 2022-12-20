unit uPerson.Delete.UseCase;

interface

uses
  uPerson.Repository.Interfaces;

type
  IPersonDeleteUseCase = Interface
    ['{71E437A6-19C9-45C0-A607-E0D79CA23CCF}']
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

  TPersonDeleteUseCase = class(TInterfacedObject, IPersonDeleteUseCase)
  private
    FRepository: IPersonRepository;
    constructor Create(ARepository: IPersonRepository);
  public
    class function Make(ARepository: IPersonRepository): IPersonDeleteUseCase;
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

implementation

{ TPersonDeleteUseCase }

constructor TPersonDeleteUseCase.Create(ARepository: IPersonRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TPersonDeleteUseCase.Execute(APK, ATenantId: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK, ATenantId);
end;

class function TPersonDeleteUseCase.Make(ARepository: IPersonRepository): IPersonDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
