unit uSale.SQLBuilder.MySQL;

interface

uses
  uSale.SQLBuilder.Interfaces,
  uSale.SQLBuilder;

type
  TSaleSQLBuilderMySQL = class(TSaleSQLBuilder, ISaleSQLBuilder)
  public
    constructor Create;
    class function Make: ISaleSQLBuilder;

    // Sale
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TSaleSQLBuilderMySQL }

constructor TSaleSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TSaleSQLBuilderMySQL.Make: ISaleSQLBuilder;
begin
  Result := Self.Create;
end;

function TSaleSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `sale` ( '+
            ' `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            ' `person_id` bigint(20) DEFAULT NULL, '+
            ' `seller_id` bigint(20) NOT NULL, '+
            ' `note` text, '+
            ' `internal_note` text, '+
            ' `status` tinyint(4) NOT NULL COMMENT ''[0..2] 0-Pendente, 1-Aprovada, 2-Cancelada'', '+
            ' `sum_sale_item_total` decimal(18,4) DEFAULT NULL, '+
            ' `sum_sale_payment_amount` decimal(18,4) DEFAULT NULL, '+
            ' `payment_discount` decimal(18,4) DEFAULT NULL, '+
            ' `payment_increase` decimal(18,4) DEFAULT NULL, '+
            ' `total` decimal(18,4) DEFAULT NULL, '+
            ' `created_at` datetime DEFAULT NULL, '+
            ' `updated_at` datetime DEFAULT NULL, '+
            ' `created_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            ' `updated_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            ' `tenant_id` bigint NOT NULL, '+
            ' PRIMARY KEY (`id`), '+
            ' KEY `sale_fk_created_by_acl_user_id` (`created_by_acl_user_id`), '+
            ' KEY `sale_fk_updated_by_acl_role_id` (`updated_by_acl_user_id`), '+
            ' KEY `sale_fk_person_id` (`person_id`), '+
            ' KEY `sale_fk_seller_id` (`seller_id`), '+
            ' KEY `sale_idx_status` (`status`), '+
            ' KEY `sale_fk_tenant_id` (`tenant_id`), '+
            ' CONSTRAINT `sale_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            ' CONSTRAINT `sale_fk_person_id` FOREIGN KEY (`person_id`) REFERENCES `person` (`id`), '+
            ' CONSTRAINT `sale_fk_seller_id` FOREIGN KEY (`seller_id`) REFERENCES `person` (`id`), '+
            ' CONSTRAINT `sale_fk_updated_by_acl_role_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
            ' CONSTRAINT `sale_fk_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenant` (`id`) '+
            ' ) ';
end;

function TSaleSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
