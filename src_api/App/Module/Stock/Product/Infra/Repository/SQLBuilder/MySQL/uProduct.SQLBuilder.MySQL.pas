unit uProduct.SQLBuilder.MySQL;

interface

uses
  uProduct.SQLBuilder,
  uProduct.SQLBuilder.Interfaces;

type
  TProductSQLBuilderMySQL = class(TProductSQLBuilder, IProductSQLBuilder)
  public
    constructor Create;
    class function Make: IProductSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TProductSQLBuilderMySQL }

constructor TProductSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TProductSQLBuilderMySQL.Make: IProductSQLBuilder;
begin
  Result := Self.Create;
end;

function TProductSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result := ' CREATE TABLE `product` ( '+
            '   `id` bigint(20) NOT NULL AUTO_INCREMENT, '+
            '   `name` varchar(255) NOT NULL, '+
            '   `simplified_name` varchar(30) NOT NULL, '+
            '   `type` tinyint(4) DEFAULT NULL COMMENT ''[0-product, 1-service]'', '+
            '   `sku_code` varchar(45) DEFAULT NULL, '+
            '   `ean_code` varchar(45) DEFAULT NULL, '+
            '   `manufacturing_code` varchar(45) DEFAULT NULL, '+
            '   `identification_code` varchar(45) DEFAULT NULL, '+
            '   `cost` decimal(18,4) DEFAULT NULL, '+
            '   `marketup` decimal(18,4) DEFAULT NULL, '+
            '   `price` decimal(18,4) DEFAULT NULL, '+
            '   `current_quantity` decimal(18,4) DEFAULT NULL, '+
            '   `minimum_quantity` decimal(18,4) DEFAULT NULL, '+
            '   `maximum_quantity` decimal(18,4) DEFAULT NULL, '+
            '   `gross_weight` decimal(18,4) DEFAULT NULL, '+
            '   `net_weight` decimal(18,4) DEFAULT NULL, '+
            '   `packing_weight` decimal(18,4) DEFAULT NULL, '+
            '   `is_to_move_the_stock` tinyint(4) DEFAULT NULL, '+
            '   `is_product_for_scales` tinyint(4) DEFAULT NULL, '+
            '   `internal_note` text, '+
            '   `complement_note` text, '+
            '   `is_discontinued` tinyint(4) DEFAULT NULL, '+
            '   `unit_id` bigint(20) NOT NULL, '+
            '   `ncm_id` bigint(20) NOT NULL, '+
            '   `category_id` bigint(20) DEFAULT NULL, '+
            '   `brand_id` bigint(20) DEFAULT NULL, '+
            '   `size_id` bigint(20) DEFAULT NULL, '+
            '   `storage_location_id` bigint(20) DEFAULT NULL, '+
            '   `genre` tinyint(4) DEFAULT NULL COMMENT ''[0-none, 1-masculine, 2-feminine, 3-unissex]'', '+
            '   `created_at` datetime DEFAULT NULL, '+
            '   `updated_at` datetime DEFAULT NULL, '+
            '   `created_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL, '+
            '   `tenant_id` bigint NOT NULL, '+
            '   PRIMARY KEY (`id`), '+
            '   KEY `product_fk_unit_id` (`unit_id`), '+
            '   KEY `product_fk_ncm_id` (`ncm_id`), '+
            '   KEY `product_fk_category_id` (`category_id`), '+
            '   KEY `product_fk_brand_id` (`brand_id`), '+
            '   KEY `product_fk_size_id` (`size_id`), '+
            '   KEY `product_fk_storage_location_id` (`storage_location_id`), '+
            '   KEY `product_fk_created_by_acl_user_id` (`created_by_acl_user_id`), '+
            '   KEY `product_fk_updated_by_acl_user_id` (`updated_by_acl_user_id`), '+
            '   KEY `product_idx_name` (`name`), '+
            '   KEY `product_fk_tenant_id` (`tenant_id`), '+
            '   CONSTRAINT `product_fk_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `brand` (`id`) , '+
            '   CONSTRAINT `product_fk_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) , '+
            '   CONSTRAINT `product_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`) , '+
            '   CONSTRAINT `product_fk_size_id` FOREIGN KEY (`size_id`) REFERENCES `size` (`id`) , '+
            '   CONSTRAINT `product_fk_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `storage_location` (`id`) , '+
            '   CONSTRAINT `product_fk_unit_id` FOREIGN KEY (`unit_id`) REFERENCES `unit` (`id`) , '+
            '   CONSTRAINT `product_fk_ncm_id` FOREIGN KEY (`ncm_id`) REFERENCES `ncm` (`id`) , '+
            '   CONSTRAINT `product_fk_updated_by_acl_user_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`),  '+
            '   CONSTRAINT `product_fk_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenant` (`id`) '+
            ' )  ';
end;

function TProductSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
