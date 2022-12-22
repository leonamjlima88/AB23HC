unit uProduct.Mapper;

interface

uses
  uMapper.Interfaces,
  uProduct,
  uProduct.DTO,
  uProduct.Show.DTO;

type
  TProductMapper = class(TInterfacedObject, IMapper)
  public
    class function ProductDtoToEntity(AProductDTO: TProductDTO): TProduct;
    class function EntityToProductShowDto(AProduct: TProduct): TProductShowDTO;
  end;

implementation

uses
  XSuperObject;

{ TProductMapper }

class function TProductMapper.EntityToProductShowDto(AProduct: TProduct): TProductShowDTO;
var
  lProductShowDTO: TProductShowDTO;
begin
  // Mapear campos por JSON
  lProductShowDTO := TProductShowDTO.FromJSON(AProduct.AsJSON);

  // Tratar campos específicos
  lProductShowDTO.unit_name                := AProduct.&unit.name;
  lProductShowDTO.category_name            := AProduct.category.name;
  lProductShowDTO.brand_name               := AProduct.brand.name;
  lProductShowDTO.size_name                := AProduct.size.name;
  lProductShowDTO.storage_location_name    := AProduct.storage_location.name;
  lProductShowDTO.created_by_acl_user_name := AProduct.created_by_acl_user.name;
  lProductShowDTO.updated_by_acl_user_name := AProduct.updated_by_acl_user.name;

  Result := lProductShowDTO;
end;

class function TProductMapper.ProductDtoToEntity(AProductDTO: TProductDTO): TProduct;
var
  lProduct: TProduct;
begin
  // Mapear campos por JSON
  lProduct := TProduct.FromJSON(AProductDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lProduct;
end;

end.
