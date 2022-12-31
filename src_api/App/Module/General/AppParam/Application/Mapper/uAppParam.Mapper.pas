unit uAppParam.Mapper;

interface

uses
  uMapper.Interfaces,
  uAppParam,
  uAppParam.DTO,
  uAppParam.Show.DTO;

type
  TAppParamMapper = class(TInterfacedObject, IMapper)
  public
    class function AppParamDtoToEntity(AAppParamDTO: TAppParamDTO): TAppParam;
    class function EntityToAppParamShowDto(AAppParam: TAppParam): TAppParamShowDTO;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TAppParamMapper }

class function TAppParamMapper.EntityToAppParamShowDto(AAppParam: TAppParam): TAppParamShowDTO;
var
  lAppParamShowDTO: TAppParamShowDTO;
begin
  if not Assigned(AAppParam) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lAppParamShowDTO := TAppParamShowDTO.FromJSON(AAppParam.AsJSON);

  Result := lAppParamShowDTO;
end;

class function TAppParamMapper.AppParamDtoToEntity(AAppParamDTO: TAppParamDTO): TAppParam;
var
  lAppParam: TAppParam;
begin
  // Mapear campos por JSON
  lAppParam := TAppParam.FromJSON(AAppParamDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lAppParam;
end;

end.
