unit uPaymentTerm.StoreAndShow.UseCase;

interface

uses
  uPaymentTerm.DTO,
  uPaymentTerm.Show.DTO,
  uPaymentTerm.Repository.Interfaces;

type
  IPaymentTermStoreAndShowUseCase = Interface
    ['{D8E1A50E-0B58-4461-9104-5C11033BBB97}']
    function Execute(AInput: TPaymentTermDTO): TPaymentTermShowDTO;
  end;

  TPaymentTermStoreAndShowUseCase = class(TInterfacedObject, IPaymentTermStoreAndShowUseCase)
  private
    FRepository: IPaymentTermRepository;
    constructor Create(ARepository: IPaymentTermRepository);
  public
    class function Make(ARepository: IPaymentTermRepository): IPaymentTermStoreAndShowUseCase;
    function Execute(AInput: TPaymentTermDTO): TPaymentTermShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uPaymentTerm,
  XSuperObject;

{ TPaymentTermStoreAndShowUseCase }

constructor TPaymentTermStoreAndShowUseCase.Create(ARepository: IPaymentTermRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TPaymentTermStoreAndShowUseCase.Execute(AInput: TPaymentTermDTO): TPaymentTermShowDTO;
var
  lPaymentTermToStore: Shared<TPaymentTerm>;
  lPaymentTermStored: Shared<TPaymentTerm>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lPaymentTermToStore := TPaymentTerm.FromJSON(AInput.AsJSON);
  lPaymentTermToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lPaymentTermToStore);
  lPaymentTermStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TPaymentTermShowDTO.FromEntity(lPaymentTermStored.Value);
end;

class function TPaymentTermStoreAndShowUseCase.Make(ARepository: IPaymentTermRepository): IPaymentTermStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
