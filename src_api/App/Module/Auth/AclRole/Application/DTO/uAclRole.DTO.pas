unit uAclRole.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TAclRoleDTO = class
  private
    Fname: string;
    Ftenant_id: Int64;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagIgnore]
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;
  end;

implementation

end.
