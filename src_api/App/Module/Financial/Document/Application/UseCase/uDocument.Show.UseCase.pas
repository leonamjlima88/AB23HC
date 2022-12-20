unit uDocument.Show.UseCase;

interface

uses
  uDocument.Repository.Interfaces,
  uDocument.Show.DTO;

type
  IDocumentShowUseCase = Interface
    ['{4938302F-3300-49AC-8FF3-68F577CC1B56}']
    function Execute(APK, ATenantId: Int64): TDocumentShowDTO;
  end;

  TDocumentShowUseCase = class(TInterfacedObject, IDocumentShowUseCase)
  private
    FRepository: IDocumentRepository;
    constructor Create(ARepository: IDocumentRepository);
  public
    class function Make(ARepository: IDocumentRepository): IDocumentShowUseCase;
    function Execute(APK, ATenantId: Int64): TDocumentShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uDocument,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TDocumentShowUseCase }

constructor TDocumentShowUseCase.Create(ARepository: IDocumentRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TDocumentShowUseCase.Execute(APK, ATenantId: Int64): TDocumentShowDTO;
var
  lDocumentFound: Shared<TDocument>;
begin
  // Localizar Registro
  lDocumentFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lDocumentFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TDocumentShowDTO.FromEntity(lDocumentFound.Value);
end;

class function TDocumentShowUseCase.Make(ARepository: IDocumentRepository): IDocumentShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
