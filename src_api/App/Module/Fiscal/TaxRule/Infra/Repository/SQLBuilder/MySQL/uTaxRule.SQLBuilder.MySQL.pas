unit uTaxRule.SQLBuilder.MySQL;

interface

uses
  uTaxRule.SQLBuilder.Interfaces,
  uTaxRule.SQLBuilder;

type
  TTaxRuleSQLBuilderMySQL = class(TTaxRuleSQLBuilder, ITaxRuleSQLBuilder)
  public
    constructor Create;
    class function Make: ITaxRuleSQLBuilder;

    // TaxRule
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TTaxRuleSQLBuilderMySQL }

constructor TTaxRuleSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TTaxRuleSQLBuilderMySQL.Make: ITaxRuleSQLBuilder;
begin
  Result := Self.Create;
end;

function TTaxRuleSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `tax_rule` ( '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            '   `name` varchar(100) NOT NULL, '+
            '   `operation_type_id` bigint(20) NOT NULL, '+
            '   `is_final_customer` tinyint(4) DEFAULT NULL, '+
            '   `created_at` datetime DEFAULT NULL, '+
            '   `updated_at` datetime DEFAULT NULL, '+
            '   `created_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `tenant_id` bigint NOT NULL, '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `tax_rule_idx_name` (`name`), '+
            '   KEY `tax_rule_fk_operation_type_id` (`operation_type_id`), '+
            '   KEY `tax_rule_fk_created_by_acl_user_id` (`created_by_acl_user_id`), '+
            '   KEY `tax_rule_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`), '+
            '   KEY `tax_rule_fk_tenant_id` (`tenant_id`), '+
            '   CONSTRAINT `tax_rule_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `tax_rule_fk_operation_type_id` FOREIGN KEY (`operation_type_id`) REFERENCES `operation_type` (`id`), '+
            '   CONSTRAINT `tax_rule_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `tax_rule_fk_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenant` (`id`) '+
            ' ) ';
end;

function TTaxRuleSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
