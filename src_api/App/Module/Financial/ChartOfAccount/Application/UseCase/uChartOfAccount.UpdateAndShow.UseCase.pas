unit uChartOfAccount.UpdateAndShow.UseCase;

interface

uses
  uChartOfAccount.DTO,
  uChartOfAccount.Show.DTO,
  uChartOfAccount.Repository.Interfaces;

type
  IChartOfAccountUpdateAndShowUseCase = Interface
    ['{D92E72A1-E818-4496-B76C-6AECC7C1B870}']
    function Execute(AInput: TChartOfAccountDTO; APK: Int64): TChartOfAccountShowDTO;
  end;

  TChartOfAccountUpdateAndShowUseCase = class(TInterfacedObject, IChartOfAccountUpdateAndShowUseCase)
  private
    FRepository: IChartOfAccountRepository;
    constructor Create(ARepository: IChartOfAccountRepository);
  public
    class function Make(ARepository: IChartOfAccountRepository): IChartOfAccountUpdateAndShowUseCase;
    function Execute(AInput: TChartOfAccountDTO; APK: Int64): TChartOfAccountShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uChartOfAccount,
  System.SysUtils,
  uChartOfAccount.Mapper;

{ TChartOfAccountUpdateAndShowUseCase }

constructor TChartOfAccountUpdateAndShowUseCase.Create(ARepository: IChartOfAccountRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TChartOfAccountUpdateAndShowUseCase.Execute(AInput: TChartOfAccountDTO; APK: Int64): TChartOfAccountShowDTO;
var
  lChartOfAccountToUpdate: Shared<TChartOfAccount>;
  lChartOfAccountUpdated: Shared<TChartOfAccount>;
begin
  // Carregar dados em Entity
  lChartOfAccountToUpdate := TChartOfAccountMapper.ChartOfAccountDtoToEntity(AInput);
  With lChartOfAccountToUpdate.Value do
  begin
    id         := APK;
    updated_at := now;
    Validate;
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lChartOfAccountToUpdate, APK);
  lChartOfAccountUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TChartOfAccountMapper.EntityToChartOfAccountShowDto(lChartOfAccountUpdated);
end;

class function TChartOfAccountUpdateAndShowUseCase.Make(ARepository: IChartOfAccountRepository): IChartOfAccountUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
