unit uBank.StoreAndShow.UseCase;

interface

uses
  uBank.DTO,
  uBank.Show.DTO,
  uBank.Repository.Interfaces;

type
  IBankStoreAndShowUseCase = Interface
['{CF6CAB2A-4638-48BC-BE54-94197E4445DE}']
    function Execute(AInput: TBankDTO): TBankShowDTO;
  end;

  TBankStoreAndShowUseCase = class(TInterfacedObject, IBankStoreAndShowUseCase)
  private
    FRepository: IBankRepository;
    constructor Create(ARepository: IBankRepository);
  public
    class function Make(ARepository: IBankRepository): IBankStoreAndShowUseCase;
    function Execute(AInput: TBankDTO): TBankShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uBank,
  XSuperObject;

{ TBankStoreAndShowUseCase }

constructor TBankStoreAndShowUseCase.Create(ARepository: IBankRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBankStoreAndShowUseCase.Execute(AInput: TBankDTO): TBankShowDTO;
var
  lBankToStore: Shared<TBank>;
  lBankStored: Shared<TBank>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lBankToStore := TBank.FromJSON(AInput.AsJSON);
  lBankToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lBankToStore);
  lBankStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TBankShowDTO.FromEntity(lBankStored.Value);
end;

class function TBankStoreAndShowUseCase.Make(ARepository: IBankRepository): IBankStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
