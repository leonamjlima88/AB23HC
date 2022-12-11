unit uAclRole.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  /// <summary>
  ///   DTO para Criar/Atualizar registro
  /// </summary>
  TAclRoleDTO = class
  private
    Fname: string;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;
  end;

implementation

end.
