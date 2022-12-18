unit uDocument.StoreAndShow.UseCase;

interface

uses
  uDocument.DTO,
  uDocument.Show.DTO,
  uDocument.Repository.Interfaces;

type
  IDocumentStoreAndShowUseCase = Interface
    ['{6DCD731A-7C5D-47CB-97AE-51F31FFFA1B5}']
    function Execute(AInput: TDocumentDTO): TDocumentShowDTO;
  end;

  TDocumentStoreAndShowUseCase = class(TInterfacedObject, IDocumentStoreAndShowUseCase)
  private
    FRepository: IDocumentRepository;
    constructor Create(ARepository: IDocumentRepository);
  public
    class function Make(ARepository: IDocumentRepository): IDocumentStoreAndShowUseCase;
    function Execute(AInput: TDocumentDTO): TDocumentShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uDocument,
  XSuperObject;

{ TDocumentStoreAndShowUseCase }

constructor TDocumentStoreAndShowUseCase.Create(ARepository: IDocumentRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TDocumentStoreAndShowUseCase.Execute(AInput: TDocumentDTO): TDocumentShowDTO;
var
  lDocumentToStore: Shared<TDocument>;
  lDocumentStored: Shared<TDocument>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lDocumentToStore := TDocument.FromJSON(AInput.AsJSON);
  lDocumentToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lDocumentToStore);
  lDocumentStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TDocumentShowDTO.FromEntity(lDocumentStored.Value);
end;

class function TDocumentStoreAndShowUseCase.Make(ARepository: IDocumentRepository): IDocumentStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.