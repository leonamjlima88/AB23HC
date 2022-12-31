unit uAclUser.Auth.Me.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uAclUser.Base.DTO,
  uApplication.Types,
  System.Generics.Collections,
  uAppParam.DTO;

type
  TAclUserAuthMeDTO = class(TAclUserBaseDTO)
  private
    Ftenant_id: Int64;
    Fid: Int64;
    Flast_token: string;
    Flast_expiration: TDateTime;

    // OneToMany
    Fapp_param_list: TObjectList<TAppParamDTO>;
  public
    constructor Create;
    destructor Destroy; override;

    [SwagNumber]
    [SwagProp('id', 'ID', true)]
    property id: Int64 read Fid write Fid;

    [SwagString(100)]
    [SwagProp('last_token', 'last_token', true)]
    property last_token: string read Flast_token write Flast_token;

    [SwagDate(DATETIME_DISPLAY_FORMAT)]
    [SwagProp('last_expiration', CREATED_AT_DISPLAY, true)]
    property last_expiration: TDateTime read Flast_expiration write Flast_expiration;

    [SwagNumber]
    [SwagProp('tenant_id', 'tenant_id', true)]
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;

    // OneToMany
    property app_param_list: TObjectList<TAppParamDTO> read Fapp_param_list write Fapp_param_list;
  end;

  {$REGION 'Swagger DOC'}
  TAclUserAuthMeResponseDTO = class(TResponseDTO)
  private
    Fdata: TAclUserAuthMeDTO;
  public
    property data: TAclUserAuthMeDTO read Fdata write Fdata;
  end;
  {$ENDREGION}

implementation

{ TAclUserAuthMeDTO }

constructor TAclUserAuthMeDTO.Create;
begin
  Fapp_param_list := TObjectList<TAppParamDTO>.Create;
end;

destructor TAclUserAuthMeDTO.Destroy;
begin
  if Assigned(Fapp_param_list) then Fapp_param_list.Free;
  inherited;
end;

end.
