unit uTaxRule.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  System.Generics.Collections,
  uTaxRule.Base.DTO,
  uTaxRuleState.Base.DTO;

type
  TTaxRuleDTO = class(TTaxRuleBaseDTO)
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
