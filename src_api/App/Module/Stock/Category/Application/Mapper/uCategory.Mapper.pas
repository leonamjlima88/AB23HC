unit uCategory.Mapper;

interface

uses
  uMapper.Interfaces,
  uCategory,
  uCategory.DTO,
  uCategory.Show.DTO;

type
  TCategoryMapper = class(TInterfacedObject, IMapper)
  public
    class function CategoryDtoToEntity(ACategoryDTO: TCategoryDTO): TCategory;
    class function EntityToCategoryShowDto(ACategory: TCategory): TCategoryShowDTO;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TCategoryMapper }

class function TCategoryMapper.EntityToCategoryShowDto(ACategory: TCategory): TCategoryShowDTO;
var
  lCategoryShowDTO: TCategoryShowDTO;
begin
  if not Assigned(ACategory) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lCategoryShowDTO := TCategoryShowDTO.FromJSON(ACategory.AsJSON);

  // Tratar campos específicos
  lCategoryShowDTO.created_by_acl_user_name := ACategory.created_by_acl_user.name;
  lCategoryShowDTO.updated_by_acl_user_name := ACategory.updated_by_acl_user.name;

  Result := lCategoryShowDTO;
end;

class function TCategoryMapper.CategoryDtoToEntity(ACategoryDTO: TCategoryDTO): TCategory;
var
  lCategory: TCategory;
begin
  // Mapear campos por JSON
  lCategory := TCategory.FromJSON(ACategoryDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lCategory;
end;

end.
