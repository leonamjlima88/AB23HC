unit uTaxRule.Mapper;

interface

uses
  uMapper.Interfaces,
  uTaxRule,
  uTaxRule.DTO,
  uTaxRule.Show.DTO;

type
  TTaxRuleMapper = class(TInterfacedObject, IMapper)
  public
    class function TaxRuleDtoToEntity(ATaxRuleDTO: TTaxRuleDTO): TTaxRule;
    class function EntityToTaxRuleShowDto(ATaxRule: TTaxRule): TTaxRuleShowDTO;
  end;

implementation

uses
  XSuperObject,
  System.SysUtils,
  uApplication.Types;

{ TTaxRuleMapper }

class function TTaxRuleMapper.EntityToTaxRuleShowDto(ATaxRule: TTaxRule): TTaxRuleShowDTO;
var
  lTaxRuleShowDTO: TTaxRuleShowDTO;
  lI: Integer;
begin
  if not Assigned(ATaxRule) then
    raise Exception.Create(RECORD_NOT_FOUND);

  // Mapear campos por JSON
  lTaxRuleShowDTO := TTaxRuleShowDTO.FromJSON(ATaxRule.AsJSON);

  // Tratar campos específicos
  lTaxRuleShowDTO.created_by_acl_user_name := ATaxRule.created_by_acl_user.name;
  lTaxRuleShowDTO.updated_by_acl_user_name := ATaxRule.updated_by_acl_user.name;
  for lI := 0 to Pred(Result.tax_rule_state_list.Count) do
  begin
    Result.tax_rule_state_list.Items[lI].cfop_code := ATaxRule.tax_rule_state_list.Items[lI].cfop.code;
    Result.tax_rule_state_list.Items[lI].cfop_name := ATaxRule.tax_rule_state_list.Items[lI].cfop.name;
  end;

  Result := lTaxRuleShowDTO;
end;

class function TTaxRuleMapper.TaxRuleDtoToEntity(ATaxRuleDTO: TTaxRuleDTO): TTaxRule;
var
  lTaxRule: TTaxRule;
begin
  // Mapear campos por JSON
  lTaxRule := TTaxRule.FromJSON(ATaxRuleDTO.AsJSON);

  // Tratar campos específicos
  // ...

  Result := lTaxRule;
end;

end.
