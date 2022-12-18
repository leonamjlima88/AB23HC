unit uChartOfAccount.StoreAndShow.UseCase;

interface

uses
  uChartOfAccount.DTO,
  uChartOfAccount.Show.DTO,
  uChartOfAccount.Repository.Interfaces;

type
  IChartOfAccountStoreAndShowUseCase = Interface
    ['{D8E1A50E-0B58-4461-9104-5C11033BBB97}']
    function Execute(AInput: TChartOfAccountDTO): TChartOfAccountShowDTO;
  end;

  TChartOfAccountStoreAndShowUseCase = class(TInterfacedObject, IChartOfAccountStoreAndShowUseCase)
  private
    FRepository: IChartOfAccountRepository;
    constructor Create(ARepository: IChartOfAccountRepository);
  public
    class function Make(ARepository: IChartOfAccountRepository): IChartOfAccountStoreAndShowUseCase;
    function Execute(AInput: TChartOfAccountDTO): TChartOfAccountShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uChartOfAccount,
  XSuperObject;

{ TChartOfAccountStoreAndShowUseCase }

constructor TChartOfAccountStoreAndShowUseCase.Create(ARepository: IChartOfAccountRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TChartOfAccountStoreAndShowUseCase.Execute(AInput: TChartOfAccountDTO): TChartOfAccountShowDTO;
var
  lChartOfAccountToStore: Shared<TChartOfAccount>;
  lChartOfAccountStored: Shared<TChartOfAccount>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lChartOfAccountToStore := TChartOfAccount.FromJSON(AInput.AsJSON);
  lChartOfAccountToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lChartOfAccountToStore);
  lChartOfAccountStored := FRepository.Show(lPK);

  // Retornar DTO
  Result := TChartOfAccountShowDTO.FromEntity(lChartOfAccountStored.Value);
end;

class function TChartOfAccountStoreAndShowUseCase.Make(ARepository: IChartOfAccountRepository): IChartOfAccountStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.