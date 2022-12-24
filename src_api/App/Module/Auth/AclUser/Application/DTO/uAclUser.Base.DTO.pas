unit uAclUser.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TAclUserBaseDTO = class
  private
    Fname: string;
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

    [SwagNumber]
    [SwagProp('acl_role_id', 'Perfil ID', true)]
    property acl_role_id: Int64 read Facl_role_id write Facl_role_id;

    [SwagNumber]
    [SwagProp('is_superuser', 'Super usuário. [0=Falso,1=Verdadeiro]')]
    property is_superuser: SmallInt read Fis_superuser write Fis_superuser;
  end;

implementation

end.
