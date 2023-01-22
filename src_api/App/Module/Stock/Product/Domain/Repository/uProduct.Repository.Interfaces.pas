unit uProduct.Repository.Interfaces;

interface

uses
  uBase.Repository.Interfaces,
  uProduct;

type
  IProductRepository = interface(IBaseRepository)
    ['{B598F0C8-B708-43C4-B015-84BAA83575D1}']
    function Show(AId, ATenantId: Int64): TProduct;
    function ShowBySkuOrEanCode(ASkuOrEanCode: String; ATenantId: Int64): TProduct;
  end;

implementation

end.


