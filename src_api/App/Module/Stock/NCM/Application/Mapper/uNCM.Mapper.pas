unit uNCM.Mapper;

interface

uses
  uMapper.Interfaces,
  uNCM,
  uNCM.DTO,
  uNCM.Show.DTO;

type
  TNCMMapper = class(TInterfacedObject, IMapper)
  public
    class function NCMDtoToEntity(ANCMDTO: TNCMDTO): TNCM;
    class function EntityToNCMShowDto(ANCM: TNCM): TNCMShowDTO;
  end;

implementation

uses
  XSuperObject;

{ TNCMMapper }

class function TNCMMapper.EntityToNCMShowDto(ANCM: TNCM): TNCMShowDTO;
var
  lNCMShowDTO: TNCMShowDTO;
begin
  // Mapear campos por JSON
  lNCMShowDTO := TNCMShowDTO.FromJSON(ANCM.AsJSON);

  // Tratar campos específicos
  lNCMShowDTO.created_by_acl_user_name := ANCM.created_by_acl_user.name;
  lNCMShowDTO.updated_by_acl_user_name := ANCM.updated_by_acl_user.name;

  Result := lNCMShowDTO;
end;

class function TNCMMapper.NCMDtoToEntity(ANCMDTO: TNCMDTO): TNCM;
var
  lNCM: TNCM;
begin
  // Mapear campos por JSON
  lNCM := TNCM.FromJSON(ANCMDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lNCM;
end;

end.
