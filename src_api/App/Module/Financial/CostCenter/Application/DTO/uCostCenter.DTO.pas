unit uCostCenter.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uCostCenter.Base.DTO;

type
  TCostCenterDTO = class(TCostCenterBaseDTO)
  private
    Fcreated_by_acl_user_id: Int64;
    Fupdated_by_acl_user_id: Int64;
  public
    [SwagIgnore]
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    [SwagIgnore]
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;
  end;

implementation

end.