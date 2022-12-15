unit uSize.StoreAndShow.UseCase;

interface

uses
  uSize.DTO,
  uSize.Show.DTO,
  uSize.Repository.Interfaces;

type
  ISizeStoreAndShowUseCase = Interface
    ['{E5DA7F69-83B7-4C20-AF63-4D43EA9B01A0}']
    function Execute(AInput: TSizeDTO): TSizeShowDTO;
  end;

  TSizeStoreAndShowUseCase = class(TInterfacedObject, ISizeStoreAndShowUseCase)
  private
    FRepository: ISizeRepository;
    constructor Create(ARepository: ISizeRepository);
  public
    class function Make(ARepository: ISizeRepository): ISizeStoreAndShowUseCase;
    function Execute(AInput: TSizeDTO): TSizeShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uSize,
  XSuperObject;

{ TSizeStoreAndShowUseCase }

constructor TSizeStoreAndShowUseCase.Create(ARepository: ISizeRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TSizeStoreAndShowUseCase.Execute(AInput: TSizeDTO): TSizeShowDTO;
var
  lSizeToStore: Shared<TSize>;
  lSizeStored: Shared<TSize>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lSizeToStore := TSize.FromJSON(AInput.AsJSON);
  lSizeToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lSizeToStore);

  // Localizar Registro
  lSizeStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TSizeShowDTO.FromEntity(lSizeStored.Value);
end;

class function TSizeStoreAndShowUseCase.Make(ARepository: ISizeRepository): ISizeStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
