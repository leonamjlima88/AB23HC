unit uChartOfAccount.Show.UseCase;

interface

uses
  uChartOfAccount.Repository.Interfaces,
  uChartOfAccount.Show.DTO;

type
  IChartOfAccountShowUseCase = Interface
    ['{768BA1BB-108D-420C-9781-4C63A243846A}']
    function Execute(APK, ATenantId: Int64): TChartOfAccountShowDTO;
  end;

  TChartOfAccountShowUseCase = class(TInterfacedObject, IChartOfAccountShowUseCase)
  private
    FRepository: IChartOfAccountRepository;
    constructor Create(ARepository: IChartOfAccountRepository);
  public
    class function Make(ARepository: IChartOfAccountRepository): IChartOfAccountShowUseCase;
    function Execute(APK, ATenantId: Int64): TChartOfAccountShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uChartOfAccount,
  uHlp,
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TChartOfAccountShowUseCase }

constructor TChartOfAccountShowUseCase.Create(ARepository: IChartOfAccountRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TChartOfAccountShowUseCase.Execute(APK, ATenantId: Int64): TChartOfAccountShowDTO;
var
  lChartOfAccountFound: Shared<TChartOfAccount>;
begin
  // Localizar Registro
  lChartOfAccountFound := FRepository.Show(APK, ATenantId);
  if not Assigned(lChartOfAccountFound.Value) then
    raise Exception.Create(Format(RECORD_NOT_FOUND_WITH_ID, [APK]));

  // Retornar DTO
  Result := TChartOfAccountShowDTO.FromEntity(lChartOfAccountFound.Value);
end;

class function TChartOfAccountShowUseCase.Make(ARepository: IChartOfAccountRepository): IChartOfAccountShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
