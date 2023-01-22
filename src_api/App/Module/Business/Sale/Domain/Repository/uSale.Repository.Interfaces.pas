unit uSale.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uSale,
  uZLMemTable.Interfaces;

type
  ISaleRepository = interface(IBaseRepository)
    ['{398848B6-D2C4-4F9A-BA65-3B2815A24B4F}']
    function Show(AId, ATenantId: Int64): TSale;
    function Store(ASale: TSale; AManageTransaction: Boolean): Int64; overload;
    function Update(ASale: TSale; AId: Int64; AManageTransaction: Boolean): Boolean; overload;
    function DataForReportById(AId, ATenantId: Int64; ASale, ASaleItem: IZLMemTable): ISaleRepository;
  end;

implementation

end.


