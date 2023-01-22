unit uBusinessProposal.ReportById.UseCase;

interface

uses
  uBusinessProposal.Repository.Interfaces,
  System.Classes,
  uOutPutFileStream,
  uTenant.Repository.Interfaces;

type
  IBusinessProposalReportByIdUseCase = Interface
    ['{005833E1-6CF9-4F5B-8292-A45FF05EDB1F}']
    function Execute(AId, ATenantId: Int64): IOutPutFileStream;
  end;

  TBusinessProposalReportByIdUseCase = class(TInterfacedObject, IBusinessProposalReportByIdUseCase)
  private
    FRepository: IBusinessProposalRepository;
    FTenantRepository: ITenantRepository;
    constructor Create(ARepository: IBusinessProposalRepository; ATenantRepository: ITenantRepository);
  public
    class function Make(ARepository: IBusinessProposalRepository; ATenantRepository: ITenantRepository): IBusinessProposalReportByIdUseCase;
    function Execute(AId, ATenantId: Int64): IOutPutFileStream;
  end;

implementation

uses
  uSmartPointer,
  uBusinessProposal,
  uBusinessProposal.ReportById,
  uZLMemTable.Interfaces,
  uMemTable.Factory,
  System.SysUtils;

{ TBusinessProposalReportByIdUseCase }

constructor TBusinessProposalReportByIdUseCase.Create(ARepository: IBusinessProposalRepository; ATenantRepository: ITenantRepository);
begin
  inherited Create;
  FRepository       := ARepository;
  FTenantRepository := ATenantRepository;
end;

function TBusinessProposalReportByIdUseCase.Execute(AId, ATenantId: Int64): IOutPutFileStream;
var
  lBusinessProposal: IZLMemTable;
  lBusinessProposalItem: IZLMemTable;
begin
  // Obter dados para gerar relatório
  lBusinessProposal     := TMemTableFactory.Make;
  lBusinessProposalItem := TMemTableFactory.Make;
  FRepository.DataForReportById(AId, ATenantId, lBusinessProposal, lBusinessProposalItem);

  // Gerar PDF e retornar Stream
  Result := TBusinessProposalReportById.Make(
    FTenantRepository.Show(ATenantId),
    lBusinessProposal,
    lBusinessProposalItem
  ).Execute;
end;

class function TBusinessProposalReportByIdUseCase.Make(ARepository: IBusinessProposalRepository; ATenantRepository: ITenantRepository): IBusinessProposalReportByIdUseCase;
begin
  Result := Self.Create(ARepository, ATenantRepository);
end;

end.
