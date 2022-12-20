unit uDocument.Delete.UseCase;

interface

uses
  uDocument.Repository.Interfaces;

type
  IDocumentDeleteUseCase = Interface
    ['{22EF8210-16FF-4321-B556-E70AAC8B053E}']
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

  TDocumentDeleteUseCase = class(TInterfacedObject, IDocumentDeleteUseCase)
  private
    FRepository: IDocumentRepository;
    constructor Create(ARepository: IDocumentRepository);
  public
    class function Make(ARepository: IDocumentRepository): IDocumentDeleteUseCase;
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

implementation

{ TDocumentDeleteUseCase }

constructor TDocumentDeleteUseCase.Create(ARepository: IDocumentRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TDocumentDeleteUseCase.Execute(APK, ATenantId: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK, ATenantId);
end;

class function TDocumentDeleteUseCase.Make(ARepository: IDocumentRepository): IDocumentDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
