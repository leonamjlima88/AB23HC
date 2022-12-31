unit uCFOP.Mapper;

interface

uses
  uMapper.Interfaces,
  uCFOP,
  uCFOP.DTO,
  uCFOP.Show.DTO;

type
  TCFOPMapper = class(TInterfacedObject, IMapper)
  public
    class function CFOPDtoToEntity(ACFOPDTO: TCFOPDTO): TCFOP;
    class function EntityToCFOPShowDto(ACFOP: TCFOP): TCFOPShowDTO;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TCFOPMapper }

class function TCFOPMapper.EntityToCFOPShowDto(ACFOP: TCFOP): TCFOPShowDTO;
var
  lCFOPShowDTO: TCFOPShowDTO;
begin
  if not Assigned(ACFOP) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lCFOPShowDTO := TCFOPShowDTO.FromJSON(ACFOP.AsJSON);

  // Tratar campos específicos
  lCFOPShowDTO.created_by_acl_user_name := ACFOP.created_by_acl_user.name;
  lCFOPShowDTO.updated_by_acl_user_name := ACFOP.updated_by_acl_user.name;

  Result := lCFOPShowDTO;
end;

class function TCFOPMapper.CFOPDtoToEntity(ACFOPDTO: TCFOPDTO): TCFOP;
var
  lCFOP: TCFOP;
begin
  // Mapear campos por JSON
  lCFOP := TCFOP.FromJSON(ACFOPDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lCFOP;
end;

end.
