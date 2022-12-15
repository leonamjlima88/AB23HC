unit uPerson.StoreAndShow.UseCase;

interface

uses
  uPerson.DTO,
  uPerson.Show.DTO,
  uPerson.Repository.Interfaces;

type
  IPersonStoreAndShowUseCase = Interface
    ['{E5DA7F69-83B7-4C20-AF63-4D43EA9B01A0}']
    function Execute(AInput: TPersonDTO): TPersonShowDTO;
  end;

  TPersonStoreAndShowUseCase = class(TInterfacedObject, IPersonStoreAndShowUseCase)
  private
    FRepository: IPersonRepository;
    constructor Create(ARepository: IPersonRepository);
  public
    class function Make(ARepository: IPersonRepository): IPersonStoreAndShowUseCase;
    function Execute(AInput: TPersonDTO): TPersonShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uPerson,
  XSuperObject;

{ TPersonStoreAndShowUseCase }

constructor TPersonStoreAndShowUseCase.Create(ARepository: IPersonRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TPersonStoreAndShowUseCase.Execute(AInput: TPersonDTO): TPersonShowDTO;
var
  lPersonToStore: Shared<TPerson>;
  lPersonStored: Shared<TPerson>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lPersonToStore := TPerson.FromJSON(AInput.AsJSON);
  lPersonToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lPersonToStore, true);

  // Localizar Registro
  lPersonStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TPersonShowDTO.FromEntity(lPersonStored.Value);
end;

class function TPersonStoreAndShowUseCase.Make(ARepository: IPersonRepository): IPersonStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
