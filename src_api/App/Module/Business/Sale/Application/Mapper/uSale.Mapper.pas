unit uSale.Mapper;

interface

uses
  uMapper.Interfaces,
  uSale,
  uSale.DTO,
  uSale.Show.DTO;

type
  TSaleMapper = class(TInterfacedObject, IMapper)
  public
    class function SaleDtoToEntity(ASaleDTO: TSaleDTO): TSale;
    class function EntityToSaleShowDto(ASale: TSale): TSaleShowDTO;
  end;

implementation

uses
  uSaleItem,
  XSuperObject,
  uLegalEntityNumber.VO,
  System.SysUtils,
  uApplication.Types,
  uSaleItem.Base.DTO;

{ TSaleMapper }

class function TSaleMapper.EntityToSaleShowDto(ASale: TSale): TSaleShowDTO;
var
  lSaleShowDTO: TSaleShowDTO;
  lI: Integer;
begin
  if not Assigned(ASale) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lSaleShowDTO := TSaleShowDTO.FromJSON(ASale.AsJSON);

  // Tratar campos específicos
  lSaleShowDTO.person_name                      := ASale.person.name;
  lSaleShowDTO.seller_name                      := ASale.seller.name;
  lSaleShowDTO.sum_sale_item_total              := ASale.sum_sale_item_total;
  lSaleShowDTO.sum_sale_payment_amount          := ASale.sum_sale_payment_amount;
  lSaleShowDTO.payment_total                    := ASale.payment_total;
  lSaleShowDTO.created_by_acl_user_name         := ASale.created_by_acl_user.name;
  lSaleShowDTO.updated_by_acl_user_name         := ASale.updated_by_acl_user.name;

  // Tratar campos específicos SaleItem
  for lI := 0 to Pred(lSaleShowDTO.sale_item_list.Count) do
  begin
    With lSaleShowDTO.sale_item_list.Items[lI] do
    begin
      product_name      := ASale.sale_item_list.Items[lI].product.name;
      product_unit_id   := ASale.sale_item_list.Items[lI].product_unit.id;
      product_unit_name := ASale.sale_item_list.Items[lI].product_unit.name;
      subtotal          := ASale.sale_item_list.Items[lI].subtotal;
      total             := ASale.sale_item_list.Items[lI].total;
    end;
  end;

  // Tratar campos específicos SalePayment
  for lI := 0 to Pred(lSaleShowDTO.sale_payment_list.Count) do
  begin
    With lSaleShowDTO.sale_payment_list.Items[lI] do
    begin
      bank_account_name := ASale.sale_payment_list.Items[lI].bank_account.name;
      document_name     := ASale.sale_payment_list.Items[lI].document.name;
    end;
  end;

  Result := lSaleShowDTO;
end;

class function TSaleMapper.SaleDtoToEntity(ASaleDTO: TSaleDTO): TSale;
var
  lSale: TSale;
begin
  // Mapear campos por JSON
  lSale := TSale.FromJSON(ASaleDTO.AsJSON);

  Result := lSale;
end;

end.
