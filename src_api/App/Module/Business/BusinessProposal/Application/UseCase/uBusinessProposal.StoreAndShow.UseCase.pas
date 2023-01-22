unit uBusinessProposal.StoreAndShow.UseCase;

interface

uses
  uBusinessProposal.DTO,
  uBusinessProposal.Show.DTO,
  uBusinessProposal.Repository.Interfaces;

type
  IBusinessProposalStoreAndShowUseCase = Interface
    ['{146E30F9-7B71-4523-8E76-302FFFC4A05A}']
    function Execute(AInput: TBusinessProposalDTO): TBusinessProposalShowDTO;
  end;

  TBusinessProposalStoreAndShowUseCase = class(TInterfacedObject, IBusinessProposalStoreAndShowUseCase)
  private
    FRepository: IBusinessProposalRepository;
    constructor Create(ARepository: IBusinessProposalRepository);
  public
    class function Make(ARepository: IBusinessProposalRepository): IBusinessProposalStoreAndShowUseCase;
    function Execute(AInput: TBusinessProposalDTO): TBusinessProposalShowDTO;
  end;

implementation

uses
  uSmartPointer,
  uBusinessProposal,
  XSuperObject,
  uLegalEntityNumber.VO,
  uBusinessProposal.Mapper,
  uApplication.Types;

{ TBusinessProposalStoreAndShowUseCase }

constructor TBusinessProposalStoreAndShowUseCase.Create(ARepository: IBusinessProposalRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBusinessProposalStoreAndShowUseCase.Execute(AInput: TBusinessProposalDTO): TBusinessProposalShowDTO;
var
  lBusinessProposalToStore: Shared<TBusinessProposal>;
  lBusinessProposalStored: Shared<TBusinessProposal>;
  lPK: Int64;
begin
  // Carregar dados em Entity
  lBusinessProposalToStore := TBusinessProposalMapper.BusinessProposalDtoToEntity(AInput);
  lBusinessProposalToStore.Value.BeforeSaveAndValidate(esStore);

  // Incluir e Localizar registro incluso
  lPK                     := FRepository.Store(lBusinessProposalToStore, true);
  lBusinessProposalStored := FRepository.Show(lPK, AInput.tenant_id);

  // Retornar DTO
  Result := TBusinessProposalMapper.EntityToBusinessProposalShowDto(lBusinessProposalStored.Value);
end;

class function TBusinessProposalStoreAndShowUseCase.Make(ARepository: IBusinessProposalRepository): IBusinessProposalStoreAndShowUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
