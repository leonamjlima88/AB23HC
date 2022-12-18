unit uPaymentTerm.SQLBuilder.MySQL;

interface

uses
  uPaymentTerm.SQLBuilder,
  uPaymentTerm.SQLBuilder.Interfaces;

type
  TPaymentTermSQLBuilderMySQL = class(TPaymentTermSQLBuilder, IPaymentTermSQLBuilder)
  public
    constructor Create;
    class function Make: IPaymentTermSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TPaymentTermSQLBuilderMySQL }

constructor TPaymentTermSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TPaymentTermSQLBuilderMySQL.Make: IPaymentTermSQLBuilder;
begin
  Result := Self.Create;
end;

function TPaymentTermSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `payment_term` ( '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            '   `name` varchar(100) NOT NULL, '+
            '   `number_of_installments` tinyint(4) DEFAULT NULL, '+
            '   `first_installment_in` tinyint(4) DEFAULT NULL, '+
            '   `interval_between_installments` tinyint(4) DEFAULT NULL, '+
            '   `bank_account_id` bigint(20) NOT NULL, '+
            '   `document_id` bigint(20) NOT NULL, '+
            '   `created_at` datetime DEFAULT NULL, '+
            '   `updated_at` datetime DEFAULT NULL, '+
            '   `created_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `tenant_id` bigint NOT NULL, '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `payment_term_idx_name` (`name`), '+
            '   KEY `payment_term_fk_created_by_acl_user_id` (`created_by_acl_user_id`), '+
            '   KEY `payment_term_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`), '+
            '   KEY `payment_term_fk_bank_account_id` (`bank_account_id`), '+
            '   KEY `payment_term_fk_document_id` (`document_id`), '+
            '   KEY `payment_term_fk_tenant_id` (`tenant_id`), '+
            '   CONSTRAINT `payment_term_fk_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `bank_account` (`id`), '+
            '   CONSTRAINT `payment_term_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `payment_term_fk_document_id` FOREIGN KEY (`document_id`) REFERENCES `document` (`id`), '+
            '   CONSTRAINT `payment_term_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            '   CONSTRAINT `payment_term_fk_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenant` (`id`) '+
            ' ) ';
end;

function TPaymentTermSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
