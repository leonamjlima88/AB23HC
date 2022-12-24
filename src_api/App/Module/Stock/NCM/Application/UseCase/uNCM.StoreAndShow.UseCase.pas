unit uNCM.StoreAndShow.UseCase;

interface

uses
  uNCM.DTO,
  uNCM.Show.DTO,
  uNCM.Repository.Interfaces;

type
  INCMStoreAndShowUseCase = Interface
    ['{D8E1A50E-0B58-4461-9104-5C11033BBB97}']
    function Execute(AInput: TNCMDTO): TNCMShowDTO;
  end;

  TNCMStoreAndShowUseCase = class(TInterfacedObject, INCMStoreAndShowUseCase)
  private
    FRepository: INCMRepository;
    constructor Create(ARepository: INCMRepository);
  public
    class function Make(ARepository: INCMRepository): INCMStoreAndShowUseCase;
    function Execute(AInput: TNCMDTO): TNCMShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uNCM,
  uNCM.Mapper;

{ TNCMStoreAndShowUseCase }

constructor TNCMStoreAndShowUseCase.Create(ARepository: INCMRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TNCMStoreAndShowUseCase.Execute(AInput: TNCMDTO): TNCMShowDTO;
var
  lNCMToStore: Shared<TNCM>;
  lNCMStored: Shared<TNCM>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lNCMToStore := TNCMMapper.NCMDtoToEntity(AInput);
  lNCMToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK        := FRepository.Store(lNCMToStore);
  lNCMStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TNCMMapper.EntityToNCMShowDto(lNCMStored);
end;

class function TNCMStoreAndShowUseCase.Make(ARepository: INCMRepository): INCMStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
