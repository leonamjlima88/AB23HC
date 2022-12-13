unit uAclUser.Auth.Login.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TAclUserAuthLoginDTO = class
  private
    Flogin_password: string;
    Flogin: string;
  public
    [SwagString(100)]
    [SwagProp('login', 'Login', true)]
    property login: string read Flogin write Flogin;

    [SwagString(100)]
    [SwagProp('login_password', 'Senha', true)]
    property login_password: string read Flogin_password write Flogin_password;
  end;

implementation

end.
