unit uAclUser.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  /// <summary>
  ///   DTO para Criar/Atualizar registro
  /// </summary>
  TAclUserDTO = class
  private
    Fname: string;
    Flogin_password: string;
    Flogin: string;
    Facl_role_id: Int64;
    Fis_superuser: SmallInt;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagString(100)]
    [SwagProp('login', 'Login', true)]
    property login: string read Flogin write Flogin;

    [SwagString(100)]
    [SwagProp('login_password', 'Senha', true)]
    property login_password: string read Flogin_password write Flogin_password;

    [SwagNumber]
    [SwagProp('acl_role_id', 'Perfil ID', true)]
    property acl_role_id: Int64 read Facl_role_id write Facl_role_id;

    [SwagNumber]
    [SwagProp('is_superuser', 'Super usuário. [0=Falso,1=Verdadeiro]')]
    property is_superuser: SmallInt read Fis_superuser write Fis_superuser;
  end;

implementation

end.
