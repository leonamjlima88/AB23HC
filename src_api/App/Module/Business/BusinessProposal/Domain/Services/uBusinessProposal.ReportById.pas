unit uBusinessProposal.ReportById;

interface

uses
  uZLMemTable.Interfaces,
  uOutPutFileStream,
  uTenant;

type
  IBusinessProposalReportById = Interface
    ['{92F1504C-7A00-475C-A272-93F6B44F4DD3}']
    /// <summary> Gerar PDF e retornar Objeto com Stream </summary>
    function Execute: IOutPutFileStream;
  end;

  TBusinessProposalReportById = class(TInterfacedObject, IBusinessProposalReportById)
  private
    FTenant: TTenant;
    FBusinessProposal,
    FBusinessProposalItem: IZLMemTable;
    constructor Create(ATenant: TTenant; ABusinessProposal, ABusinessProposalItem: IZLMemTable);
  public
    /// <summary> Instânciar classe com parâmetros </summary>
    /// <param name="ATenant"> [TTenant] </param>
    /// <param name="ABusinessProposal"> [IZLMemTable] </param>
    /// <param name="ABusinessProposalItem"> [IZLMemTable] </param>
    /// <returns> Interface </returns>
    class function Make(ATenant: TTenant; ABusinessProposal, ABusinessProposalItem: IZLMemTable): IBusinessProposalReportById;
    function Execute: IOutPutFileStream;
  end;

implementation

uses
  uHlp,
  System.SysUtils,
  uBusinessProposal.Report;

{ TBusinessProposalReportById }

constructor TBusinessProposalReportById.Create(ATenant: TTenant; ABusinessProposal, ABusinessProposalItem: IZLMemTable);
begin
  inherited Create;
  FTenant               := ATenant;
  FBusinessProposal     := ABusinessProposal;
  FBusinessProposalItem := ABusinessProposalItem;
end;

function TBusinessProposalReportById.Execute: IOutPutFileStream;
begin
  Result := TBusinessProposalReport.Execute(
    FTenant,
    FBusinessProposal,
    FBusinessProposalItem
  );
end;

class function TBusinessProposalReportById.Make(ATenant: TTenant; ABusinessProposal, ABusinessProposalItem: IZLMemTable): IBusinessProposalReportById;
begin
  Result := Self.Create(ATenant, ABusinessProposal, ABusinessProposalItem);
end;

end.

