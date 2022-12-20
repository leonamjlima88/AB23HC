unit uProduct.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  uProduct.Base.DTO;

type
  TProductDTO = class(TProductBaseDTO)
  private
    Fcreated_by_acl_user_id: Int64;
    Fupdated_by_acl_user_id: Int64;
    Ftenant_id: Int64;
  public
    [SwagIgnore]
    property created_by_acl_user_id: Int64 read Fcreated_by_acl_user_id write Fcreated_by_acl_user_id;
    [SwagIgnore]
    property updated_by_acl_user_id: Int64 read Fupdated_by_acl_user_id write Fupdated_by_acl_user_id;
    [SwagIgnore]
    property tenant_id: Int64 read Ftenant_id write Ftenant_id;
  end;

implementation

end.
