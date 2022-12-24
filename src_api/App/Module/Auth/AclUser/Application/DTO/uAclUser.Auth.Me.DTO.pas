unit uAclUser.Auth.Me.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO,
  uAclUser.Base.DTO,
  uApplication.Types;

type
  TAclUserAuthMeDTO = class(TAclUserBaseDTO)
  private
    Ftenant_id: Int64;
    Fid: Int64;
    Flast_token: string;
    Flast_expiration: TDateTime;
  public
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

end.
