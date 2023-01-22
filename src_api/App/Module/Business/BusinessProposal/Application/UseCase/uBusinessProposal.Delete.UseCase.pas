unit uBusinessProposal.Delete.UseCase;

interface

uses
  uBusinessProposal.Repository.Interfaces;

type
  IBusinessProposalDeleteUseCase = Interface
    ['{690C7637-0B2E-438D-9B4D-CEFFDFE418CD}']
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

  TBusinessProposalDeleteUseCase = class(TInterfacedObject, IBusinessProposalDeleteUseCase)
  private
    FRepository: IBusinessProposalRepository;
    constructor Create(ARepository: IBusinessProposalRepository);
  public
    class function Make(ARepository: IBusinessProposalRepository): IBusinessProposalDeleteUseCase;
    function Execute(APK, ATenantId: Int64): Boolean;
  end;

implementation

{ TBusinessProposalDeleteUseCase }

constructor TBusinessProposalDeleteUseCase.Create(ARepository: IBusinessProposalRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBusinessProposalDeleteUseCase.Execute(APK, ATenantId: Int64): Boolean;
begin
  // Deletar Registro
  Result := FRepository.Delete(APK, ATenantId);
end;

class function TBusinessProposalDeleteUseCase.Make(ARepository: IBusinessProposalRepository): IBusinessProposalDeleteUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
