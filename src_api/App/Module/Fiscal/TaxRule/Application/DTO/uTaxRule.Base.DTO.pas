unit uTaxRule.Base.DTO;

interface

uses
  GBSwagger.Model.Attributes,
  System.Generics.Collections,
  uTaxRuleState.Base.DTO;

type
  TTaxRuleBaseDTO = class
  private
    Fname: string;
    Fis_final_customer: SmallInt;
    Foperation_type_id: Int64;
    Fcreated_by_acl_user_id: Int64;
    Fupdated_by_acl_user_id: Int64;

    // OneToMany
    Ftax_rule_state_list: TObjectList<TTaxRuleStateBaseDTO>;
  public
    constructor Create;
    destructor Destroy; override;

    [SwagString(100)]
    [SwagProp('name', 'Nome', true)]
    property name: string read Fname write Fname;

    [SwagNumber]
    [SwagProp('operation_type_id', 'ID do tipo de operação', false)]
    property operation_type_id: Int64 read Foperation_type_id write Foperation_type_id;

    [SwagNumber(0,1)]
    [SwagProp('is_final_customer', 'Consumidor final? [0=False, 1=True]')]
    property is_final_customer: SmallInt read Fis_final_customer write Fis_final_customer;

    // OneToMany
    property tax_rule_state_list: TObjectList<TTaxRuleStateBaseDTO> read Ftax_rule_state_list write Ftax_rule_state_list;
  end;

implementation

{ TTaxRuleBaseDTO }

constructor TTaxRuleBaseDTO.Create;
begin
  Ftax_rule_state_list := TObjectList<TTaxRuleStateBaseDTO>.Create;
end;

destructor TTaxRuleBaseDTO.Destroy;
begin
  if Assigned(Ftax_rule_state_list) then Ftax_rule_state_list.Free;
  inherited;
end;

end.
