unit uAclUser.Auth.ChangePassword.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  /// <summary>
  ///   DTO Mudar a senha
  /// </summary>
  TAclUserAuthChangePasswordDTO = class
  private
    Fcurrent_password: string;
    Fnew_password: string;
    Flogin: string;
  public
    [SwagString(100)]
    [SwagProp('login', 'Login', true)]
    property login: string read Flogin write Flogin;

    [SwagString(100)]
    [SwagProp('current_password', 'Senha atual', true)]
    property current_password: string read Fcurrent_password write Fcurrent_password;

    [SwagString(100)]
    [SwagProp('new_password', 'Nova Senha', true)]
    property new_password: string read Fnew_password write Fnew_password;
  end;

implementation

end.
