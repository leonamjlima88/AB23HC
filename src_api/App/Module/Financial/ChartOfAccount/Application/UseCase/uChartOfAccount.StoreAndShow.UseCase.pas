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
  uChartOfAccount.Mapper;

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
  lChartOfAccountToStore := TChartOfAccountMapper.ChartOfAccountDtoToEntity(AInput);
  lChartOfAccountToStore.Value.Validate;

  // Incluir e Localizar registro incluso
  lPK := FRepository.Store(lChartOfAccountToStore);
  lChartOfAccountStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TChartOfAccountMapper.EntityToChartOfAccountShowDto(lChartOfAccountStored);
end;

class function TChartOfAccountStoreAndShowUseCase.Make(ARepository: IChartOfAccountRepository): IChartOfAccountStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
