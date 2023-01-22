unit uBusinessProposal.UpdateAndShow.UseCase;

interface

uses
  uBusinessProposal.DTO,
  uBusinessProposal.Show.DTO,
  uBusinessProposal.Repository.Interfaces;

type
  IBusinessProposalUpdateAndShowUseCase = Interface
    ['{6B0F625C-F1A9-419D-94BD-CA9C580F2D0C}']
    function Execute(AInput: TBusinessProposalDTO; APK: Int64): TBusinessProposalShowDTO;
  end;

  TBusinessProposalUpdateAndShowUseCase = class(TInterfacedObject, IBusinessProposalUpdateAndShowUseCase)
  private
    FRepository: IBusinessProposalRepository;
    constructor Create(ARepository: IBusinessProposalRepository);
  public
    class function Make(ARepository: IBusinessProposalRepository): IBusinessProposalUpdateAndShowUseCase;
    function Execute(AInput: TBusinessProposalDTO; APK: Int64): TBusinessProposalShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uBusinessProposal,
  XSuperObject,
  System.SysUtils,
  uBusinessProposal.Mapper,
  uApplication.Types;

{ TBusinessProposalUpdateAndShowUseCase }

constructor TBusinessProposalUpdateAndShowUseCase.Create(ARepository: IBusinessProposalRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBusinessProposalUpdateAndShowUseCase.Execute(AInput: TBusinessProposalDTO; APK: Int64): TBusinessProposalShowDTO;
var
  lBusinessProposalToUpdate: Shared<TBusinessProposal>;
  lBusinessProposalUpdated: Shared<TBusinessProposal>;
begin
  // Carregar dados em Entity
  lBusinessProposalToUpdate := TBusinessProposalMapper.BusinessProposalDtoToEntity(AInput);
  With lBusinessProposalToUpdate.Value do
  begin
    id := APK;
    BeforeSaveAndValidate(esUpdate);
  end;

  // Atualizar e Localizar registro atualizado
  FRepository.Update(lBusinessProposalToUpdate, APK, true);
  lBusinessProposalUpdated := FRepository.Show(APK, AInput.tenant_id);

  // Retornar DTO
  Result := TBusinessProposalMapper.EntityToBusinessProposalShowDto(lBusinessProposalUpdated.Value);
end;

class function TBusinessProposalUpdateAndShowUseCase.Make(ARepository: IBusinessProposalRepository): IBusinessProposalUpdateAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
