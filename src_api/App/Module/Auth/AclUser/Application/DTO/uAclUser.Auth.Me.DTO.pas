unit uAclUser.Auth.Me.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uResponse.DTO;

type
  TAclUserAuthMeDTO = class
  private
    Fname: string;
    Ftoken: string;
    Flogin: string;
    Ftenant_id: Int64;
  public
    [SwagString(100)]
    [SwagProp('name', 'name', true)]
    property name: string read Fname write Fname;

    [SwagString(100)]
    [SwagProp('login', 'login', true)]
    property login: string read Flogin write Flogin;

    [SwagString(100)]
    [SwagProp('token', 'token', true)]
    property token: string read Ftoken write Ftoken;

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
