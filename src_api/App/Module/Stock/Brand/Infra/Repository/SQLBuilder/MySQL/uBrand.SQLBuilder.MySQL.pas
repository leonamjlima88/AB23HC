unit uBrand.SQLBuilder.MySQL;

interface

uses
  uBrand.SQLBuilder,
  uBrand.SQLBuilder.Interfaces;

type
  TBrandSQLBuilderMySQL = class(TBrandSQLBuilder, IBrandSQLBuilder)
  public
    constructor Create;
    class function Make: IBrandSQLBuilder;
    function ScriptCreateTable: String; override;
    function ScriptSeedTable: String; override;
  end;

implementation

uses
  cqlbr.interfaces;

{ TBrandSQLBuilderMySQL }

constructor TBrandSQLBuilderMySQL.Create;
begin
  inherited Create;
  FDBName := dbnMySQL;
end;

class function TBrandSQLBuilderMySQL.Make: IBrandSQLBuilder;
begin
  Result := Self.Create;
end;

function TBrandSQLBuilderMySQL.ScriptCreateTable: String;
begin
  Result :=
    ' CREATE TABLE `brand` (                                                                                              '+
    '   `id` bigint(20) NOT NULL AUTO_INCREMENT,                                                                          '+
    '   `name` varchar(100) NOT NULL,                                                                                     '+
    '   `created_at` datetime DEFAULT NULL,                                                                               '+
    '   `updated_at` datetime DEFAULT NULL,                                                                               '+
    '   `created_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   `updated_by_acl_user_id` bigint(20) DEFAULT NULL,                                                                 '+
    '   `tenant_id` bigint NOT NULL,                                                                                      '+
    '   PRIMARY KEY (`id`),                                                                                               '+
    '   KEY `brand_idx_name` (`name`),                                                                                    '+
    '   KEY `brand_fk_created_by_acl_user_id` (`created_by_acl_user_id`),                                                 '+
    '   KEY `brand_fk_updated_by_brand_id` (`updated_by_acl_user_id`),                                                    '+
    '   KEY `brand_fk_tenant_id` (`tenant_id`),                                                                           '+
    '   CONSTRAINT `brand_fk_created_by_acl_user_id` FOREIGN KEY (`created_by_acl_user_id`) REFERENCES `acl_user` (`id`), '+
    '   CONSTRAINT `brand_fk_updated_by_brand_id` FOREIGN KEY (`updated_by_acl_user_id`) REFERENCES `acl_user` (`id`),    '+
    '   CONSTRAINT `brand_fk_tenant_id` FOREIGN KEY (`tenant_id`) REFERENCES `tenant` (`id`)                              '+
    ' )                                                                                                                   ';
end;

function TBrandSQLBuilderMySQL.ScriptSeedTable: String;
begin
  Result := '';
end;

end.
