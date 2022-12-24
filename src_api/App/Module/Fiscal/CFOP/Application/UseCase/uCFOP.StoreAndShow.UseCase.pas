unit uCFOP.StoreAndShow.UseCase;

interface

uses
  uCFOP.DTO,
  uCFOP.Show.DTO,
  uCFOP.Repository.Interfaces;

type
  ICFOPStoreAndShowUseCase = Interface
['{FB0F16B4-C6B6-42E6-ABD4-52A8FE8B3FF5}']
    function Execute(AInput: TCFOPDTO): TCFOPShowDTO;
  end;

  TCFOPStoreAndShowUseCase = class(TInterfacedObject, ICFOPStoreAndShowUseCase)
  private
    FRepository: ICFOPRepository;
    constructor Create(ARepository: ICFOPRepository);
  public
    class function Make(ARepository: ICFOPRepository): ICFOPStoreAndShowUseCase;
    function Execute(AInput: TCFOPDTO): TCFOPShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uCFOP,
  uCFOP.Mapper;

{ TCFOPStoreAndShowUseCase }

constructor TCFOPStoreAndShowUseCase.Create(ARepository: ICFOPRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TCFOPStoreAndShowUseCase.Execute(AInput: TCFOPDTO): TCFOPShowDTO;
var
  lCFOPToStore: Shared<TCFOP>;
  lCFOPStored: Shared<TCFOP>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lCFOPToStore := TCFOPMapper.CFOPDtoToEntity(AInput);
  lCFOPToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK         := FRepository.Store(lCFOPToStore);
  lCFOPStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TCFOPMapper.EntityToCFOPShowDto(lCFOPStored);
end;

class function TCFOPStoreAndShowUseCase.Make(ARepository: ICFOPRepository): ICFOPStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
