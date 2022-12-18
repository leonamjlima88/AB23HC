unit uSize.StoreAndShow.UseCase;

interface

uses
  uSize.DTO,
  uSize.Show.DTO,
  uSize.Repository.Interfaces;

type
  ISizeStoreAndShowUseCase = Interface
['{01F66C4A-AE43-40EB-AC70-0341ED3011FB}']
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
  lSizeStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TSizeShowDTO.FromEntity(lSizeStored.Value);
end;

class function TSizeStoreAndShowUseCase.Make(ARepository: ISizeRepository): ISizeStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
