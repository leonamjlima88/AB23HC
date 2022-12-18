unit uChartOfAccount.Delete.UseCase;

interface

uses
  uChartOfAccount.Repository.Interfaces;

type
  IChartOfAccountDeleteUseCase = Interface
    ['{596944D4-AC7E-4612-8539-C7B4EF1316F5}']
    function Execute(APK: Int64): Boolean;
  end;

  TChartOfAccountDeleteUseCase = class(TInterfacedObject, IChartOfAccountDeleteUseCase)
  private
    FRepository: IChartOfAccountRepository;
    constructor Create(ARepository: IChartOfAccountRepository);
  public
    class function Make(ARepository: IChartOfAccountRepository): IChartOfAccountDeleteUseCase;
    function Execute(APK: Int64): Boolean;
  end;

implementation

{ TChartOfAccountDeleteUseCase }

constructor TChartOfAccountDeleteUseCase.Create(ARepository: IChartOfAccountRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TChartOfAccountDeleteUseCase.Execute(APK: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK);
end;

class function TChartOfAccountDeleteUseCase.Make(ARepository: IChartOfAccountRepository): IChartOfAccountDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
