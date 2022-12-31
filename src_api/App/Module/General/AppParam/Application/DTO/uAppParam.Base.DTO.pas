unit uAppParam.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TAppParamBaseDTO = class
  private
    Ftitle: String;
    Fvalue: String;
    Ftenant_id: Int64;
    Facl_role_id: Int64;
    Fgroup_name: String;
  public
    [SwagIgnore]
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;

    [SwagNumber]
    [SwagProp('acl_role_id', 'ID do perfil', false)]
    property acl_role_id: Int64 read Facl_role_id write Facl_role_id;

    [SwagString(255)]
    [SwagProp('group_name', 'Grupo', true)]
    property group_name: String read Fgroup_name write Fgroup_name;

    [SwagString(255)]
    [SwagProp('title', 'Título do parâmetro', true)]
    property title: String read Ftitle write Ftitle;

    [SwagString]
    [SwagProp('value', 'Conteúdo do parâmetro', false)]
    property value: String read Fvalue write Fvalue;
  end;

implementation

end.
