unit uBusinessProposal.Index.UseCase;

interface

uses
  uBusinessProposal.Repository.Interfaces,
  uPageFilter,
  uIndexResult;

type
  IBusinessProposalIndexUseCase = Interface
    ['{2A45D0F7-31B5-4901-900F-35E5C015F2BF}']
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

  TBusinessProposalIndexUseCase = class(TInterfacedObject, IBusinessProposalIndexUseCase)
  private
    FRepository: IBusinessProposalRepository;
    constructor Create(ARepository: IBusinessProposalRepository);
  public
    class function Make(ARepository: IBusinessProposalRepository): IBusinessProposalIndexUseCase;
    function Execute(APageFilter: IPageFilter): IIndexResult;
  end;

implementation

{ TBusinessProposalIndexUseCase }

constructor TBusinessProposalIndexUseCase.Create(ARepository: IBusinessProposalRepository);
begin
  inherited Create;
  FRepository := ARepository;
end;

function TBusinessProposalIndexUseCase.Execute(APageFilter: IPageFilter): IIndexResult;
begin
  Result := FRepository.Index(APageFilter);
end;

class function TBusinessProposalIndexUseCase.Make(ARepository: IBusinessProposalRepository): IBusinessProposalIndexUseCase;
begin
  Result := Self.Create(ARepository);
end;

end.
