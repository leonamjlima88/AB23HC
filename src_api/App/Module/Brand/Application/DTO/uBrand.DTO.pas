unit uBrand.DTO;

interface

uses
  GBSwagger.Model.Attributes;

type
  TBrandDTO = class
  private
    Fname: string;
    Fcreated_by_acl_user_id: Int64;
    Fupdated_by_acl_user_id: Int64;
  public
    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;
    [SwagIgnore]
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    [SwagIgnore]
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;
  end;

implementation

end.
