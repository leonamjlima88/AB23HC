unit uBankAccount.SQLBuilder.MySQL;

interface

uses
  uBankAccount.SQLBuilder,
  uBankAccount.SQLBuilder.Interfaces;

type
  TBankAccountSQLBuilderMySQL = class(TBankAccountSQLBuilder, IBankAccountSQLBuilder)
  public
    constructor Create;
    class function Make: IBankAccountSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TBankAccountSQLBuilderMySQL }

constructor TBankAccountSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TBankAccountSQLBuilderMySQL.Make: IBankAccountSQLBuilder;
begin
  Result := Self.Create;
end;

function TBankAccountSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `bank_account` ( '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            '   `name` varchar(100) NOT NULL, '+
            '   `bank_id` bigint(20) NOT NULL, '+
            '   `note` text, '+
            '   `created_at` datetime DEFAULT NULL, '+
            '   `updated_at` datetime DEFAULT NULL, '+
            '   `created_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `tenant_id` bigint NOT NULL, '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `bank_account_idx_name` (`name`), '+
            '   KEY `bank_account_fk_created_by_acl_user_id` (`created_by_acl_user_id`), '+
            '   KEY `bank_account_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`), '+
            '   KEY `bank_account_fk_bank_id` (`bank_id`), '+
            '   KEY `bank_account_fk_tenant_id` (`tenant_id`), '+
            '   CONSTRAINT `bank_account_fk_bank_id` FOREIGN KEY (`bank_id`) REFERENCES `bank` (`id`), '+
            '   CONSTRAINT `bank_account_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `bank_account_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `bank_account_fk_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenant` (`id`) '+
            ' ) ';
end;

function TBankAccountSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
