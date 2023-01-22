unit uSale.ReportById;

interface

uses
  uZLMemTable.Interfaces,
  uOutPutFileStream,
  uTenant;

type
  ISaleReportById = Interface
    ['{9E3E7488-C464-40A5-A339-5EABEC023DAC}']
    /// <summary> Gerar PDF e retornar Objeto com Stream </summary>
    function Execute: IOutPutFileStream;
  end;

  TSaleReportById = class(TInterfacedObject, ISaleReportById)
  private
    FTenant: TTenant;
    FSale,
    FSaleItem: IZLMemTable;
    constructor Create(ATenant: TTenant; ASale, ASaleItem: IZLMemTable);
  public
    /// <summary> Instânciar classe com parâmetros </summary>
    /// <param name="ATenant"> [TTenant] </param>
    /// <param name="ASale"> [IZLMemTable] </param>
    /// <param name="ASaleItem"> [IZLMemTable] </param>
    /// <returns> Interface </returns>
    class function Make(ATenant: TTenant; ASale, ASaleItem: IZLMemTable): ISaleReportById;
    function Execute: IOutPutFileStream;
  end;

implementation

uses
  uHlp,
  System.SysUtils,
  uSale.Report;

{ TSaleReportById }

constructor TSaleReportById.Create(ATenant: TTenant; ASale, ASaleItem: IZLMemTable);
begin
  inherited Create;
  FTenant               := ATenant;
  FSale     := ASale;
  FSaleItem := ASaleItem;
end;

function TSaleReportById.Execute: IOutPutFileStream;
begin
  Result := TSaleReport.Execute(
    FTenant,
    FSale,
    FSaleItem
  );
end;

class function TSaleReportById.Make(ATenant: TTenant; ASale, ASaleItem: IZLMemTable): ISaleReportById;
begin
  Result := Self.Create(ATenant, ASale, ASaleItem);
end;

end.

