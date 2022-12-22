unit uBrand.Mapper;

interface

uses
  uMapper.Interfaces,
  uBrand,
  uBrand.DTO,
  uBrand.Show.DTO;

type
  TBrandMapper = class(TInterfacedObject, IMapper)
  public
    class function BrandDtoToEntity(ABrandDTO: TBrandDTO): TBrand;
    class function EntityToBrandShowDto(ABrand: TBrand): TBrandShowDTO;
  end;

implementation

uses
  XSuperObject;

{ TBrandMapper }

class function TBrandMapper.EntityToBrandShowDto(ABrand: TBrand): TBrandShowDTO;
var
  lBrandShowDTO: TBrandShowDTO;
begin
  // Mapear campos por JSON
  lBrandShowDTO := TBrandShowDTO.FromJSON(ABrand.AsJSON);

  // Tratar campos específicos
  lBrandShowDTO.created_by_acl_user_name := ABrand.created_by_acl_user.name;
  lBrandShowDTO.updated_by_acl_user_name := ABrand.updated_by_acl_user.name;

  Result := lBrandShowDTO;
end;

class function TBrandMapper.BrandDtoToEntity(ABrandDTO: TBrandDTO): TBrand;
var
  lBrand: TBrand;
begin
  // Mapear campos por JSON
  lBrand := TBrand.FromJSON(ABrandDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lBrand;
end;

end.
