unit uChartOfAccount.SQLBuilder.MySQL;

interface

uses
  uChartOfAccount.SQLBuilder,
  uChartOfAccount.SQLBuilder.Interfaces;

type
  TChartOfAccountSQLBuilderMySQL = class(TChartOfAccountSQLBuilder, IChartOfAccountSQLBuilder)
  public
    constructor Create;
    class function Make: IChartOfAccountSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TChartOfAccountSQLBuilderMySQL }

constructor TChartOfAccountSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TChartOfAccountSQLBuilderMySQL.Make: IChartOfAccountSQLBuilder;
begin
  Result := Self.Create;
end;

function TChartOfAccountSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `chart_of_account` ( '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            '   `name` varchar(100) NOT NULL, '+
            '   `hierarchy_code` varchar(100) NOT NULL, '+
            '   `is_analytical` tinyint(4) DEFAULT NULL, '+
            '   `note` text, '+
            '   `created_at` datetime DEFAULT NULL, '+
            '   `updated_at` datetime DEFAULT NULL, '+
            '   `created_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `tenant_id` bigint NOT NULL, '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `chart_of_account_idx_name` (`name`), '+
            '   KEY `chart_of_account_idx_hierarchy_code` (`hierarchy_code`), '+
            '   KEY `chart_of_account_idx_is_analytical` (`is_analytical`), '+
            '   KEY `chart_of_account_fk_created_by_acl_user_id` (`created_by_acl_user_id`), '+
            '   KEY `chart_of_account_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`), '+
            '   KEY `chart_of_account_fk_tenant_id` (`tenant_id`), '+
            '   CONSTRAINT `chart_of_account_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `chart_of_account_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `chart_of_account_fk_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenant` (`id`) '+
            ' ) ';
end;

function TChartOfAccountSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
