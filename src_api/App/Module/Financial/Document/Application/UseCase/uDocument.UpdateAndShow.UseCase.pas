unit uDocument.UpdateAndShow.UseCase;

interface

uses
  uDocument.DTO,
  uDocument.Show.DTO,
  uDocument.Repository.Interfaces;

type
  IDocumentUpdateAndShowUseCase = Interface
    ['{04112C44-A1FF-4926-A6F2-2E6854885255}']
    function Execute(AInput: TDocumentDTO; APK: Int64): TDocumentShowDTO;
  end;

  TDocumentUpdateAndShowUseCase = class(TInterfacedObject, IDocumentUpdateAndShowUseCase)
  private
    FRepository: IDocumentRepository;
    constructor Create(ARepository: IDocumentRepository);
  public
    class function Make(ARepository: IDocumentRepository): IDocumentUpdateAndShowUseCase;
    function Execute(AInput: TDocumentDTO; APK: Int64): TDocumentShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uDocument,
  System.SysUtils,
  uDocument.Mapper;

{ TDocumentUpdateAndShowUseCase }

constructor TDocumentUpdateAndShowUseCase.Create(ARepository: IDocumentRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TDocumentUpdateAndShowUseCase.Execute(AInput: TDocumentDTO; APK: Int64): TDocumentShowDTO;
var
  lDocumentToUpdate: Shared<TDocument>;
  lDocumentUpdated: Shared<TDocument>;
begin
  // Carregar dados em Entity
  lDocumentToUpdate := TDocumentMapper.DocumentDtoToEntity(AInput);
  With lDocumentToUpdate.Value do
  begin
    id := APK;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lDocumentToUpdate, APK);
  lDocumentUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TDocumentMapper.EntityToDocumentShowDto(lDocumentUpdated);
end;

class function TDocumentUpdateAndShowUseCase.Make(ARepository: IDocumentRepository): IDocumentUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
