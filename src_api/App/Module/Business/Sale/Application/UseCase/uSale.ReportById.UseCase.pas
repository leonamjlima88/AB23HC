unit uSale.ReportById.UseCase;

interface

uses
  uSale.Repository.Interfaces,
  System.Classes,
  uOutPutFileStream,
  uTenant.Repository.Interfaces;

type
  ISaleReportByIdUseCase = Interface
    ['{2F8B6914-856A-43F5-9648-07A9F3D27C13}']
    function Execute(AId, ATenantId: Int64): IOutPutFileStream;
  end;

  TSaleReportByIdUseCase = class(TInterfacedObject, ISaleReportByIdUseCase)
  private
    FRepository: ISaleRepository;
    FTenantRepository: ITenantRepository;
    constructor Create(ARepository: ISaleRepository; ATenantRepository: ITenantRepository);
  public
    class function Make(ARepository: ISaleRepository; ATenantRepository: ITenantRepository): ISaleReportByIdUseCase;
    function Execute(AId, ATenantId: Int64): IOutPutFileStream;
  end;

implementation

uses
  uSmartPointer,
  uSale,
  uSale.ReportById,
  uZLMemTable.Interfaces,
  uMemTable.Factory,
  System.SysUtils;

{ TSaleReportByIdUseCase }

constructor TSaleReportByIdUseCase.Create(ARepository: ISaleRepository; ATenantRepository: ITenantRepository);
begin
  inherited Create;
  FRepository       := ARepository;
  FTenantRepository := ATenantRepository;
end;

function TSaleReportByIdUseCase.Execute(AId, ATenantId: Int64): IOutPutFileStream;
var
  lSale: IZLMemTable;
  lSaleItem: IZLMemTable;
begin
  // Obter dados para gerar relatório
  lSale     := TMemTableFactory.Make;
  lSaleItem := TMemTableFactory.Make;
  FRepository.DataForReportById(AId, ATenantId, lSale, lSaleItem);

  // Gerar PDF e retornar Stream
  Result := TSaleReportById.Make(
    FTenantRepository.Show(ATenantId),
    lSale,
    lSaleItem
  ).Execute;
end;

class function TSaleReportByIdUseCase.Make(ARepository: ISaleRepository; ATenantRepository: ITenantRepository): ISaleReportByIdUseCase;
begin
  Result := Self.Create(ARepository, ATenantRepository);
end;

end.
