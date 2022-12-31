unit uAppParamMany.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uAppParam.DTO,
  System.Generics.Collections;

type
  TAppParamManyDTO = class
  private
    Fapp_param_list: TObjectList<TAppParamDTO>;
    Ftenant_id: Int64;
    Fgroup_name: String;
  public
    constructor Create;
    destructor Destroy; override;

    [SwagIgnore]
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;

    [SwagString(255)]
    [SwagProp('group_name', 'Grupo', true)]
    property group_name: String read Fgroup_name write Fgroup_name;

    property app_param_list: TObjectList<TAppParamDTO> read Fapp_param_list write Fapp_param_list;
  end;

implementation

{ TAppParamManyDTO }

constructor TAppParamManyDTO.Create;
begin
  Fapp_param_list := TObjectList<TAppParamDTO>.Create;
end;

destructor TAppParamManyDTO.Destroy;
begin
  if Assigned(Fapp_param_list) then Fapp_param_list.Free;
  inherited;
end;

end.
