unit uSize.Mapper;

interface

uses
  uMapper.Interfaces,
  uSize,
  uSize.DTO,
  uSize.Show.DTO;

type
  TSizeMapper = class(TInterfacedObject, IMapper)
  public
    class function SizeDtoToEntity(ASizeDTO: TSizeDTO): TSize;
    class function EntityToSizeShowDto(ASize: TSize): TSizeShowDTO;
  end;

implementation

uses
  XSuperObject;

{ TSizeMapper }

class function TSizeMapper.EntityToSizeShowDto(ASize: TSize): TSizeShowDTO;
var
  lSizeShowDTO: TSizeShowDTO;
begin
  // Mapear campos por JSON
  lSizeShowDTO := TSizeShowDTO.FromJSON(ASize.AsJSON);

  // Tratar campos específicos
  lSizeShowDTO.created_by_acl_user_name := ASize.created_by_acl_user.name;
  lSizeShowDTO.updated_by_acl_user_name := ASize.updated_by_acl_user.name;

  Result := lSizeShowDTO;
end;

class function TSizeMapper.SizeDtoToEntity(ASizeDTO: TSizeDTO): TSize;
var
  lSize: TSize;
begin
  // Mapear campos por JSON
  lSize := TSize.FromJSON(ASizeDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lSize;
end;

end.
